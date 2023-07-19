package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.GoodsDto;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.service.AdminGoodsService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * 포스팅 관련 rest api
 * @author jspark
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/goods")
public class RestAdminGoodsController {

	private final AdminGoodsService goodsService;

	//
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("/detail")
    public ResponseEntity<Map<String, Object>> getList(@RequestParam("id") String id) {

		Map<String, Object> map = new HashMap<>();

		GoodsDto goodsDto = goodsService.findGoods(id);
		map.put("detail", goodsDto);
		map.put("status", (goodsDto != null) ? "ok" : "fail");

		return ResponseEntity.ok(map);
    }

}
