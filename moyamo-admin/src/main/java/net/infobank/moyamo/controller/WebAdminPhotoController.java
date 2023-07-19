package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.exception.MoyamoGlobalException;
import net.infobank.moyamo.form.CreatePhotoVo;
import net.infobank.moyamo.form.UpdatePhotoVo;
import net.infobank.moyamo.models.PhotoAlbum;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.AdminPostingService;
import net.infobank.moyamo.service.PostingService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

@SuppressWarnings("unused")
@Slf4j
@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminPhotoController {

    private static final String MENUNAME_FIELD = "menuName";
    private static final String REDIRECT_PREFIX = "redirect:";
    private static final String PHOTO_PAGE = "admin/photo";
    private static final String POSTING_TYPE_FIELD = "postingType";
    private static final String REPEATER_LIST_PREFIX = "repeater-list[";
    private static final String REPEATER_DESCRIPTION_SUFFIX = "][descriptions]";
    private static final String ALBUM_FIELD = "album";

    private final AuthUtils authUtils;
    private final PostingService postingService;
    private final AdminPostingService adminPostingService;

    @Transactional
    @RequestMapping(path = "photo")
    public String index(Model model, HttpServletRequest request) {

        model.addAttribute(MENUNAME_FIELD, "포토");
        model.addAttribute(POSTING_TYPE_FIELD, PostingType.photo);
        User loginUser = authUtils.getCurrentUser();
        model.addAttribute("user", loginUser.getId());

        //선택된 앨범명
        if(request.getParameter(ALBUM_FIELD) == null) {
            model.addAttribute(ALBUM_FIELD, "전체");
        } else {
            model.addAttribute(ALBUM_FIELD, request.getParameter(ALBUM_FIELD));
        }

        User user = authUtils.getCurrentUser();
        String page = request.getParameter("page");

        return PHOTO_PAGE;
    }


    private int getContentsLength(HttpServletRequest request) {
        String ret = "";
        Map<String, String[]> param = request.getParameterMap();
        for (String key : param.keySet()) {
            if (key.contains(REPEATER_LIST_PREFIX) && key.indexOf(REPEATER_DESCRIPTION_SUFFIX, 1) > -1) {
                ret = key.substring(REPEATER_LIST_PREFIX.length(), (key.length()-key.indexOf(REPEATER_DESCRIPTION_SUFFIX)));
            }
        }

        return "".equals(ret) ? 0 : Integer.parseInt(ret) + 1;
    }

    @RequestMapping("/registPhoto")
    public String registPosting(HttpServletRequest request
            ,@RequestPart(value="repeater-list[0][files]", required=false) MultipartFile file0
            ,@RequestPart(value="repeater-list[1][files]", required=false) MultipartFile file1
            ,@RequestPart(value="repeater-list[2][files]", required=false) MultipartFile file2
            ,@RequestPart(value="repeater-list[3][files]", required=false) MultipartFile file3
            ,@RequestPart(value="repeater-list[4][files]", required=false) MultipartFile file4
            ,@RequestPart(value="repeater-list[5][files]", required=false) MultipartFile file5
            ,@RequestPart(value="repeater-list[6][files]", required=false) MultipartFile file6
            ,@RequestPart(value="repeater-list[7][files]", required=false) MultipartFile file7
            ,@RequestPart(value="repeater-list[8][files]", required=false) MultipartFile file8
            ,@RequestPart(value="repeater-list[9][files]", required=false) MultipartFile file9
    ) throws ExecutionException, InterruptedException {

        CreatePhotoVo post = new CreatePhotoVo();
        PostingType postingType = PostingType.valueOf(request.getParameter(POSTING_TYPE_FIELD));
        post.setPostingType(postingType);

        List<String> descriptions=new ArrayList<>();
        List<MultipartFile> files=new ArrayList<>();
        int contentsLength = getContentsLength(request);

        String[] selectedAlbums = request.getParameterValues(ALBUM_FIELD);

        log.info("Contents Count : {}, album : {}", contentsLength, selectedAlbums);

        for(int i = 0 ; i < contentsLength ; i++) {
            String desc = REPEATER_LIST_PREFIX+i+REPEATER_DESCRIPTION_SUFFIX;
            descriptions.add(request.getParameter(desc) != null ? request.getParameter(desc) : "");
            switch (i) {
                case 0:
                    files.add(file0);
                    break;
                case 1:
                    files.add(file1);
                    break;
                case 2:
                    files.add(file2);
                    break;
                case 3:
                    files.add(file3);
                    break;
                case 4:
                    files.add(file4);
                    break;
                case 5:
                    files.add(file5);
                    break;
                case 6:
                    files.add(file6);
                    break;
                case 7:
                    files.add(file7);
                    break;
                case 8:
                    files.add(file8);
                    break;
                case 9:
                    files.add(file9);
                    break;
                default :

            }
        }
        if (contentsLength >= 0) {
            post.setFiles(files.toArray(new MultipartFile[0]));
            post.setTexts(descriptions.toArray(new String[0]));
        }

        if(selectedAlbums != null) {
            post.setAlbumNames(selectedAlbums);
        } else {
            post.setAlbumNames(new String[]{});
        }


        if(contentsLength == 0 || files.stream().anyMatch(MultipartFile::isEmpty)) {
            throw new MoyamoGlobalException("사진을 선택해주세요.");
        }

        User loginUser = authUtils.getCurrentUser();

        postingService.createPhotoPosting(post, loginUser, true);
        return REDIRECT_PREFIX + PHOTO_PAGE;
    }

    // 포스팅 수정
    @RequestMapping("/modifyPhoto")
    public String modifyPosting(Model model, HttpServletRequest request, Long postingId) {

        UpdatePhotoVo updatePost = new UpdatePhotoVo();
        updatePost.setText(request.getParameter("repeater-list[0][descriptions]"));

        User loginUser = authUtils.getCurrentUser();
        postingService.updatePhotoPosting(postingId, updatePost, loginUser);
        return REDIRECT_PREFIX + PHOTO_PAGE;
    }

    // 포스팅 삭제
    @RequestMapping("/deletePhoto")
    public String deletePosting(Model model, HttpServletRequest request, Long postingId, String album) {
        User loginUser = authUtils.getCurrentUser();
        postingService.deletePhotoPosting(Collections.singletonList(postingId), loginUser, album, false);
        return REDIRECT_PREFIX + PHOTO_PAGE;
    }

}
