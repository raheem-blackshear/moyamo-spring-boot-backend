package net.infobank.moyamo.jobs.notifications;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.configurations.ServiceHost;
import net.infobank.moyamo.dto.OrderDto;
import net.infobank.moyamo.dto.shop.OrderDataDto;
import net.infobank.moyamo.dto.shop.OrderResponseDto;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.shop.Goods;
import net.infobank.moyamo.repository.GoodsRepository;
import net.infobank.moyamo.repository.UserRepository;
import net.infobank.moyamo.service.NotificationService;
import net.infobank.moyamo.service.ShopApiService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
@AllArgsConstructor
@Configuration
public class NotificationJobs {

    private final ShopApiService shopApiService;
    private final UserRepository userRepository;
    private final GoodsRepository goodsRepository;
    private final NotificationService notificationService;

    public class NotificationJob {
        //1시간마다 갱신
        //@Scheduled(cron="*/10 * * * * *")
        @Scheduled(cron="${moyamo.jobs.notification.reaper.cron:0 0 */1 * * *}")
        public void worker() {
            log.debug("NotificationJob");
            notificationService.deleteByLeastRecently();
        }
    }

    private static String createNotiTitle(OrderDataDto.OrderStatus status, String goodsName) {
        String title = goodsName + " 상품이 " + status.getDescription();
        if (status == OrderDataDto.OrderStatus.d1) {
            title += "입니다.";
        } else {
            title += "되었습니다.";
        }
        return title;
    }

    public class DeliveryNotificationJob {
        private final Pattern memberIdPattern = Pattern.compile(".*_(\\d+)");
        private final Map<OrderDataDto.OrderStatus, ZonedDateTime> lastUpdatedAtMap = new ConcurrentHashMap<>();

        @SuppressWarnings({"java:S135", "java:S3776"})
        @Transactional
        @Scheduled(cron="${moyamo.jobs.notification.delivery.cron:0 */10 * * * *}")
        public void worker() {
            log.debug("DeliveryNotificationJob");

            User sender = userRepository.getOne(1L);

            for(OrderDataDto.OrderStatus status : OrderDataDto.OrderStatus.values()) {

                if(!status.isUse()) continue;

                LocalDateTime lastUpdateAt = lastUpdatedAtMap.getOrDefault(status, ZonedDateTime.now().minusMinutes(30)).withZoneSameInstant(ZoneId.of("Asia/Seoul")).toLocalDateTime();

                OrderResponseDto orderResponseDto = shopApiService.requestSearchOrders(status);
                log.info("orderResponseDto : {}", orderResponseDto);
                if(orderResponseDto == null || orderResponseDto.getOrderDatas() == null || orderResponseDto.getOrderDatas().isEmpty())
                    continue;

                LocalDateTime updatedAt = lastUpdateAt;
                List<OrderDataDto> orderDatas = orderResponseDto.getOrderDatas();
                for(OrderDataDto orderDataDto : orderDatas) {
                    if(!orderDataDto.getModDt().isAfter(lastUpdateAt)) {
                        continue;
                    }

                    if(orderDataDto.getModDt().isAfter(updatedAt)) {
                        updatedAt = orderDataDto.getModDt();
                    }

                    Matcher matcher = memberIdPattern.matcher(orderDataDto.getMemId());
                    if(!matcher.find()) {
                        continue;
                    }

                    Long userId = Long.parseLong(matcher.group(1));
                    log.info("send to userId : {}", userId);
                    userRepository.findById(userId).ifPresent(user -> {
                        String goodsNo = orderDataDto.getOrderGoodsDatas().get(0).getGoodsNo();
                        Optional<Goods> optionalGoods = goodsRepository.findById(goodsNo);
                        String imageUrl = optionalGoods.map(Goods::getThumbnail).map(imageResource -> ServiceHost.getS3Url(imageResource.getFilekey()) + "?d=120").orElse(ServiceHost.getLogoUrl());
                        String text = createNotiTitle(status, orderDataDto.getOrderGoodsNm());
                        OrderDto orderDto = new OrderDto(orderDataDto.getOrderNo(), text, imageUrl, sender );
                        log.info("send to user : {}", user);
                        notificationService.afterNewOrder(orderDto, user);
                    });
                }
                lastUpdatedAtMap.put(status, ZonedDateTime.of(updatedAt, ZoneId.of("Asia/Seoul")));
            }
        }
    }


    /**
     * 오래된 알림 삭제 스케쥴
     * @return NotificationJob
     */
    @Bean
    @ConditionalOnProperty(value = "moyamo.jobs.notification.reaper.enable", matchIfMissing = true, havingValue = "true")
    public NotificationJob scheduledJob() {
        return new NotificationJob();
    }

    /**
     * 배송정보 알림 스케쥴
     * @return DeliveryNotificationJob
     */
    @Bean
    @ConditionalOnProperty(value = "moyamo.jobs.notification.delivery.enable", matchIfMissing = true, havingValue = "true")
    public DeliveryNotificationJob deliveryNotificationScheduledJob() {
        return new DeliveryNotificationJob();
    }

}
