package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.service.AdminStatisticsService;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

/**
 * 통계
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/rest/statistics")
public class RestStatisticsController {

	private final AdminStatisticsService statisticsService;

	//
	@JsonView(Views.WebAdminJsonView.class)
	@RequestMapping("")
    public ResponseEntity<Map<String, Object>> getList(@RequestParam("from") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate from, @RequestParam("to") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate to) {
		Map<String, Object> map = new HashMap<>();
		map.put("detail", statisticsService.findStatisticsList(from, to));
		map.put("status", "ok");
		return ResponseEntity.ok(map);
    }

}
