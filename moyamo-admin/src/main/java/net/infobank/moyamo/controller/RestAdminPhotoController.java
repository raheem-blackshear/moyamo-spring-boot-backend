package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.service.PostingService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
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
@RequestMapping("/rest/photo")
public class RestAdminPhotoController {

    private final AuthUtils authUtils;
    private final PostingService postingService;

    @RequestMapping("/{id}/deletePosting")
    @JsonView(Views.WebAdminJsonView.class)
    public ResponseEntity<Map<String, Object>> deletePosting(@PathVariable long id, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        List<PostingDto> postings = postingService.deletePhotoPosting(Collections.singletonList(id), authUtils.getCurrentUser(), request.getParameter("album"), false);
        map.put("data", postings);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }
}
