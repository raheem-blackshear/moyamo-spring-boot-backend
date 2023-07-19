package net.infobank.moyamo;

import com.google.common.collect.Iterables;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.domain.Event;
import net.infobank.moyamo.domain.EventAction;
import net.infobank.moyamo.domain.EventType;
import net.infobank.moyamo.domain.PostingType;
import net.infobank.moyamo.domain.badge.TopUsers;
import net.infobank.moyamo.interfaces.EventServerInterface;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.repository.statistics.EventWorkRepositoryCustom;
import net.infobank.moyamo.repository.statistics.UserAnalyzeRepositoryCustom;
import net.infobank.moyamo.service.PostingService;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.actuate.autoconfigure.security.servlet.ManagementWebSecurityAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.persistence.Tuple;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@EnableFeignClients(basePackages = "net.infobank.moyamo")
@EnableScheduling
@SpringBootApplication(exclude = { SecurityAutoConfiguration.class, ManagementWebSecurityAutoConfiguration.class })
public class SimdaSchedulerApplication {

    public static void main(String[] args) {
        SpringApplication.run(SimdaSchedulerApplication.class, args);
    }

    @RestController
    public static class DefaultController {

        private final RabbitTemplate template;
        private final UserAnalyzeRepositoryCustom userAnalyzeRepositoryCustom;
        private final EventServerInterface eventServerInterface;
        private final EventWorkRepositoryCustom eventWorkRepositoryCustom;
        private final PostingService postingService;

        public DefaultController(RabbitTemplate template, UserAnalyzeRepositoryCustom userAnalyzeRepositoryCustom, EventServerInterface eventServerInterface, EventWorkRepositoryCustom eventWorkRepositoryCustom, PostingService postingService) {
            this.template = template;
            this.userAnalyzeRepositoryCustom = userAnalyzeRepositoryCustom;
            this.eventServerInterface = eventServerInterface;
            this.eventWorkRepositoryCustom = eventWorkRepositoryCustom;
            this.postingService = postingService;
        }


        @GetMapping(path = "/run")
        public String run(@RequestParam Long from, @RequestParam(defaultValue = "1") Long to, @RequestParam(defaultValue = "POSTING") String eventType, @RequestParam(defaultValue = "question") String type, @RequestParam(required = false) Long timestamp,  @RequestParam(required = false) String content) {
            Event event = Event.builder().action(EventAction.CREATE)
                    .postingType(PostingType.valueOf(type))
                    .owner(from).type(EventType.valueOf(eventType))
                    .timestamp(timestamp).content(content)
                    .cumulative(to.intValue()).build();
            template.convertAndSend(event);
            log.info("event : {}", event);



            return "run";
        }

        boolean initiated = false;

        @GetMapping(path="/top", produces = {"application/json"})
        public List<TopUsers.UserScore> top200() {
            return eventServerInterface.requestGetUserScores();
        }

        @GetMapping(path = "/init")
        public String init(@RequestParam(defaultValue = "1") Long from, @RequestParam(defaultValue = "1000") Long to) {
            if(initiated)
                return "dup";

            int limit = 100;
            initiated = true;
            Optional<Long> optionalTo = Optional.ofNullable(to);
            Optional<Long> optionalFrom = Optional.ofNullable(from);
            List<Tuple> tuples = userAnalyzeRepositoryCustom.findUserIdWithCommentCountList(optionalFrom, optionalTo, limit);

            int i = 0;
            while(!tuples.isEmpty()) {

                if(i++ > 10) {
                    break;
                }

                for(Tuple tuple : tuples) {
                    Long userId = tuple.get(0, Long.class);
                    Integer commentCount = tuple.get(1, Integer.class);
                    if(commentCount > 0) {
                        Event event = Event.builder().type(EventType.COMMENT).action(EventAction.CREATE)
                                .cumulative(commentCount).timestamp(0L).postingType(PostingType.question)
                                .owner(userId).build();
                        template.convertAndSend(event);
                    }
                }

                log.info("from : {}, to : {}", tuples.stream().map(tuple -> tuple.get(0, Long.class)).min(Comparator.naturalOrder()), tuples.stream().map(tuple -> tuple.get(0, Long.class)).max(Comparator.naturalOrder()));
                optionalFrom = tuples.stream().map(tuple -> tuple.get(0, Long.class)).max(Comparator.naturalOrder()).map(f -> f + 1);
                tuples = userAnalyzeRepositoryCustom.findUserIdWithCommentCountList(optionalFrom, optionalTo, limit);
            }

            return "";
        }

        @PostMapping(path="/indexing", produces = {"application/json"})
        public String indexing(@RequestParam(defaultValue = "0") Long sinceId, @RequestParam(defaultValue = "500") Long maxId, @RequestParam(defaultValue = "200") int max) {
            List<EventWorkRepositoryCustom.SimplePosting> postings = eventWorkRepositoryCustom.findPostingList(Posting.class, sinceId, maxId, 1000);
            postingService.indexing(postings.stream().map(EventWorkRepositoryCustom.SimplePosting::getId).collect(Collectors.toList()), max);
            return "end";
        }

        @PostMapping(path="/events", produces = {"application/json"})
        public String events(@RequestParam(defaultValue = "0") Long sinceId, @RequestParam(defaultValue = "500") Long maxId, @RequestParam(defaultValue = "question") String strType) {

            net.infobank.moyamo.enumeration.PostingType postingType = net.infobank.moyamo.enumeration.PostingType.valueOf(strType);
            Class<? extends Posting> clazz = postingType.getClazz();

            int totalPostingCount = 0;
            int totalCommentCount = 0;

            Long cursorId = sinceId;
            while(cursorId != null) {

                log.info("cursorId : {}", cursorId);

                List<EventWorkRepositoryCustom.SimplePosting> postings = eventWorkRepositoryCustom.findPostingList(clazz, cursorId, maxId, 1000);
                List<Long> ids = postings.stream().map(EventWorkRepositoryCustom.SimplePosting::getId).collect(Collectors.toList());

                List<Event> commentEvents = eventWorkRepositoryCustom.findCommentGroupByOwnerList(ids).stream()
                .collect(Collectors.groupingBy(EventWorkRepositoryCustom.SimpleCommentGroupOwner::getOwnerId, Collectors.counting())).entrySet().stream()
                .map(r -> {
                    Long ownerId = r.getKey();
                    Long commentCount = r.getValue();
                    return Event.builder().owner(ownerId).cumulative(commentCount.intValue())
                            .postingType(PostingType.valueOf(postingType.name())).type(EventType.COMMENT).action(EventAction.CREATE)
                            .timestamp(0L).build();
                }).collect(Collectors.toList());


                List<Event> postingEvents = postings.stream().filter(simplePosting -> simplePosting.getOwnerId() != null)
                .collect(Collectors.groupingBy(EventWorkRepositoryCustom.SimplePosting::getOwnerId, Collectors.counting())).entrySet().stream()
                .map(r -> {
                    Long ownerId = r.getKey();
                    Long postingCount  = r.getValue();
                    return Event.builder().owner(ownerId)
                            .postingType(PostingType.valueOf(postingType.name())).type(EventType.POSTING).action(EventAction.CREATE)
                            .cumulative(postingCount.intValue())
                            .timestamp(0L).build();
                }).collect(Collectors.toList());

                cursorId = ids.stream().max(Comparator.naturalOrder()).orElse(null);

                totalPostingCount += postingEvents.size();
                totalCommentCount += commentEvents.size();


                Iterable<Event> events = Iterables.concat(postingEvents, commentEvents);
                events.forEach(event -> template.convertAndSend("event", "", event));
            }

            return String.format("totalPostingCount : %d, totalCommentCount : %d, totalEventCount : %d", totalPostingCount, totalCommentCount, totalPostingCount + totalCommentCount);
        }
    }
}
