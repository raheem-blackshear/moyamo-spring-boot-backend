package net.infobank.moyamo.controller;

import lombok.RequiredArgsConstructor;
import net.infobank.moyamo.dto.PhotoAlbumDto;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.models.PhotoAlbum;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.PhotoAlbumService;
import net.infobank.moyamo.service.PhotoPhotoAlbumService;
import net.infobank.moyamo.service.PostingService;
import net.infobank.moyamo.service.UserService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/rest")
@RequiredArgsConstructor
public class RestAdminPhotoAlbum {


    private final AuthUtils authUtils;
    private final PhotoAlbumService photoAlbumService;
    private final PhotoPhotoAlbumService photoPhotoAlbumService;
    private final PostingService postingService;
    private final UserService userService;

    @RequestMapping("/getPhotoAlbums")
    public ResponseEntity<Map<String, Object>> getPhotoAlbums(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {

        User loginUser = authUtils.getCurrentUser();
        List<PhotoAlbumDto> photoAlbums = photoAlbumService.getPhotoAlbumByUserIdPage(loginUser.getId(),query, PageRequest.of(start / length, length, Sort.by(Sort.Direction.ASC, "id")));
        List<PhotoAlbumDto> allphotoAlbums = photoAlbumService.getPhotoAlbumByUserIdContainsQuery(loginUser.getId(),query);
        int cnt = allphotoAlbums.size();

        Map<String, Object> map = new HashMap<>();
        map.put("data", photoAlbums);
        map.put("totalCnt", cnt);
        map.put("recordsFiltered", cnt);
        map.put("draw", draw);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @RequestMapping("/getPhotoAlbumDetail")
    public ResponseEntity<Map<String, Object>> getPhotoAlbum(@RequestParam("id") Long id, @RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {

        PhotoAlbum photoAlbum = photoAlbumService.getPhotoAlbumById(id);
        List<PostingDto> photos = photoPhotoAlbumService.getPhotoByPhotoAlbumContainsQuery(photoAlbum, query, PageRequest.of(start / length, length, Sort.by(Sort.Direction.DESC, "id")));
        List<PostingDto> allPhotos = photoPhotoAlbumService.getPhotoByPhotoAlbum(photoAlbum, query);
        int cnt = allPhotos.size();
        Map<String, Object> map = new HashMap<>();

        map.put("data", photos);
        map.put("totalCnt", cnt);
        map.put("recordsFiltered", cnt);
        map.put("draw", draw);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @PutMapping(value = "/movePhotos")
    public @ResponseBody ResponseEntity<Map<String, Object>> movePhotos(@RequestParam(value = "photoIds[]") List<Long> ids, @RequestParam("beforeAlbumId") Long beforeAlbumId, @RequestParam("afterAlbumId") Long afterAlbumId) {

        User currentUser = authUtils.getCurrentUser();
        postingService.movePhotoPosting(ids, photoAlbumService.getPhotoAlbumById(beforeAlbumId).getName(), photoAlbumService.getPhotoAlbumById(afterAlbumId).getName(), currentUser, false);
        Map<String, Object> map = new HashMap<>();
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @PutMapping(value = "/copyPhotos")
    public @ResponseBody ResponseEntity<Map<String, Object>> copyPhotos(@RequestParam(value = "photoIds[]") List<Long> ids, @RequestParam("afterAlbumId") Long afterAlbumId) {

        User currentUser = authUtils.getCurrentUser();
        postingService.copyPhotoPosting(ids, Collections.singletonList(photoAlbumService.getPhotoAlbumById(afterAlbumId).getName()), currentUser, false , null);
        Map<String, Object> map = new HashMap<>();
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @PutMapping(value = "/deletePhotos")
    public @ResponseBody ResponseEntity<Map<String, Object>> deletePhotos(@RequestParam(value = "photoIds[]") List<Long> ids, @RequestParam("currentAlbumId") Long currentAlbumId) {

        User currentUser = authUtils.getCurrentUser();
        postingService.deletePhotoPosting(ids, currentUser, photoAlbumService.getPhotoAlbumById(currentAlbumId).getName(), false);
        userService.userIndexing(currentUser.getId());
        Map<String, Object> map = new HashMap<>();
        return new ResponseEntity<>(map, HttpStatus.OK);
    }
}
