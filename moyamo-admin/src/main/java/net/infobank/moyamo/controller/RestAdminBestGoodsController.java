package net.infobank.moyamo.controller;

import net.infobank.moyamo.dto.AdminBestGoodsDto;
import net.infobank.moyamo.dto.GoodsRankingDto;
import net.infobank.moyamo.models.Ranking;
import net.infobank.moyamo.service.GoodsRankingService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/rest")
public class RestAdminBestGoodsController {

    private final GoodsRankingService goodsRankingService;

    public RestAdminBestGoodsController(GoodsRankingService goodsRankingService) {
        this.goodsRankingService = goodsRankingService;
    }

    @RequestMapping("/getBestGoods")
    public ResponseEntity<AdminBestGoodsDto> getBadges(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {

        Integer count = goodsRankingService.getAllBestGoodsCountByRankingType(Ranking.RankingType.best_goods);

        AdminBestGoodsDto adminBestGoodsDto = new AdminBestGoodsDto();
        adminBestGoodsDto.setDraw(draw);
        adminBestGoodsDto.setTotalCnt(count);
        adminBestGoodsDto.setRecordsFiltered(count);
        adminBestGoodsDto.setData(goodsRankingService.getAllBestGoodsByRankingType(Ranking.RankingType.best_goods, start, length).stream().map(GoodsRankingDto::of).collect(Collectors.toList()));

        return new ResponseEntity<>(adminBestGoodsDto, HttpStatus.OK);
    }


    @RequestMapping("/bestGoods/remove/{bestGoodsId}")
    public void removeBestGoods(@PathVariable Long bestGoodsId){
        goodsRankingService.removeBestGoods(bestGoodsId);
    }
    @RequestMapping("/bestGoods/modify/{bestGoodsId}")
    public void modifyBestGoods(@PathVariable Long bestGoodsId, HttpServletRequest request) {
        List<Integer> writeStartDatepickers = Arrays.stream(request.getParameter("startDatepicker").split("-")).map(Integer::valueOf).collect(Collectors.toList());
        LocalDateTime startDateLocal = LocalDateTime.of(writeStartDatepickers.get(0), writeStartDatepickers.get(1), writeStartDatepickers.get(2), Integer.parseInt(request.getParameter("startTime")), Integer.parseInt(request.getParameter("startMinute")));
        ZonedDateTime startDate = ZonedDateTime.of(startDateLocal, ZoneId.of("Asia/Seoul"));

        List<Integer> writeEndDatepickers = Arrays.stream(request.getParameter("endDatepicker").split("-")).map(Integer::valueOf).collect(Collectors.toList());
        LocalDateTime endDateLocal = LocalDateTime.of(writeEndDatepickers.get(0), writeEndDatepickers.get(1), writeEndDatepickers.get(2), Integer.parseInt(request.getParameter("endTime")), Integer.parseInt(request.getParameter("endMinute")));
        ZonedDateTime endDate = ZonedDateTime.of(endDateLocal, ZoneId.of("Asia/Seoul"));

        goodsRankingService.modifyBestGoods(bestGoodsId, request.getParameterValues("code"), startDate, endDate, request.getParameter("status"));
    }

}
