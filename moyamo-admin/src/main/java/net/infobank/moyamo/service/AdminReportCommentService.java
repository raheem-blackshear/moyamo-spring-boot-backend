package net.infobank.moyamo.service;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.ReportCommentDto;
import net.infobank.moyamo.enumeration.ReportStatus;
import net.infobank.moyamo.models.Comment;
import net.infobank.moyamo.models.ReportComment;
import net.infobank.moyamo.repository.ReportCommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;


@Slf4j
@Service
public class AdminReportCommentService {

	@Autowired
    ReportCommentRepository reportCommentRepository;

    public List<ReportCommentDto> getReportList(Pageable request) {
    	List<ReportComment> reportPostingList = reportCommentRepository.findAllReportList(request);
    	return reportPostingList.stream().map(ReportCommentDto::of).collect(Collectors.toList());
    }


    @Transactional
    public int updateAll(Comment comment, ReportStatus status) {
        return reportCommentRepository.updateAll(comment, status) ;
    }

    public ReportComment findById(long id) {
    	return reportCommentRepository.findById(id).orElse(null);
    }

    public ReportComment save(ReportComment report) {
    	return reportCommentRepository.save(report);
    }

    public Long getReportTotalCount() {
    	return reportCommentRepository.count();
    }
}
