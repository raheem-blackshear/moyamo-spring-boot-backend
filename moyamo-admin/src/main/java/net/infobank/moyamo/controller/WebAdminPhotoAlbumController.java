package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.PhotoAlbumDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.PhotoAlbum;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.PhotoAlbumService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminPhotoAlbumController {

    private final AuthUtils authUtils;
    private final PhotoAlbumService photoAlbumService;

    @RequestMapping("/photoAlbum")
    public String photoAlbum(Model model) {
        User user = authUtils.getCurrentUser();
        //앨범 전체목록
        List<String> albums = (user != null && user.getPhotoAlbums() != null) ? photoAlbumService.getPhotoAlbumByUserIdContainsQuery(user.getId(), "").stream().map(PhotoAlbumDto::getName).collect(Collectors.toList()) : Collections.emptyList();
        model.addAttribute("albums", albums);
        model.addAttribute("menuName", "앨범");
        return "/admin/photoAlbum";
    }

    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping(path = "/photoAlbum/modify")
    public ResponseEntity<Map<String, Object>> modifyPhotoAlbum(HttpServletRequest request, Long albumId) {
        Map<String, Object> map = new HashMap<>();
        photoAlbumService.updatePhotoAlbum(authUtils.getCurrentUser(), albumId, request.getParameter("name"));
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @RequestMapping("/photoAlbumDetail")
    public String photoAlbumDetail(@RequestParam("id") Long id, Model model) {
        User user = authUtils.getCurrentUser();
        String name = photoAlbumService.getPhotoAlbumById(id).getName();
        model.addAttribute("menuName", "앨범_"+name);
        model.addAttribute("albumName",name);
        model.addAttribute("albumId",id);
        List<PhotoAlbumDto> photoAlbumDtos = photoAlbumService.getPhotoAlbumByUserIdContainsQuery(user.getId(), "");
        List<String> albums = photoAlbumDtos.stream().map(PhotoAlbumDto::getName).collect(Collectors.toList());
        model.addAttribute("albums", albums);
        model.addAttribute("photoAlbums", photoAlbumDtos);
        return "/admin/photoAlbumDetail";
    }

}
