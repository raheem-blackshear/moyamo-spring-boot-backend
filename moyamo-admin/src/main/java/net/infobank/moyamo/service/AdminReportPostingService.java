package net.infobank.moyamo.service;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.ReportPostingDto;
import net.infobank.moyamo.enumeration.ReportStatus;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.ReportPosting;
import net.infobank.moyamo.repository.ReportPostingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;


@Slf4j
@Service
public class AdminReportPostingService {

	@Autowired
    ReportPostingRepository reportPostingRepository;

    public List<ReportPostingDto> getReportList(Pageable request) {
    	List<ReportPosting> reportPostingList = reportPostingRepository.findAllReportList(request);
    	return reportPostingList.stream().map(ReportPostingDto::of).collect(Collectors.toList());
    }

    public ReportPosting findById(long id) {
    	return reportPostingRepository.findById(id).orElse(null);
    }

    public ReportPosting save(ReportPosting report) {
    	return reportPostingRepository.save(report);
    }

    public Long getReportTotalCount() {
    	return reportPostingRepository.count();
    }

    @Transactional
    public int updateAll(Posting posting, ReportStatus status) {
        return reportPostingRepository.updateAll(posting, status);
    }
}
