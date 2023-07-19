package net.infobank.moyamo.controller;

import com.fasterxml.jackson.annotation.JsonView;
import net.infobank.moyamo.dto.AdminBannerDto;
import net.infobank.moyamo.enumeration.BannerStatus;
import net.infobank.moyamo.form.CreateBannerVo;
import net.infobank.moyamo.form.UpdateBannerOrderVo;
import net.infobank.moyamo.form.UpdateBannerVo;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.repository.AdminBannerRepositoryCustom;
import net.infobank.moyamo.service.AdminBannerService;
import net.infobank.moyamo.service.BannerService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/rest/banner")
public class RestAdminBannerContoller {

    private final AdminBannerService adminBannerService;
    private final BannerService bannerService;
    private final AdminBannerRepositoryCustom adminBannerRepositoryCustom;

    public RestAdminBannerContoller(AdminBannerService adminBannerService, BannerService bannerService, AdminBannerRepositoryCustom adminBannerRepositoryCustom) {
        this.adminBannerService = adminBannerService;
        this.bannerService = bannerService;
        this.adminBannerRepositoryCustom = adminBannerRepositoryCustom;
    }

    @JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/getList")
    public ResponseEntity<Map<String, Object>> getBadges(@RequestParam("draw") int draw, @RequestParam("start") int start, @RequestParam("length") int length, @RequestParam("search.value") String query) {
        return new ResponseEntity<>(adminBannerService.getAllAdminBanners(draw, query, PageRequest.of(start/length, length, Sort.by(Sort.Direction.DESC, "id"))), HttpStatus.OK);
    }


    @JsonView(Views.WebAdminJsonView.class)
    @PostMapping("/getAll")
    public List<AdminBannerDto> getBadgeAll(@RequestParam(value = "q", required = false) String query, @RequestParam(value = "status", required = false) BannerStatus status) {
        return adminBannerRepositoryCustom.findAll(query, status);
    }

    @JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/regist")
    @Transactional(rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> registBanner(@ModelAttribute CreateBannerVo vo) throws IOException, InterruptedException {
        Map<String, Object> map = new HashMap<>();
        bannerService.createBanner(vo);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/{id}/update")
    @Transactional(rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> updateBanner(@PathVariable("id") Long id, @ModelAttribute UpdateBannerVo vo) throws IOException, InterruptedException {
        Map<String, Object> map = new HashMap<>();
        bannerService.updateBanner(id, vo);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/{id}/remove")
    @Transactional(rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> removeBanner(@PathVariable("id") Long id) {
        Map<String, Object> map = new HashMap<>();
        bannerService.remove(id);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @JsonView(Views.WebAdminJsonView.class)
    @RequestMapping("/order")
    @Transactional(isolation = Isolation.SERIALIZABLE, rollbackFor = Exception.class)
    public ResponseEntity<Map<String, Object>> updateOrder(@RequestBody UpdateBannerOrderVo vo) {
        Map<String, Object> map = new HashMap<>();
        bannerService.updateBannerOrder(vo);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }







}
