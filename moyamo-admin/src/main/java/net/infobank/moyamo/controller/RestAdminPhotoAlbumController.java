package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.PhotoAlbumDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.service.PhotoAlbumService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 포스팅 관련 rest api
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/photoAlbum")
public class RestAdminPhotoAlbumController {

    private final AuthUtils authUtils;
    private final PhotoAlbumService photoAlbumService;

    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping(path = "/getList")
    public ResponseEntity<Map<String, Object>> getList() {
        Map<String, Object> map = new HashMap<>();
        map.put("data", authUtils.getCurrentUser().getPhotoAlbums().stream().map(PhotoAlbumDto::of).collect(Collectors.toList()));
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping(path = "/regist")
    public ResponseEntity<Map<String, Object>> registPhotoAlbum(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        map.put("data", photoAlbumService.createPhotoAlbum(authUtils.getCurrentUser(), request.getParameter("name")));
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping(path = "/{id}/modify")
    public ResponseEntity<Map<String, Object>> modifyPhotoAlbum(@PathVariable long id, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        photoAlbumService.updatePhotoAlbum(authUtils.getCurrentUser(), id, request.getParameter("name"));
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping(path = "/{id}/delete")
    public ResponseEntity<Map<String, Object>> deletePhotoAlbum(@PathVariable long id) {
        Map<String, Object> map = new HashMap<>();
        photoAlbumService.deletePhotoAlbum(authUtils.getCurrentUser(), id);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

}
