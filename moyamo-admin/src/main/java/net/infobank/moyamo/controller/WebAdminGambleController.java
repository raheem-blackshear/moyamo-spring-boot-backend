package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.GambleDto;
import net.infobank.moyamo.dto.GambleItemDto;
import net.infobank.moyamo.dto.GambleVersionDto;
import net.infobank.moyamo.form.GambleVo;
import net.infobank.moyamo.models.Gamble;
import net.infobank.moyamo.models.GambleItem;
import net.infobank.moyamo.service.GambleService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminGambleController {

    private static final String REPEATER_LIST_PREFIX = "repeater-list[";
    private static final String REPEATER_LIST_NAME_SUFFIX = "][name]";

	private final GambleService gambleService;

    @RequestMapping("/gamble")
    public String tag(Model model) {
    	model.addAttribute("menuName", "게임");
    	return "/admin/gamble";
    }

    @PostMapping("/gamble/{id}")
    public String modifyGamble(@PathVariable("id") Long id, HttpServletRequest request, @Valid @ModelAttribute GambleVo.UpdateGamble vo) {

        log.info("gamble modify : {}", vo);
        Map<String, String[]> param = request.getParameterMap();

        int itemCount = 0;
        String[] paramName  = param.get(REPEATER_LIST_PREFIX+itemCount+REPEATER_LIST_NAME_SUFFIX);
        while(paramName != null && paramName.length > 0 ) {
            String name = param.get(REPEATER_LIST_PREFIX+itemCount+REPEATER_LIST_NAME_SUFFIX)[0];
            Integer amount = Integer.parseInt(param.get(REPEATER_LIST_PREFIX+itemCount+"][amount]")[0]);
            Boolean address = Boolean.parseBoolean(param.get(REPEATER_LIST_PREFIX+itemCount+"][address]")[0]);
            Boolean blank = Boolean.parseBoolean(param.get(REPEATER_LIST_PREFIX+itemCount+REPEATER_LIST_NAME_SUFFIX)[0]);

            GambleVo.UpdateItem updateItem = new GambleVo.UpdateItem();
            updateItem.setName(name);
            updateItem.setAmount(amount);
            updateItem.setAddress(address);
            updateItem.setBlank(blank);
            vo.getItems().add(updateItem);

            itemCount++;
            paramName = param.get(REPEATER_LIST_PREFIX+itemCount+REPEATER_LIST_NAME_SUFFIX);
        }
        gambleService.updateGamble(id, vo);
        return "";
    }

    @RequestMapping("/gamble/result")
    public String viewGambleResult(Model model, @RequestParam("gambleId") Long gambleId, @RequestParam(value = "version", required = false) Integer version, @RequestParam(value="itemId", required = false) Long itemId, @RequestParam(value="offset", required = false) Integer offset, @RequestParam(value="count", required = false) Integer count) {
        log.info("===gamble result===");

        GambleDto gamble = gambleService.find(gambleId);
        List<GambleVersionDto> versionList = gambleService.findGambleVersionList(gambleId);

        model.addAttribute("menuName", "결과 조회");

        model.addAttribute("gamble", gamble);
        model.addAttribute("versionList", versionList);
        model.addAttribute("zoneId", ZoneId.of("Asia/Seoul"));
        model.addAttribute("datePattern", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        model.addAttribute("dateTimePattern", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

        if( !versionList.isEmpty()) {
            if(version == null) {
                version = versionList.stream().sorted((o1, o2) -> Integer.compare(o2.getVersion(), o1.getVersion())).map(GambleVersionDto::getVersion).findFirst().orElse(0);
            }
        } else {
            version = 0;
        }

        model.addAttribute("version", version);
        model.addAttribute("betCount", gambleService.findGambleResultCount(gambleId, version));

        if(itemId == null && !gamble.getItems().isEmpty()) {
            itemId = gamble.getItems().stream().map(GambleItemDto::getId).findAny().orElse(null);
        }

        model.addAttribute("itemId", itemId);

        if(itemId != null) {
            model.addAttribute("resultList", gambleService.findResultList(gambleId, Optional.of(itemId), version, Optional.ofNullable(offset), Optional.ofNullable(count)));
        }

        return "/admin/gambleResult";
    }

    // 포스팅 등록
    @PostMapping("/gamble/regist")
    public String registGamble(HttpServletRequest request, @Valid @ModelAttribute GambleVo.CreateGamble vo) {

        log.info("gamble regist : {}", vo);

        Map<String, String[]> param = request.getParameterMap();
        String title = request.getParameter("title");
        String url = request.getParameter("url ");
        Gamble gamble = Gamble.builder().items(new ArrayList<>()).title(title).url(url).build();

        int itemCount = 0;
        String[] paramName  = param.get(REPEATER_LIST_PREFIX+itemCount+REPEATER_LIST_NAME_SUFFIX);
        while(paramName != null && paramName.length > 0 ) {
            String name = param.get(REPEATER_LIST_PREFIX+itemCount+REPEATER_LIST_NAME_SUFFIX)[0];
            int amount = Integer.parseInt(param.get(REPEATER_LIST_PREFIX+itemCount+"][amount]")[0]);
            boolean address = Boolean.parseBoolean(param.get(REPEATER_LIST_PREFIX+itemCount+"][address]")[0]);
            boolean blank = Boolean.parseBoolean(param.get(REPEATER_LIST_PREFIX+itemCount+REPEATER_LIST_NAME_SUFFIX)[0]);

            GambleItem item = GambleItem.builder().gamble(gamble).name(name).blank(blank).address(address).amount(amount).build();
            gamble.getItems().add(item);

            itemCount++;
            paramName = param.get(REPEATER_LIST_PREFIX+itemCount+REPEATER_LIST_NAME_SUFFIX);
        }
        log.info("gamble : {}", gamble);
        return "";
    }


}
