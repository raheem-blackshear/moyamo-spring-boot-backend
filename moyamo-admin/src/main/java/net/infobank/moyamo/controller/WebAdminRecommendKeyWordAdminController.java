package net.infobank.moyamo.controller;

import lombok.RequiredArgsConstructor;
import net.infobank.moyamo.enumeration.RecommendKeywordType;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;

@Controller
@RequestMapping("/admin/**")
@RequiredArgsConstructor
public class WebAdminRecommendKeyWordAdminController {

    @RequestMapping("/recommendKeyword")
    public String recommendKeyword(Model model) {
        model.addAttribute("menuName", "추천 검색어 관리");

        RecommendKeywordType[] allRecommendKeywordTypes = RecommendKeywordType.values();
        ArrayList<RecommendKeywordType> recommendKeywordType = new ArrayList<>();
        for(RecommendKeywordType type: allRecommendKeywordTypes){

            if(type==RecommendKeywordType.guidebook) continue;

            if(StringUtils.isEmpty(type.getName())){
                switch (type.name()){
                    case "shop":
                        RecommendKeywordType.setRecommendKeywordName(type, "모야모샵");
                        break;
                    case "dictionary":
                        RecommendKeywordType.setRecommendKeywordName(type, "도감");
                        break;
                    default:
                        RecommendKeywordType.setRecommendKeywordName(type, type.name());
                        break;
                }
            }
            recommendKeywordType.add(type);
        }
        model.addAttribute("keyTypes",recommendKeywordType);

        return "/admin/recommendKeyword";
    }
}
