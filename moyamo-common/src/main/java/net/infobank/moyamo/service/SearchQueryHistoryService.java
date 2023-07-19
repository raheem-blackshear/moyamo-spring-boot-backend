package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.SearchQueryHistory;
import net.infobank.moyamo.queue.SearchGroupingMessage;
import net.infobank.moyamo.repository.SearchQueryHistoryRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;

@Slf4j
@Service
@AllArgsConstructor
public class SearchQueryHistoryService {

    private final SearchQueryHistoryRepository searchQueryHistoryRepository;

    @SuppressWarnings("unused")
    public void upsert(SearchGroupingMessage message) {
        ZonedDateTime now = ZonedDateTime.now().withHour(0).withMinute(0).withSecond(0).withNano(0);
        SearchQueryHistory searchQueryHistory = searchQueryHistoryRepository.find(now, message.getQuery())
        .map(history -> {
            history.increment(message.getCount());
            return history;
        }).orElse(new SearchQueryHistory(now, message.getQuery(), message.getCount()));
        searchQueryHistoryRepository.save(searchQueryHistory);
    }

    public void find() {
        ZonedDateTime to = ZonedDateTime.now().withHour(0).withMinute(0).withSecond(0).withNano(0);
        ZonedDateTime from = to.minusDays(1L);
        log.info("range : {}", searchQueryHistoryRepository.findGroupListByRange(from, to, PageRequest.of(0, 100)));

    }

}
