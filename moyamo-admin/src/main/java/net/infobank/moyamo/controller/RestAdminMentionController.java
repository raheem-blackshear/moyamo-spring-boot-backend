package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.CommentDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.repository.AdminMentionRepositoryCustom;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/comment/getMentionList")
public class RestAdminMentionController {

    private final AuthUtils authUtils;
    private final AdminMentionRepositoryCustom adminMentionRepositoryCustom;

    @JsonView(Views.WebAdminJsonView.class)
    @GetMapping
    @Transactional(readOnly = true)
    public ResponseEntity<Map<String, Object>> doFindMentionList(
                                                            @RequestParam("draw") int draw,
                                                            @RequestParam("start") int start,
                                                            @RequestParam("length") int length) {
        User user = authUtils.getCurrentUser();
        Map<String, Object> map = new HashMap<>();

        List<CommentDto> reportList = adminMentionRepositoryCustom.findMentionList(user, start, length).stream()
                .map(comment -> CommentDto.of(comment).setPostingId(comment.getPosting().getId())).collect(Collectors.toList());
        long totalCnt = adminMentionRepositoryCustom.getMentionCount(user);
        map.put("recordsTotal", totalCnt);
        map.put("recordsFiltered", totalCnt);
        log.info("start[{}], length[{}], totalCnt[{}], draw[{}]", start, length, totalCnt, draw);
        map.put("draw", draw);
        map.put("data", reportList);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }
}
