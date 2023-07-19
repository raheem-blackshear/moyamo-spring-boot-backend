package net.infobank.moyamo.service;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.repository.ReportPostingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.Tuple;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
public class AdminReportService {

    @Autowired
    private ReportPostingRepository reportPostingRepository;

    public Map<Long, Long> findPostReportCount(List<Long> postingIds) {
        List<Tuple> groups = reportPostingRepository.countGroupByPostings(postingIds);
        return groups.stream().collect(Collectors.toMap(tuple -> (Long)tuple.get(0), tuple -> ((BigDecimal)tuple.get(1)).longValue()));
    }


}
