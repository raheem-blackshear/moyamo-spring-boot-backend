package net.infobank.moyamo.jobs.shops;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.repository.GoodsRepository;
import net.infobank.moyamo.service.ShopApiService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Configuration
@AllArgsConstructor
public class ShopJobs {

    private final ShopApiService shopApiService;
    private final GoodsRepository goodsRepository;

    public class GoodsUpdateJob {
        //1시간마다 갱신
        //@Scheduled(cron="*/10 * * * * *")

        @Transactional
        @Scheduled(cron="${moyamo.jobs.shop.goods_update.cron:0 */30 * * * *}")
        public void worker() {
            log.info("GoodsUpdateJob");
            boolean reindex = goodsRepository.count() == 0L;
            shopApiService.syncGoods(null, reindex);
        }
    }

    /**
     * 상품조회
     * @return
     */
    @Bean
    @ConditionalOnProperty(value = "moyamo.jobs.shop.goods_update.enable", matchIfMissing = true, havingValue = "true")
    public GoodsUpdateJob goodsUpdateScheduledJob() {
        return new GoodsUpdateJob();
    }
}
