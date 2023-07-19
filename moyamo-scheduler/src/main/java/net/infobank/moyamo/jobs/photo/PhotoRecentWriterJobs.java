package net.infobank.moyamo.jobs.photo;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.PhotoRecentWriter;
import net.infobank.moyamo.repository.PhotoRecentWriterRepository;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Configuration
@AllArgsConstructor
public class PhotoRecentWriterJobs {

    private final PhotoRecentWriterRepository photoRecentWriterRepository;

    public class PhotoRecentWriterJob {

        @Transactional
        @Scheduled(cron="${moyamo.jobs.photo.cron:0 */5 * * * *}")
        public void worker() {
            log.info("RecentWriterJob");
            Page<PhotoRecentWriter> pageResult = photoRecentWriterRepository.findAll(PageRequest.of(1, 5000, Sort.by("id").descending()));
            photoRecentWriterRepository.deleteAll(pageResult.getContent());
        }
    }

    /**
     * 상품조회
     * @return PhotoRecentWriterJob
     */
    @Bean
    @ConditionalOnProperty(value = "moyamo.jobs.photo.enable", matchIfMissing = true, havingValue = "true")
    public PhotoRecentWriterJob photoRecentWriterJob() {
        return new PhotoRecentWriterJob();
    }
}
