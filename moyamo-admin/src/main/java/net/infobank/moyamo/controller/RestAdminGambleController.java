package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.GambleDto;
import net.infobank.moyamo.form.GambleVo;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.service.GambleService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.*;

/**
 * 포스팅 관련 rest api
 *
 * @author jspark
 */
@AllArgsConstructor
@Slf4j
@RestController
@RequestMapping("/rest/gamble")
public class RestAdminGambleController {

	private static final String REPEATER_PREFIX = "repeater-list[";
	private static final String REPEATER_NAME_SUFFIX = "][name]";

	private final GambleService gambleService;

	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/getGambleList")
	public ResponseEntity<Map<String, Object>> getGambleList(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
		return this.getList(draw, start, length, query, Optional.empty());
	}

	@SneakyThrows
	@JsonView(Views.WebAdminJsonView.class)
	@GetMapping(path = "/{id}/excel")
	public void doDownloadExcel(HttpServletResponse response, @PathVariable("id") Long id, @RequestParam(value = "itemId", required = false) Long itemId, @RequestParam(value="version") int version, @RequestParam(value="godo", defaultValue = "false") boolean godo) {
		gambleService.download(id, Optional.ofNullable(itemId), version, response, godo);
	}

	@JsonView(Views.WebAdminJsonView.class)
	@PostMapping("")
	public String registGamble(HttpServletRequest request, @Valid @ModelAttribute GambleVo.CreateGamble vo) {

		log.info("gamble regist : {}", vo);
		Map<String, String[]> param = request.getParameterMap();

		vo.setItems(new ArrayList<>());
		int itemCount = 0;
		String[] paramName  = param.get(REPEATER_PREFIX+itemCount+REPEATER_NAME_SUFFIX);
		while(paramName != null && paramName.length > 0 ) {

			String name = param.get(REPEATER_PREFIX+itemCount+REPEATER_NAME_SUFFIX)[0];
			Integer amount = Integer.parseInt(param.get(REPEATER_PREFIX+itemCount+"][amount]")[0]);

			GambleVo.CreateItem createItem = new GambleVo.CreateItem();
			createItem.setName(name);
			createItem.setAmount(amount);
			boolean address;
			String[] addressArray = param.get(REPEATER_PREFIX+itemCount+"][address][]");
			if(addressArray != null && addressArray.length > 0) {
				address = Boolean.parseBoolean(addressArray[0]);
			} else {
				address = false;
			}

			boolean blank;
			String[] blankArray = param.get(REPEATER_PREFIX+itemCount+"][blank][]");
			if(blankArray != null && blankArray.length > 0) {
				blank = Boolean.parseBoolean(blankArray[0]);
			} else {
				blank = false;
			}

			createItem.setAddress(address);
			createItem.setBlank(blank);
			vo.getItems().add(createItem);

			itemCount++;
			paramName = param.get(REPEATER_PREFIX+itemCount+REPEATER_NAME_SUFFIX);
		}
		gambleService.createGamble(vo);
		return "";
	}

	@JsonView(Views.WebAdminJsonView.class)
	@PostMapping("/{id}")
	public String modifyGamble(@PathVariable("id") Long id, HttpServletRequest request, @Valid @ModelAttribute GambleVo.UpdateGamble vo) {

		log.info("gamble modify : {}", vo);

		vo.setItems(new ArrayList<>());
		Map<String, String[]> param = request.getParameterMap();

		int itemCount = 0;
		String[] paramName  = param.get(REPEATER_PREFIX+itemCount+REPEATER_NAME_SUFFIX);
		while(paramName != null && paramName.length > 0 ) {
			String name = param.get(REPEATER_PREFIX+itemCount+REPEATER_NAME_SUFFIX)[0];
			Integer amount = Integer.parseInt(param.get(REPEATER_PREFIX+itemCount+"][amount]")[0]);

			boolean address;
			String[] addressArray = param.get(REPEATER_PREFIX+itemCount+"][address][]");
			if(addressArray != null && addressArray.length > 0) {
				address = Boolean.parseBoolean(addressArray[0]);
			} else {
				address = false;
			}

			boolean blank;
			String[] blankArray = param.get(REPEATER_PREFIX+itemCount+"][blank][]");
			if(blankArray != null && blankArray.length > 0) {
				blank = Boolean.parseBoolean(blankArray[0]);
			} else {
				blank = false;
			}

			String itemId;
			String[] itemIdArray = param.get(REPEATER_PREFIX+itemCount+"][id]");
			if(itemIdArray != null && itemIdArray.length > 0) {
				itemId = itemIdArray[0];
			} else {
				itemId = null;
			}

			GambleVo.UpdateItem updateItem = new GambleVo.UpdateItem();
			updateItem.setName(name);
			updateItem.setAmount(amount);
			updateItem.setAddress(address);
			updateItem.setBlank(blank);
			updateItem.setId(itemId);
			vo.getItems().add(updateItem);

			itemCount++;
			paramName = param.get(REPEATER_PREFIX+itemCount+REPEATER_NAME_SUFFIX);
		}
		gambleService.updateGamble(id, vo);
		return "";
	}

    private ResponseEntity<Map<String, Object>> getList(int draw, int start, int length, String query, Optional<Boolean> optionalActive) {

    	Map<String, Object> map = new HashMap<>();

		List<GambleDto> list = null;
		if (query == null || query.length()<=0) {
			list = gambleService.findList(start, length, Optional.empty(), optionalActive);
		}

		Long totalCnt = gambleService.getCount(Optional.empty(), optionalActive);

    	map.put("recordsTotal", totalCnt);
    	map.put("recordsFiltered", totalCnt);
    	log.info("start[{}], length[{}], totalCnt[{}], draw[{}]", start, length, totalCnt, draw);
    	map.put("draw", draw);
    	map.put("data", list);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }

}
