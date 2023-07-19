package net.infobank.moyamo.controller;

import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.NoticeDto;
import net.infobank.moyamo.dto.ReleaseNoteDto;
import net.infobank.moyamo.enumeration.NoticeStatus;
import net.infobank.moyamo.enumeration.NoticeType;
import net.infobank.moyamo.enumeration.OsType;
import net.infobank.moyamo.form.CreateNoticeVo;
import net.infobank.moyamo.form.UpdateNoticeVo;
import net.infobank.moyamo.service.api.RestNoticeService;
import net.infobank.moyamo.service.api.RestReleaseNoteService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j

@Api(tags= {"3. 설정 - 서비스안내"})

@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/v2/notices")
public class NoticeController {

	private final RestReleaseNoteService<ReleaseNoteDto> releaseNoteService;
	private final RestNoticeService<NoticeDto> noticeService;

	@GetMapping("")
	public CommonResponse<List<NoticeDto>> doFindListByCurrentDate() {
		return new CommonResponse<>(CommonResponseCode.SUCCESS, noticeService.findListByCurrentDate(NoticeStatus.open, NoticeType.notice));
	}

	@GetMapping("/all")
	public CommonResponse<List<NoticeDto>> doFindList() {
		return new CommonResponse<>(CommonResponseCode.SUCCESS, noticeService.findList(NoticeStatus.open, NoticeType.notice));
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


	/**
	 * APP 릴리즈 버전 조회
	 */
	@GetMapping("/apps/release")
	@Transactional(readOnly = true)
    public CommonResponse<ReleaseNoteDto> getReleaseNote(OsType osType, String version) {
        return new CommonResponse<>(CommonResponseCode.SUCCESS, releaseNoteService.findReleaseNote(osType, version));
    }

}
