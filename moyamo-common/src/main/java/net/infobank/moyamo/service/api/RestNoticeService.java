package net.infobank.moyamo.service.api;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.NoticeDto;
import net.infobank.moyamo.enumeration.NoticeStatus;
import net.infobank.moyamo.enumeration.NoticeType;
import net.infobank.moyamo.form.CreateNoticeVo;
import net.infobank.moyamo.form.UpdateNoticeVo;
import net.infobank.moyamo.service.NoticeService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class RestNoticeService<T extends NoticeDto> {

    private final NoticeService noticeService;

    public T createNotice(CreateNoticeVo vo) {
        return (T)T.of(noticeService.createNotice(vo));
    }

    public T updateNotice(Long id, UpdateNoticeVo vo) {
        return (T)T.of(noticeService.updateNotice(id, vo));
    }

    public List<T> findList(NoticeStatus status, NoticeType type) {
        return noticeService.findList(status, type).stream().map(n -> (T)T.of(n)).collect(Collectors.toList());
    }

    public List<T> findListByCurrentDate(NoticeStatus status, NoticeType type) {
    	return noticeService.findListByCurrentDate(status, type).stream().map(n -> (T)T.of(n)).collect(Collectors.toList());
    }

    public T deleteNotice(Long id) {
        return (T)T.of(noticeService.deleteNotice(id));
    }

}
