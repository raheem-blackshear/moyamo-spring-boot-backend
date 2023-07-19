package net.infobank.moyamo.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.NoticeDto;
import net.infobank.moyamo.enumeration.NoticeStatus;
import net.infobank.moyamo.enumeration.NoticeType;
import net.infobank.moyamo.form.CreateNoticeVo;
import net.infobank.moyamo.form.UpdateNoticeVo;
import net.infobank.moyamo.service.api.RestNoticeService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/v2/events")
public class EventController {

	private final RestNoticeService<NoticeDto> noticeService;


	@GetMapping("")
	public CommonResponse<List<NoticeDto>> doFindListByCurrentDate() {
		return new CommonResponse<>(CommonResponseCode.SUCCESS, noticeService.findListByCurrentDate(NoticeStatus.open, NoticeType.event));
	}

	@GetMapping("/all")
	public CommonResponse<List<NoticeDto>> doFindList() {
		return new CommonResponse<>(CommonResponseCode.SUCCESS, noticeService.findList(NoticeStatus.open, NoticeType.event));
	}

	@PostMapping(value="")
	public CommonResponse<NoticeDto> doCreateNotice(CreateNoticeVo vo) {
		return new CommonResponse<>(CommonResponseCode.SUCCESS, noticeService.createNotice(vo));
	}

	@PostMapping(value="/{id}")
	public CommonResponse<NoticeDto> doUpdateNotice(@PathVariable Long id, UpdateNoticeVo vo) {
		return new CommonResponse<>(CommonResponseCode.SUCCESS, noticeService.updateNotice(id, vo));
	}

	@DeleteMapping(value="/{id}")
	public CommonResponse<NoticeDto> doDeleteNotice(@PathVariable Long id) {
		return new CommonResponse<>(CommonResponseCode.SUCCESS, noticeService.deleteNotice(id));
	}

}
