package net.infobank.moyamo.controller;

import lombok.RequiredArgsConstructor;
import net.infobank.moyamo.enumeration.RecommendKeywordType;
import net.infobank.moyamo.service.RecommendKeywordAdminService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/rest")
public class RestAdminRecommendKeywordAdminController {

    private final RecommendKeywordAdminService recommendKeywordAdminService;

    @PostMapping("/createRecommendKeyword")
    public void createRecommendKeyword(@RequestParam(value = "postingType", required = false) RecommendKeywordType keywordType, @RequestParam("keyword") List<String> keywords){
        recommendKeywordAdminService.addRecommendKeywordAdmin(recommendKeywordAdminService.createRecommendKeywordAdmin(keywordType), keywordType, keywords );
    }

    @GetMapping("/getRecommendKeyword")
    public ResponseEntity<Map<String, Object>> getRecommendKeywords(@RequestParam(value = "searchType", required = false) String searchType, @RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
        return new ResponseEntity<>(recommendKeywordAdminService.getAllRecommendKeywordAdmin(searchType, draw, query, PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id"))), HttpStatus.OK);
    }

    @RequestMapping("/updateRecommendKeyword")
    public void updateRecommendKeyword(@RequestParam(value = "recommendKeywordAdminId") Long recommendKeywordAdminId, @RequestParam(value = "postingType", required = false) RecommendKeywordType keywordType, @RequestParam(value = "keyword", required = false) List<String> keywords, @RequestParam(value = "keywordId", required = false) List<Long> keywordIds){
        if(keywords.isEmpty()){ keywords.add("");}
        recommendKeywordAdminService.updateRecommendKeywordAdmin( recommendKeywordAdminId, keywordType, keywords, keywordIds);
    }

}
