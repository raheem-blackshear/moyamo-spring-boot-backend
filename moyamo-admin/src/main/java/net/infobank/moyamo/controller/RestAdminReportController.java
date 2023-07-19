package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.ReportCommentDto;
import net.infobank.moyamo.dto.ReportPostingDto;
import net.infobank.moyamo.enumeration.ReportStatus;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.ReportComment;
import net.infobank.moyamo.models.ReportPosting;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.AdminReportCommentService;
import net.infobank.moyamo.service.AdminReportPostingService;
import net.infobank.moyamo.service.PostingService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 포스팅 관련 rest api
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/report")
public class RestAdminReportController {

	private final AuthUtils authUtils;
	private final AdminReportPostingService adminReportPostingService;
	private final AdminReportCommentService adminReportCommentService;
	private final PostingService postingService;

	// 게시글 신고 조회
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getList")
    public ResponseEntity<Map<String, Object>> getList(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
    	Map<String, Object> map = new HashMap<>();

		List<ReportPostingDto> reportList = adminReportPostingService.getReportList(PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id")));
		long totalCnt = adminReportPostingService.getReportTotalCount();
    	map.put("recordsTotal", totalCnt);
    	map.put("recordsFiltered", totalCnt);
    	log.info("start[{}], length[{}], totalCnt[{}], draw[{}]", start, length, totalCnt, draw);
    	map.put("draw", draw);
    	map.put("data", reportList);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }

	// 게시글 신고 조회
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getCommentList")
	public ResponseEntity<Map<String, Object>> getList(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length) {
		Map<String, Object> map = new HashMap<>();

		List<ReportCommentDto> reportList = adminReportCommentService.getReportList(PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id")));
		long totalCnt = adminReportCommentService.getReportTotalCount();
		map.put("recordsTotal", totalCnt);
		map.put("recordsFiltered", totalCnt);
		log.info("start[{}], length[{}], totalCnt[{}], draw[{}]", start, length, totalCnt, draw);
		map.put("draw", draw);
		map.put("data", reportList);

		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	// 신고 상태 변경
	@JsonView(Views.WebAdminJsonView.class)
	@PostMapping(path = "/{id}/changeStatus")
	public ResponseEntity<Map<String, Object>> changeStatus(@PathVariable long id, @RequestParam ReportStatus reportStatus, @RequestParam long reportId) {
		Map<String, Object> map = new HashMap<>();

		User loginUser = authUtils.getCurrentUser();
		log.info("ReportID : {}, PostingID : {}, ChangeStatus : {}", reportId, id, reportStatus);
		ReportPosting report = adminReportPostingService.findById(reportId);
		adminReportPostingService.updateAll(report.getRelation().getPosting(), reportStatus);
		boolean isBlind = reportStatus.equals(ReportStatus.BLOCK);
		postingService.blindPosting(id, loginUser, isBlind);

		map.put("resultCode", "1000");
		map.put("data", "");
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	// 신고 상태 변경
	@JsonView(Views.WebAdminJsonView.class)
	@PostMapping(path = "/{id}/changeCommentStatus")
	public ResponseEntity<Map<String, Object>> changeCommentStatus(@PathVariable long id, @RequestParam ReportStatus reportStatus, @RequestParam long reportId) {
		Map<String, Object> map = new HashMap<>();

		User loginUser = authUtils.getCurrentUser();
		log.info("ReportID : {}, PostingID : {}, ChangeStatus : {}", reportId, id, reportStatus);
		ReportComment report = adminReportCommentService.findById(reportId);
		adminReportCommentService.updateAll(report.getRelation().getComment(), reportStatus);


		boolean isBlind = reportStatus.equals(ReportStatus.BLOCK);
		postingService.blindComment(id, loginUser, isBlind);

		map.put("resultCode", "1000");
		map.put("data", "");
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
}
