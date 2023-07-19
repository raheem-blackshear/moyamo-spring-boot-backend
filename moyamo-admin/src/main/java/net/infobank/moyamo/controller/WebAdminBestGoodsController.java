package net.infobank.moyamo.controller;

import lombok.AllArgsConstructor;
import net.infobank.moyamo.service.GoodsRankingService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@AllArgsConstructor
@Controller
@RequestMapping("/admin/**")
public class WebAdminBestGoodsController {

    private final GoodsRankingService goodsRankingService;

    @RequestMapping("/bestGoods")
    public String bestGoods(Model model) {
        model.addAttribute("menuName", "랭킹");
        return "/admin/bestGoods";
    }

    @RequestMapping("/registBestGoods")
    public String registBestGoods(HttpServletRequest request) {
        List<Integer> writeStartDatepickers = Arrays.stream(request.getParameter("writeStartDatepicker").split("-")).map(Integer::valueOf).collect(Collectors.toList());
        LocalDateTime startDateLocal = LocalDateTime.of(writeStartDatepickers.get(0), writeStartDatepickers.get(1), writeStartDatepickers.get(2), Integer.parseInt(request.getParameter("startTime")), Integer.parseInt(request.getParameter("startMinute")));
        ZonedDateTime startDate = ZonedDateTime.of(startDateLocal, ZoneId.of("Asia/Seoul"));

        List<Integer> writeEndDatepickers = Arrays.stream(request.getParameter("writeEndDatepicker").split("-")).map(Integer::valueOf).collect(Collectors.toList());
        LocalDateTime endDateLocal = LocalDateTime.of(writeEndDatepickers.get(0), writeEndDatepickers.get(1), writeEndDatepickers.get(2), Integer.parseInt(request.getParameter("endTime")), Integer.parseInt(request.getParameter("endMinute")));
        ZonedDateTime endDate = ZonedDateTime.of(endDateLocal, ZoneId.of("Asia/Seoul"));

        goodsRankingService.registBestGoods(request.getParameterValues("writetitle"), startDate, endDate, request.getParameter("status"));

        return "redirect:/admin/bestGoods";
    }
}
