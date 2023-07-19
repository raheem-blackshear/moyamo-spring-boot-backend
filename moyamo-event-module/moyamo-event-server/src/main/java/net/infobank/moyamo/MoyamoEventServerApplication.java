package net.infobank.moyamo;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.domain.*;
import net.infobank.moyamo.domain.badge.BoardUserActivity;
import net.infobank.moyamo.domain.badge.NewBadge;
import net.infobank.moyamo.domain.badge.TopUsers;
import net.infobank.moyamo.domain.badge.UserBadges;
import org.apache.kafka.streams.state.QueryableStoreTypes;
import org.apache.kafka.streams.state.ReadOnlyKeyValueStore;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.stream.binder.kafka.streams.InteractiveQueryService;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Sinks;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.function.Supplier;

@Slf4j
@SpringBootApplication
public class MoyamoEventServerApplication {

	private static final String NOT_FOUND = "not found";

	private final InteractiveQueryService interactiveQueryService;
	private final RabbitTemplate template;

	public MoyamoEventServerApplication(InteractiveQueryService interactiveQueryService, RabbitTemplate template) {
		this.interactiveQueryService = interactiveQueryService;
		this.template = template;
	}

	public static void main(String[] args) {
		SpringApplication.run(MoyamoEventServerApplication.class, args);
	}


	@SuppressWarnings("unused")
	@org.springframework.web.bind.annotation.RestController
	public class RestController {

		final Flux<String> directProcessor = Sinks.many().multicast().<String>onBackpressureBuffer().asFlux();
		final Flux<NewBadge> issueBadgeProcessor = Sinks.many().multicast().<NewBadge>onBackpressureBuffer().asFlux();
		final Map<String, String> stores;

		public RestController() {
			stores = new HashMap<>();
			stores.put("question", "user-question-store");
			stores.put("clinic", "user-clinic-store");
			stores.put("magazine", "user-magazine-store");
			stores.put("boast", "user-boast-store");
			stores.put("free", "user-free-store");
		}

		@RequestMapping("/store/{store}")
		public String song(@PathVariable(value="store") String store, @RequestParam(value = "id") Long id) {
			final ReadOnlyKeyValueStore<Long, BoardUserActivity> activity =
					interactiveQueryService.getQueryableStore(stores.getOrDefault(store, ""), QueryableStoreTypes.keyValueStore());

			final BoardUserActivity boardUserActivity = activity.get(id);
			if (boardUserActivity == null) {
				return NOT_FOUND;
			}

			return boardUserActivity.toString();
		}

		@RequestMapping("/badges/{id}")
		public String badge(@PathVariable(value = "id") Long id) {
			final ReadOnlyKeyValueStore<Long, UserBadges> badgeStore =
					interactiveQueryService.getQueryableStore(Stores.USER_BADGE_STORE, QueryableStoreTypes.keyValueStore());

			final UserBadges badges = badgeStore.get(id);
			if (badges == null) {
				return NOT_FOUND;
			}

			return badges.toString();
		}

		@RequestMapping("/top")
		public Iterator<TopUsers.UserScore> top() {
			final ReadOnlyKeyValueStore<String, TopUsers> badgeStore =
					interactiveQueryService.getQueryableStore(Stores.RANKING_TOP_200_STORE, QueryableStoreTypes.keyValueStore());

			final TopUsers badges = badgeStore.get(Keys.RANKING_TOP_200);
			if (badges == null) {
				throw new IllegalArgumentException(NOT_FOUND);
			}

			return badges.iterator();
		}


		@RequestMapping("/event")
		public Event event(@RequestParam Long from, @RequestParam(defaultValue = "1") Long to, @RequestParam(defaultValue = "POSTING") String eventType, @RequestParam(defaultValue = "question") String type, @RequestParam(required = false) Long timestamp,  @RequestParam(required = false) String content) {

			template.setExchange("event");

			Event event = Event.builder().action(EventAction.CREATE)
					.postingType(PostingType.valueOf(type))
					.owner(from).type(EventType.valueOf(eventType))
					.timestamp(timestamp).content(content)
					.cumulative(to.intValue()).build();
			template.convertAndSend(event);

			return event;
		}

		@Bean
		public Supplier<Flux<String>> direct() {
			return () -> this.directProcessor;
		}



	}



}
