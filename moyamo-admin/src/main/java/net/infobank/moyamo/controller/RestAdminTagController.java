package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.TagAdminDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Tag;
import net.infobank.moyamo.models.Tag.TagType;
import net.infobank.moyamo.models.Tag.Visibility;
import net.infobank.moyamo.repository.TagRepository;
import net.infobank.moyamo.service.TagService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * 포스팅 관련 rest api
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/tag")
public class RestAdminTagController {

	private static final String RESPONSE_CODE_FIELD = "resultCode";

	private final TagService tagService;
	private final TagRepository tagRepository;

	// USER 리스트 조회
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getList")
    public ResponseEntity<Map<String, Object>> getList(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
    	Map<String, Object> map = new HashMap<>();
		List<TagAdminDto> tagList;
		if (query == null || query.length()<=0) {
			tagList = tagService.findAll(PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id")));
		} else {
			tagList = tagService.findByNameLike("%" +query + "%", PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id")));
		}
		Long totalCnt = tagService.getTagCount();
    	map.put("recordsTotal", totalCnt);
    	map.put("recordsFiltered", totalCnt);
    	log.info("start[{}], length[{}], totalCnt[{}], draw[{}]", start, length, totalCnt, draw);
    	map.put("draw", draw);
    	map.put("data", tagList);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }

	@JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/registTag")
    public ResponseEntity<Map<String, Object>> registTag(@RequestParam(required = false) Long id, @RequestParam String name, @RequestParam(required = false) Visibility visibility,
    		@RequestParam(required = false) TagType tagType,@RequestParam(required = false) String url ) {
		Map<String, Object> map = new HashMap<>();

    	if (id == null) { // 신규등록
    		Optional<Tag> td = tagRepository.findByName(name);
    		if (td.isPresent()) {
    			log.info("Tag already exist : {}", td);
    			map.put(RESPONSE_CODE_FIELD, "9000");
	    	} else {
	    		log.info("New Tag Regist");
	    		Tag tag = Tag.builder().name(name).tagType(tagType).visibility(visibility).url(url).build();
	    		tag.setName(name);
	    		tagRepository.save(tag);
	    		map.put(RESPONSE_CODE_FIELD, "1000");
	    	}
    	} else { // 수정
    		log.info("Tag Modify : {}", id);
    		Tag tag = tagRepository.findById(id).orElse(new Tag());
    		tag.setName(name);
    		tag.setTagType(tagType);
    		tag.setVisibility(visibility);
    		tag.setUrl(url);
    		tagRepository.save(tag);
    		map.put(RESPONSE_CODE_FIELD, "1000");
    	}
    	map.put("data", true);
    	return new ResponseEntity<>(map, HttpStatus.OK);
    }

}
