package net.infobank.moyamo.aspect;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.domain.Event;
import net.infobank.moyamo.domain.EventAction;
import net.infobank.moyamo.domain.EventType;
import net.infobank.moyamo.domain.PostingType;
import net.infobank.moyamo.dto.CommentDto;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.models.User;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Component;

import java.util.stream.Stream;


@Slf4j
@Aspect
@Component
public class BadgeEventAspect {

    private static final String RABBIT_EXCHANGE = "event";
    private static final String RABBIT_ROUTING_KEY = "#";

    private final RabbitTemplate rabbitTemplate;
    public BadgeEventAspect(AmqpTemplate template) {
        rabbitTemplate = (RabbitTemplate) template;
    }

    @AfterReturning(value = "execution(* net.infobank.moyamo.controller.PostingController.doCreatePosting(..))", returning = "returnValue")
    public void postingEvent(JoinPoint joinPoint, CommonResponse<PostingDto> returnValue) {

        if(log.isDebugEnabled()) {
            log.debug("writePosting aspect : {}, joinPoint : {}", returnValue, joinPoint);
        }

        if(returnValue.getResultCode() == 1000) {
            try {
                Event event = Event.builder().action(EventAction.CREATE)
                        .postingType(PostingType.valueOf(returnValue.getResultMessage().getPostingType().name()))
                        .owner(returnValue.getResultMessage().getOwner().getId()).type(EventType.POSTING).build();
                rabbitTemplate.convertAndSend(RABBIT_EXCHANGE, RABBIT_ROUTING_KEY, event);
            } catch (Exception e) {
                log.error("e : ", e);
            }
        }
    }

    private EventType replyEventFrom(String type) {
        if("adopt".equals(type)) {
            return EventType.ADOPTED;
        } else if("thanks".equals(type)) {
            return EventType.THANKS;
        } else {
            return EventType.REPLY;
        }
    }

    @AfterReturning(value = "execution(* net.infobank.moyamo.controller.PostingController.doCreateComment(..))", returning = "returnValue")
    public void commentEvent(JoinPoint joinPoint, CommonResponse<CommentDto> returnValue) {

        if(log.isDebugEnabled()) {
            log.debug("commentEvent joinPoint : {}", joinPoint);
        }

        if(returnValue.getResultCode() == 1000) {
            try {
                EventType eventType = returnValue.getResultMessage().isFirstComment() ? EventType.FIRST_COMMENT : EventType.COMMENT;
                Event event = Event.builder().action(EventAction.CREATE)
                        .postingType(PostingType.valueOf(returnValue.getResultMessage().getPostingType().name()))
                        .content(returnValue.getResultMessage().getText())
                        .owner(returnValue.getResultMessage().getOwner().getId()).type(eventType).build();
                rabbitTemplate.convertAndSend(RABBIT_EXCHANGE, RABBIT_ROUTING_KEY,event);
            } catch (Exception e) {
                log.error("e : ", e);
            }
        }
    }

    //채택된 사용자 이벤트
    @AfterReturning(value = "execution(* net.infobank.moyamo.controller.CommentController.doCreateReply(..)) || execution(* net.infobank.moyamo.controller.CommentController.doThanks(..))", returning = "returnValue")
    public void replyEvent(JoinPoint joinPoint, CommonResponse<CommentDto> returnValue) {

        if(log.isDebugEnabled()) {
            log.debug("commentEvent joinPoint : {}", joinPoint);
        }

        if(returnValue.getResultCode() == 1000) {
            try {
                Event event = Event.builder().action(EventAction.CREATE)
                        .postingType(PostingType.valueOf(returnValue.getResultMessage().getPostingType().name()))
                        .content(returnValue.getResultMessage().getText())
                        .owner(returnValue.getResultMessage().getOwner().getId()).type(replyEventFrom(returnValue.getResultMessage().getType())).build();
                rabbitTemplate.convertAndSend(RABBIT_EXCHANGE, "#",event);
            } catch (Exception e) {
                log.error("e : ", e);
            }
        }
    }

    @AfterReturning(value = "execution(* net.infobank.moyamo.controller.CommentController.doAdopt(..)) ", returning = "returnValue")
    public void adoptedEvent(JoinPoint joinPoint, CommonResponse<CommentDto> returnValue) {

        if(log.isDebugEnabled()) {
            log.debug("adoptedEvent joinPoint : {}", joinPoint);
        }

        if(returnValue.getResultCode() == 1000) {
            try {
                Event event = Event.builder().action(EventAction.CREATE)
                        .postingType(PostingType.valueOf(returnValue.getResultMessage().getPostingType().name()))
                        .content(returnValue.getResultMessage().getText())
                        .owner(returnValue.getResultMessage().getTargetUserId()).type(replyEventFrom(returnValue.getResultMessage().getType())).build();
                rabbitTemplate.convertAndSend(RABBIT_EXCHANGE, RABBIT_ROUTING_KEY,event);
            } catch (Exception e) {
                log.error("e : ", e);
            }
        }
    }

    @SneakyThrows
    @Around(value = "execution(* net.infobank.moyamo.service.LikePostingService.addLike(..))")
    public Object likeEvent(ProceedingJoinPoint joinPoint) {
        PostingDto posting = (PostingDto) joinPoint.proceed(joinPoint.getArgs());
        try {
            Long ownerId = Stream.of(joinPoint.getArgs()).filter(o -> o instanceof User).findFirst().map(User.class::cast).map(User::getId).orElse(0L);
            Event event = Event.builder().action(EventAction.CREATE)
                    .postingType(PostingType.valueOf(posting.getPostingType().name()))
                    .owner(ownerId)
                    .type(EventType.LIKE).build();
            rabbitTemplate.convertAndSend(RABBIT_EXCHANGE, RABBIT_ROUTING_KEY,event);
        } catch(Exception e) {
            log.error("e : ", e);
        }
        return posting;
    }

}
