package net.infobank.moyamo.controller;

import com.drew.imaging.ImageProcessingException;
import lombok.AllArgsConstructor;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.exception.CommonException;
import net.infobank.moyamo.form.CreatePostVo;
import net.infobank.moyamo.form.UpdatePostVo;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.service.AdminPostingService;
import net.infobank.moyamo.service.PostingService;
import net.infobank.moyamo.util.AuthUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 포스팅 Web
 */
@Slf4j
@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminPostingController {

	private static final String ADMIN_POSTING_PAGE = "/admin/posting";
	private static final String MENUNAME_FIELD = "menuName";
	private static final String REDIRECT_PREFIX = "redirect:";
	private static final String POSTING_TYPE_FIELD = "postingType";
	private static final String REPEATER_LIST_PREFIX = "repeater-list[";
	private static final String REPEATER_DESCRIPTION_SUFFIX = "][descriptions]";

	private final AuthUtils authUtils;
	private final PostingService postingService;
	private final AdminPostingService adminPostingService;

    // 포스팅 등록
	public static String getFileNameFromURL(String url) {
		return url.substring(url.lastIndexOf('/') + 1);
	}

	public static  class BASE64DecodedMultipartFile implements MultipartFile {
		private final byte[] imgContent;
		private final String name;
		private final String contentType;

		public BASE64DecodedMultipartFile(byte[] imgContent, String name, String contentType) {
			this.imgContent = imgContent;
			this.name = name;
			this.contentType = contentType;
		}

		@Override
		public @NonNull String getName() {
			return name;
		}

		@Override
		public String getOriginalFilename() {
			return getName();
		}

		@Override
		public String getContentType() {
			return contentType;
		}

		@Override
		public boolean isEmpty() {
			return imgContent == null || imgContent.length == 0;
		}

		@Override
		public long getSize() {
			return imgContent.length;
		}

		@Override
		public byte @NonNull [] getBytes() throws IOException {
			return imgContent;
		}

		@Override
		public @NonNull InputStream getInputStream() throws IOException {
			return new ByteArrayInputStream(imgContent);
		}

		@SuppressWarnings("java:S2095") // AutoCloseable
		@Override
		public void transferTo(@NonNull File dest) throws IOException, IllegalStateException {
			new FileOutputStream(dest).write(imgContent);
		}
	}


	private static BASE64DecodedMultipartFile createBASE64MultipartFile(String url) {
		byte[] b = null;
		String filename = null;
		String contentType = null;
		try {

			URL u = new URL(url);
			URLConnection urlConnection = u.openConnection();
			contentType = urlConnection.getContentType();
			filename = getFileNameFromURL(url);
			b = IOUtils.toByteArray((u).openStream());

		} catch (IOException e) {
			e.printStackTrace();
		}

		if(filename == null || contentType == null || b == null) {
			throw new CommonException(CommonResponseCode.FAIL, "동영상 정보를 알 수 없습니다.");
		}

		return new BASE64DecodedMultipartFile(b, filename, contentType);
	}

	private static String getVideoId(@NonNull String videoUrl) {
		String videoId = "";
		String regex = "http(?:s)?:\\/\\/(?:m.)?(?:www\\.)?youtu(?:\\.be\\/|be\\.com\\/(?:watch\\?(?:feature=youtu.be\\&)?v=|v\\/|embed\\/|user\\/(?:[\\w#]+\\/)+))([^&#?\\n]+)";
		Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(videoUrl);
		if(matcher.find()){
			videoId = matcher.group(1);
		}
		return videoId;
	}


	private static boolean isNotEmpty(MultipartFile file) {
		return file != null && !file.isEmpty();
	}

	@RequestMapping("/registPosting")
    public String registPosting(HttpServletRequest request
    		,@RequestPart(value="poster", required=false) MultipartFile poster
			,@RequestPart(value="thunbnailUrl", required=false) String thunbnailUrl
			,@RequestPart(value="youtubeUrl", required=false) String youtubeUrl
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
			,@RequestPart(value="repeater-list[10][files]", required=false) MultipartFile file10
			,@RequestPart(value="repeater-list[11][files]", required=false) MultipartFile file11
			,@RequestPart(value="repeater-list[12][files]", required=false) MultipartFile file12
			,@RequestPart(value="repeater-list[13][files]", required=false) MultipartFile file13
			,@RequestPart(value="repeater-list[14][files]", required=false) MultipartFile file14
    	) throws ExecutionException, InterruptedException {

    	CreatePostVo post = new CreatePostVo();
		String goodsNo = request.getParameter("goodsNo");
    	PostingType postingType = PostingType.valueOf(request.getParameter(POSTING_TYPE_FIELD));
    	post.setPostingType(postingType);
    	post.setText(request.getParameter("text"));
    	post.setTitle(request.getParameter("title"));
    	if (postingType == PostingType.guidebook) {
    		post.setPosters(new MultipartFile[] {poster});	// 가이드북 포스터
    	} else if(PostingType.television.equals(postingType) || PostingType.television_wait.equals(postingType)) {
			if(StringUtils.isNotBlank(thunbnailUrl)) {
				post.setPosters(new MultipartFile[]{createBASE64MultipartFile(thunbnailUrl)});
			} else if(isNotEmpty(poster)) {
				post.setPosters(new MultipartFile[] {poster});
			}
			String youtubeId = getVideoId(youtubeUrl);
			post.setYoutubeId(youtubeId);
		}
    	List<String> descriptions=new ArrayList<>();
    	List<MultipartFile> files=new ArrayList<>();
    	int contentsLength = getContentsLength(request);
    	log.info("Contents Count : {}", (contentsLength));

    	//television 은
    	for(int i=0;i<contentsLength && !PostingType.television.equals(postingType) && !PostingType.television_wait.equals(postingType) ;i++) {
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
				case 10:
					files.add(file10);
					break;
				case 11:
					files.add(file11);
				break;
				case 12:
					files.add(file12);
					break;
				case 13:
					files.add(file13);
					break;
				case 14:
					files.add(file14);
					break;
				default :
    		}
    	}
    	if (contentsLength >= 0) {
	    	post.setDescriptions(descriptions.toArray(new String[0]));
	    	post.setFiles(files.toArray(new MultipartFile[0]));
    	}
		User loginUser = authUtils.getCurrentUser();
		PostingDto pd = postingService.createPosting(post, loginUser);

		if(goodsNo != null && !goodsNo.isEmpty()) {
			adminPostingService.addGoods(pd.getId(), goodsNo);
		}

    	return REDIRECT_PREFIX + retUrl(postingType);
    }

    private boolean isModifyPoster(PostingType postingType, MultipartFile poster) {
		if (postingType == PostingType.guidebook || postingType == PostingType.television|| postingType == PostingType.television_wait) { // 가이드북 포스터 파일 갱신
			//
			return poster != null && poster.getSize() > 0;
		} else {
			return false;
		}
	}

    // 포스팅 수정
    @RequestMapping("/modifyPosting")
    public String modifyPosting(Model model, HttpServletRequest request, Long postingId
    		,@RequestPart(value="poster", required=false) MultipartFile poster
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
			,@RequestPart(value="repeater-list[10][files]", required=false) MultipartFile file10
			,@RequestPart(value="repeater-list[11][files]", required=false) MultipartFile file11
			,@RequestPart(value="repeater-list[12][files]", required=false) MultipartFile file12
			,@RequestPart(value="repeater-list[13][files]", required=false) MultipartFile file13
			,@RequestPart(value="repeater-list[14][files]", required=false) MultipartFile file14
    		) throws ImageProcessingException, IOException, InterruptedException {
    	PostingType postingType = PostingType.valueOf(request.getParameter(POSTING_TYPE_FIELD));

    	log.info("ModifyPost ID : {}", postingId);
    	UpdatePostVo updatePost = new UpdatePostVo();
    	String goodsNo = request.getParameter("goodsNo");
    	updatePost.setText(request.getParameter("text"));
    	updatePost.setTitle(request.getParameter("title"));
    	if(isModifyPoster(postingType, poster)) {
			updatePost.setPosters(new MultipartFile[] {poster});
    	}

    	List<String> ids=new ArrayList<>();
    	List<String> descriptions=new ArrayList<>();
    	List<MultipartFile> files=new ArrayList<>();

    	int contentsLength = getContentsLength(request);
    	log.info("Contents Count : {}", (contentsLength));
    	for(int i=0;i<contentsLength;i++) {
    		String attachId = REPEATER_LIST_PREFIX+i+"][id]";
    		String desc = REPEATER_LIST_PREFIX+i+REPEATER_DESCRIPTION_SUFFIX;
    		ids.add(request.getParameter(attachId));
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
			case 10:
				files.add(file10);
				break;
			case 11:
				files.add(file11);
				break;
			case 12:
				files.add(file12);
				break;
			case 13:
				files.add(file13);
				break;
			case 14:
				files.add(file14);
				break;
    		default :

    		}
    	}

		updatePost.setIds(ids.toArray(new String[0]));
		updatePost.setDescriptions(descriptions.toArray(new String[0]));
		updatePost.setFiles(files.toArray(new MultipartFile[0]));

		log.info("Description/File Count : {}/{}", updatePost.getDescriptions().length, updatePost.getFiles().length);

		User loginUser = authUtils.getCurrentUser();

    	PostingDto posting = postingService.updatePosting(postingId, updatePost, loginUser);

		if(goodsNo != null && !goodsNo.isEmpty()) {
			adminPostingService.addGoods(posting.getId(), goodsNo);
		} else {
			adminPostingService.removeGoods(posting.getId());
		}
    	return REDIRECT_PREFIX + retUrl(postingType);
    }

    // 포스팅 삭제
    @RequestMapping("/switchPosting")
    public String switchPosting(@RequestParam(required = false) Long[] postingId, @RequestParam(POSTING_TYPE_FIELD) PostingType postingType, @RequestParam("targetCategory") PostingType targetCategory) {
    	if (postingId != null && postingId.length > 0) {
	    	for (Long id : postingId) {
	    		log.info("PostingId : {} / change posting type : {} -> {}", id , postingType, targetCategory);
	    	}
	    	postingService.updatePostingType(Arrays.asList(postingId), targetCategory);
    	}
    	return REDIRECT_PREFIX + retUrl(postingType);
    }

    // 포스팅 삭제
    @RequestMapping("/deletePosting")
    public String deletePosting(Model model, HttpServletRequest request, Long postingId) {
		User loginUser = authUtils.getCurrentUser();
    	postingService.deletePosting(postingId, loginUser);
    	PostingType postingType = PostingType.valueOf(request.getParameter(POSTING_TYPE_FIELD));
    	return REDIRECT_PREFIX + retUrl(postingType);
    }

	// 매거진
    @RequestMapping("/magazine")
    public String magazine(Model model) {
    	model.addAttribute(MENUNAME_FIELD, "매거진");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.magazine);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());

    	return ADMIN_POSTING_PAGE;
    }

	// 모야모TV
	@RequestMapping("/television")
	public String television(Model model) {
		model.addAttribute(MENUNAME_FIELD, "모야모TV");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.television);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());

		return ADMIN_POSTING_PAGE;
	}

    @RequestMapping("/guideBook")
    public String guideBook(Model model) {
    	model.addAttribute(MENUNAME_FIELD, "가이드북");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.guidebook);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());
    	return ADMIN_POSTING_PAGE;
    }

    @RequestMapping("/moyamo")
    public String moyamo(Model model) {
    	model.addAttribute(MENUNAME_FIELD, "이름이 모야");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.question);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());
    	return ADMIN_POSTING_PAGE;
    }

    //댓글이 필요한 질문 목록
	@RequestMapping("/moyamo-2")
	public String moyamo2(Model model) {
		model.addAttribute(MENUNAME_FIELD, "이름이 모야");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.question);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());
		model.addAttribute("needy", true);
		return ADMIN_POSTING_PAGE;
	}

    @RequestMapping("/clinic")
    public String clinic(Model model) {
    	model.addAttribute(MENUNAME_FIELD, "식물 클리닉");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.clinic);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());
    	return ADMIN_POSTING_PAGE;
    }

	//댓글이 필요한 클리닉 목록
	@RequestMapping("/clinic-2")
	public String clinic2(Model model) {
		model.addAttribute(MENUNAME_FIELD, "식물 클리닉");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.clinic);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());
		model.addAttribute("needy", true);
		return ADMIN_POSTING_PAGE;
	}

    @RequestMapping("/bragging")
    public String bragging(Model model) {
    	model.addAttribute(MENUNAME_FIELD, "자랑하기");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.boast);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());
    	return ADMIN_POSTING_PAGE;
    }

    @RequestMapping("/freeboard")
    public String freeboard(Model model) {
    	model.addAttribute(MENUNAME_FIELD, "자유수다");
		model.addAttribute(POSTING_TYPE_FIELD, PostingType.free);
		User loginUser = authUtils.getCurrentUser();
		model.addAttribute("user", loginUser.getId());
    	return ADMIN_POSTING_PAGE;
    }

    private String retUrl(PostingType postingType) {
    	String ret;

    	switch (postingType.name()) {

    	case "guidebook" :
    		ret = "/admin/guideBook";
    		break;
    	case "question" :
    		ret = "/admin/moyamo";
    		break;
    	case "boast" :
    		ret = "/admin/bragging";
    		break;
    	case "clinic" :
    		ret = "/admin/clinic";
    		break;
    	case "free" :
    		ret = "/admin/freeboard";
    		break;
		case "television" :
			ret = "/admin/television";
			break;
		case "magazine" :
    	default :
    		ret = "/admin/magazine";
    	}

    	return ret;
    }

    private int getContentsLength(HttpServletRequest request) {
    	String ret = "";
    	Map<String, String[]> param = request.getParameterMap();
    	for (String key : param.keySet()) {
    		if (key.contains(REPEATER_LIST_PREFIX) && key.indexOf(REPEATER_DESCRIPTION_SUFFIX, 1) > -1) {
	        	ret = key.substring(REPEATER_LIST_PREFIX.length(), key.indexOf(REPEATER_DESCRIPTION_SUFFIX));
    		}

    	}

    	return "".equals(ret) ? 0 : Integer.parseInt(ret) + 1;
	}
}
