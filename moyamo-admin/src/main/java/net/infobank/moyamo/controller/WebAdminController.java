package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.Statistics;
import net.infobank.moyamo.repository.StatisticsRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;


@Slf4j
@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminController {

	private static final String MENU_NAME_FIELD = "menuName";

	private final StatisticsRepository statisticsRepository;

	private static LocalDate getLocalDate() {
		return ZonedDateTime.now().withZoneSameInstant(ZoneId.of("Asia/Seoul")).toLocalDate();
	}

	@RequestMapping(value = {"/", "/index"}, method={RequestMethod.GET , RequestMethod.POST})
	public String index(Model model) {
    	log.info("### admin index in");
    	model.addAttribute(MENU_NAME_FIELD, "대시보드");
    	return "/admin/index";
    }

	@RequestMapping(value = "/dashBoard", method={RequestMethod.GET , RequestMethod.POST})
	public String dash(Model model) {
		log.info("### dash index in");
		model.addAttribute(MENU_NAME_FIELD, "대시보드");

		LocalDate to = getLocalDate();
		LocalDate from = to.minusDays(6);

		Statistics statistics = statisticsRepository.findLastOnce(ZonedDateTime.now().minusYears(10));

		int totalJoinCount;
		ZonedDateTime lastModifyDate;
		if(statistics != null) {
			totalJoinCount = statistics.getCumAndroidJoinCount() + statistics.getCumIosJoinCount() + statistics.getCumEtcJoinCount();
			lastModifyDate = statistics.getModifiedAt();
		} else {
			totalJoinCount = 0;
			lastModifyDate = ZonedDateTime.now();
		}

		model.addAttribute("totalJoinCount", totalJoinCount);
		model.addAttribute("lastModifyDate", lastModifyDate);

		DateTimeFormatter pattern = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		model.addAttribute("from", from.format(pattern));
		model.addAttribute("to", to.format(pattern));

		return "/admin/dashBoard";
	}

    @RequestMapping("/statistics")
    public String statistics(Model model) {
		log.info("### dash index in");
		model.addAttribute(MENU_NAME_FIELD, "통계");

		LocalDate to = getLocalDate();
		LocalDate from = to.minusDays(6);

		Statistics statistics = statisticsRepository.findLastOnce(ZonedDateTime.now().minusYears(10));

		int totalJoinCount;
		ZonedDateTime lastModifyDate;
		if(statistics != null) {
			totalJoinCount = statistics.getCumAndroidJoinCount() + statistics.getCumIosJoinCount() + statistics.getCumEtcJoinCount();
			lastModifyDate = statistics.getModifiedAt();
		} else {
			totalJoinCount = 0;
			lastModifyDate = ZonedDateTime.now();
		}
		model.addAttribute("totalJoinCount", totalJoinCount);
		model.addAttribute("lastModifyDate", lastModifyDate);

		DateTimeFormatter pattern = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		model.addAttribute("from", from.format(pattern));
		model.addAttribute("to", to.format(pattern));
		return "/admin/statistics";
    }

}
