package net.infobank.moyamo.aspect;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.queue.ReadMessage;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.stereotype.Component;

import java.util.stream.Stream;

@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class PostingAspect {

    @NonNull
    private final AmqpTemplate template;

    /**
     * 조회된 게시글의 읽음 수를 업데이트
     *
     * @param joinPoint  joinPoint
     * @param returnValue 결과 CommonResponse<PostingDto>
     */
    @AfterReturning(value = "execution(net.infobank.moyamo.common.controllers.CommonResponse net.infobank.moyamo.controller.PostingController.doRead*(..) )", returning = "returnValue")
    public void readCountAdvice(JoinPoint joinPoint, CommonResponse<PostingDto> returnValue) {
        if (returnValue != null && returnValue.getResultCode() == CommonResponseCode.SUCCESS.getResultCode()) {
            Stream.of(joinPoint.getArgs()).filter(o -> o instanceof User).findFirst().ifPresent(o -> {
                if(log.isDebugEnabled()) {
                    log.debug("readCountAdvice : {}", returnValue.getResultMessage());
                }
                template.convertAndSend("postingReadQueue", new ReadMessage(returnValue.getResultMessage().getId(), ((User) o).getId()));
            });
        }
    }

}
