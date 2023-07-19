package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.configurations.ServiceHost;
import net.infobank.moyamo.dto.NoticeDto;
import net.infobank.moyamo.enumeration.NoticeType;
import net.infobank.moyamo.form.CreateNoticeVo;
import net.infobank.moyamo.form.UpdateNoticeVo;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Notice;
import net.infobank.moyamo.service.FolderDatePatterns;
import net.infobank.moyamo.service.ImageUploadService;
import net.infobank.moyamo.service.NoticeService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 포스팅 관련 rest api
 *
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/notice")
public class RestAdminNoticeController {

	private final NoticeService noticeService;
	private final ImageUploadService imageUploadService;

	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getEventList")
	public ResponseEntity<Map<String, Object>> getEventList(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
		return this.getList(draw, start, length, query, NoticeType.event);
	}

	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getNoticeList")
	public ResponseEntity<Map<String, Object>> getNoticeList(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
		return this.getList(draw, start, length, query, NoticeType.notice);
	}

	// USER 리스트 조회

    private ResponseEntity<Map<String, Object>> getList(int draw, int start, int length, String query, NoticeType type) {

    	Map<String, Object> map = new HashMap<>();

		List<NoticeDto> list = null;
		if (query == null || query.length()<=0) {
			list = noticeService.findList(type, PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id")));
		}

		Long totalCnt = noticeService.getCount(type);

    	map.put("recordsTotal", totalCnt);
    	map.put("recordsFiltered", totalCnt);
    	log.info("start[{}], length[{}], totalCnt[{}], draw[{}]", start, length, totalCnt, draw);
    	map.put("draw", draw);
    	map.put("data", list);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }

	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/regist")
	@Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> registNotice(@ModelAttribute CreateNoticeVo vo) {
		Map<String, Object> map = new HashMap<>();
		noticeService.createNotice(vo);
		return new ResponseEntity<>(map, HttpStatus.OK);
    }

	//공지 수정
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/modify/{noticeId}")
	@Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> modifyNotice(@PathVariable(name = "noticeId") Long noticeId, @ModelAttribute UpdateNoticeVo vo) {

		Map<String, Object> map = new HashMap<>();
		Notice modifyNotice = noticeService.updateNotice(noticeId, vo);

		noticeService.save(modifyNotice);
		return new ResponseEntity<>(map, HttpStatus.OK);
    }

	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/remove/{noticeId}")
	@Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = Exception.class)
	public ResponseEntity<Map<String, Object>> removeNotice(@PathVariable(name = "noticeId") Long noticeId) {

		Map<String, Object> map = new HashMap<>();
		noticeService.deleteNotice(noticeId);
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	@PostMapping(value = {"/summernote/file"})
    public ResponseEntity<Map<String, Object>> noticeUploadFile(@RequestParam("file") MultipartFile file) throws IOException, InterruptedException {
    	Map<String, Object> map = new HashMap<>();

    	if (file != null && !file.isEmpty()) {
            ImageUploadService.ImageResourceInfo info = imageUploadService.upload(FolderDatePatterns.COMMENTS, file);
            String url = ServiceHost.getS3Url(info.getImageResource().getFilekey());
            map.put("url", url);
        }

    	return new ResponseEntity<>(map, HttpStatus.OK);
    }
}
