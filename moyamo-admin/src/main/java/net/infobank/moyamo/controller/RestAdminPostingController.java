package net.infobank.moyamo.controller;

import com.drew.imaging.ImageProcessingException;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.controllers.CommonResponse;
import net.infobank.moyamo.common.controllers.CommonResponseCode;
import net.infobank.moyamo.dto.AdminPostingListResultDto;
import net.infobank.moyamo.dto.CommentDto;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.dto.UserIdWithNicknameDto;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.form.CreateCommentVo;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.openapi.youtube.EmbedMetaData;
import net.infobank.moyamo.openapi.youtube.YoutubeOembedApi;
import net.infobank.moyamo.repository.UserRepository;
import net.infobank.moyamo.service.AdminPostingService;
import net.infobank.moyamo.service.CommentService;
import net.infobank.moyamo.service.PostingService;
import net.infobank.moyamo.util.AuthUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 포스팅 관련 rest api
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest")
public class RestAdminPostingController {

	private final AuthUtils authUtils;
	private final PostingService postingService;
	private final CommentService commentService;
	private final AdminPostingService adminPostingService;
	private final YoutubeOembedApi youtubeOembedApi;
	private final UserRepository userRepository;


	// 포스팅 리스트 조회
	// 포스팅 리스트 조회
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getPostingList")
	public ResponseEntity<AdminPostingListResultDto> getPostingList(
			@RequestParam("posting_type") PostingType postingType,
			@RequestParam("draw") int draw,
			@RequestParam("start") int start,
			@RequestParam("length") int length,
			@RequestParam("search.value") String query,
			@RequestParam(value = "target", defaultValue = "") String searchTargetField,
			@RequestParam(value = "user", required = false) String strUserId
	) {

		User targetUser;
		Long userId = parseLong(strUserId);
		boolean mine;
		if(userId == null) {
			targetUser = authUtils.getCurrentUser();
			mine = false;
		} else {
			//검색 타겟이 사용자일 경우
			Optional<User> optionalUser = userRepository.findById(userId);
			if(!optionalUser.isPresent()) {
				return new ResponseEntity<>(new AdminPostingListResultDto(0, 0, draw, Collections.emptyList()), HttpStatus.OK);
			}
			targetUser = optionalUser.get();
			mine = true;
		}

		Optional<String> optionalSearchQueryTarget = Optional.ofNullable(searchTargetField).filter(StringUtils::isNotBlank);
		PostingService.SearchTimelineRequest request = new PostingService.SearchTimelineRequest(targetUser, postingType.getClazz(), 0L, 0L, 10, query, mine, Optional.empty(), Optional.empty(), optionalSearchQueryTarget);
		int totalCnt = postingService.searchResultCount(request);

		PostingService.SearchPageRequest searchPageRequest = new PostingService.SearchPageRequest(targetUser, postingType, start, length, query, "id", "desc", mine, Optional.empty(), Optional.empty(), optionalSearchQueryTarget);
		List<PostingDto> list = postingService.search(searchPageRequest);
		log.info("SEARCH INFO : TYPE:{}, QUERY: {}, CNT:{}, TOTAL:{}", postingType, query, list.size(), totalCnt);
		return new ResponseEntity<>(new AdminPostingListResultDto(totalCnt, totalCnt, draw, list), HttpStatus.OK);
	}

	private static Long parseLong(String str) {
		try {
			return Long.parseLong(str);
		} catch (Exception e) {
			return null;
		}
	}

	//답변이 필요한 리스트 조회
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getNeedyPostingList")
	public ResponseEntity<AdminPostingListResultDto> getNeedyPostingList(
			@RequestParam("posting_type") PostingType postingType,
			@RequestParam("draw") int draw,
			@RequestParam("start") int start,
			@RequestParam("length") int length,
			@RequestParam("search.value") String query) {

		User loginUser = authUtils.getCurrentUser();

		PostingService.SearchTimelineRequest request = new PostingService.SearchTimelineRequest(loginUser, postingType.getClazz(), 0L, 0L, 10, query, false, Optional.of(0), Optional.of(3));
		int totalCnt = postingService.searchResultCount(request);

		PostingService.SearchPageRequest searchPageRequest = new PostingService.SearchPageRequest(loginUser, postingType, start, length, query, "id", "asc", false, Optional.of(0), Optional.of(3));
		List<PostingDto> list = postingService.search(searchPageRequest);

		log.info("SEARCH NEEDY INFO : TYPE:{}, QUERY: {}, CNT:{}, TOTAL:{}", postingType, query, list.size(), totalCnt);
		return new ResponseEntity<>(new AdminPostingListResultDto(totalCnt, totalCnt, draw, list), HttpStatus.OK);
	}

    // 포스팅 상세 조회
    @JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/getPosting")
    public ResponseEntity<Map<String, Object>> getPosting(@RequestParam("posting_id") Long postingId) {
    	Map<String, Object> map = new HashMap<>();
		PostingDto posting = postingService.findPosting(postingId).orElse(null);
		map.put("data", posting);
		return new ResponseEntity<>(map, HttpStatus.OK);
    }

	// 포스팅 삭제
	@JsonView(Views.WebAdminJsonView.class)
	@PostMapping(path = "/{id}/deletePosting")
	public ResponseEntity<Map<String, Object>> deletePosting(@PathVariable long id) {
		Map<String, Object> map = new HashMap<>();
		PostingDto posting = postingService.forceDeletePosting(id, authUtils.getCurrentUser());
		map.put("data", posting);
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

    // 댓글목록 조회
    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping(path = "/{id}/getComments")
    public ResponseEntity<Map<String, Object>> getComments(@PathVariable long id,
    		@RequestParam(required = false) Long sinceId, @RequestParam(required = false) Long maxId, @RequestParam(required = false, defaultValue = "10") int count) {
    	Map<String, Object> map = new HashMap<>();
    	List<CommentDto> commentsList = commentService.findTimeline(id, sinceId, maxId, count);
    	log.info("PostingId : {}, sinceId : {}, maxId : {}, resultCnt : {}", id, sinceId, maxId, commentsList.size());
    	map.put("data", commentsList);
    	return new ResponseEntity<>(map, HttpStatus.OK);
    }

    // 댓글달기
    @PostMapping(path = "/{id}/createComments")
    public ResponseEntity<Map<String, Object>> createComments(@PathVariable long id,  @RequestParam(required = false) Long commentId,  @RequestParam(required = false) String commentText
    		,@RequestPart(value="commentFile", required=false) MultipartFile commentFile,@RequestPart(value="replyFile", required=false) MultipartFile replyFile) throws ImageProcessingException, IOException, InterruptedException {
    	Map<String, Object> map = new HashMap<>();
    	log.info("postingID : {}, commentId : {}, commentText : {}", id, commentId, commentText);

    	if(commentFile != null) {
			log.info("FileInfo : {}, size : {}", commentFile.getOriginalFilename(), commentFile.getSize());
		}

		User loginUser = authUtils.getCurrentUser();
    	CreateCommentVo vo = new CreateCommentVo();
    	vo.setText(commentText);
    	if (commentId != null) {
    		vo.setFiles(replyFile);
			postingService.createReply(commentId, vo, loginUser, false, false);
		} else {
			vo.setFiles(commentFile);
			postingService.createComment(id, vo, loginUser);
		}

    	return new ResponseEntity< >(map, HttpStatus.OK);
    }

	// 게시글 차단
	@PostMapping(path = "/{id}/blindPosting")
	public ResponseEntity<Map<String, Object>> blindPosting(@PathVariable long id, @RequestParam() boolean blind) {
		Map<String, Object> map = new HashMap<>();
		log.info("postingID : {}", id);
		User loginUser = authUtils.getCurrentUser();
		postingService.blindPosting(id, loginUser, blind);
		map.put("blind", blind);
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

    // 댓글 차단
    @PostMapping(path = "/{id}/blindComments")
    public ResponseEntity<Map<String, Object>> blindComments(@PathVariable long id,  @RequestParam(required = false) Long commentId, @RequestParam() boolean blind) {
    	Map<String, Object> map = new HashMap<>();
    	log.info("postingID : {}, commentId : {}", id, commentId);
		User loginUser = authUtils.getCurrentUser();
    	postingService.blindComment(commentId, loginUser, blind);
		map.put("blind", blind);
    	return new ResponseEntity<>(map, HttpStatus.OK);
    }

	@JsonView(Views.BaseView.class)
	@GetMapping(path = "/getMentions")
	public CommonResponse<List<UserIdWithNicknameDto>> doFindMentionUsers(@RequestParam("posting_id") Long postingId, @RequestParam(value = "q", defaultValue = "", required = false) String query) {
		return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), postingService.findPostingMentionUsers(postingId, query));
	}

	// 포스팅 개시
	@PostMapping(path = "/showPosting/{postingType}/{postingId}")
    public String showPosting(@PathVariable(name = "postingId") Long postingId, @PathVariable(name = "postingType") PostingType postingType) {
		PostingType targetPostingType = postingType.getTargetPostingType();
		if (postingId != null) {
	    	postingService.updatePostingType(Collections.singletonList(postingId), targetPostingType);
    	}

    	return "postingService.showPosting";
    }

	// 포스팅 복사
	@PostMapping(path = "/{postingId}/copyPosting")
	public CommonResponse<PostingDto> copyPosting(@PathVariable(name = "postingId") Long postingId) {
		return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), adminPostingService.copy(postingId));
	}

	@JsonView(Views.WebAdminJsonView.class)
	@PostMapping(path="/postings/{postingId}/comments/first", produces = {"application/json"})
	public CommonResponse<CommentDto> findFirstComment(@PathVariable(name = "postingId") Long postingId) {
		return commentService.findFirst(postingId).map(commentDto -> new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), commentDto)).orElse(new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), null));
	}


	@JsonView(Views.WebAdminJsonView.class)
	@PostMapping(path="/postings/{postingId}/comments/adopt", produces = {"application/json"})
	public CommonResponse<CommentDto> findAdoptedComment(@PathVariable(name = "postingId") Long postingId) {
		return commentService.findAdopted(postingId).map(commentDto -> new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), commentDto)).orElse(new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), null));
	}

	@PostMapping(path = "/postings/indexing")
	public CommonResponse<Boolean> indexing(@RequestParam(name = "ids") String ids, @RequestParam(name = "max", required = false) Integer max) {
		postingService.indexing(Arrays.stream(StringUtils.split(ids, ",")).map(Long::valueOf).collect(Collectors.toList()), max);
		return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), true);
	}

	//youtube meta 조회
	@GetMapping(path = "/postings/youtube")
	public CommonResponse<EmbedMetaData> findYoutubeMeta(String url) {
		return new CommonResponse<>(CommonResponseCode.SUCCESS.getResultCode(), youtubeOembedApi.metaData("2", "json", 1, 1024, url));
	}
}
