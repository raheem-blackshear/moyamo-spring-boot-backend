package net.infobank.moyamo.service;

import lombok.SneakyThrows;
import net.infobank.moyamo.dto.AdminBannerDto;
import net.infobank.moyamo.dto.BannerDto;
import net.infobank.moyamo.enumeration.BannerStatus;
import net.infobank.moyamo.form.CreateBannerVo;
import net.infobank.moyamo.form.UpdateBannerOrderVo;
import net.infobank.moyamo.form.UpdateBannerVo;
import net.infobank.moyamo.models.Resource;
import net.infobank.moyamo.repository.AdminBannerRepository;
import net.infobank.moyamo.util.AuthUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityManager;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class AdminBannerService {

    @Autowired
    AdminBannerRepository adminBannerRepository;

    @Autowired
    BadgeService badgeService;

    @Autowired
    UserService userService;

    @Autowired
    AuthUtils authUtils;

    @Autowired
    EntityManager em;

    @Autowired
    BannerService bannerService;

    //조회
    @Transactional(readOnly = true)
    public Map<String, Object> getAllAdminBanners(int draw, String query, Pageable pageable) {
        Map<String, Object> map = new HashMap<>();
        List<AdminBannerDto> badgeList = adminBannerRepository.findBySearch(query, pageable).stream().map(AdminBannerDto::of).filter(Objects::nonNull).collect(Collectors.toList());
        long cnt = adminBannerRepository.countBySearch(query);
        map.put("data", badgeList);
        map.put("totalCnt", cnt);
        map.put("recordsFiltered", cnt);
        map.put("draw",draw);
        return map;
    }

    //등록
    @SneakyThrows
    @Transactional
    public BannerDto registBanner(String title, Resource.ResourceType resourceType, String resourceId, LocalDate start, LocalDate end, BannerStatus status, MultipartFile file) {
        CreateBannerVo vo = new CreateBannerVo(title, resourceType, resourceId, start, end, status, file);
        return bannerService.createBanner(vo);
    }

    //수정
    @SneakyThrows
    @Transactional
    public BannerDto updateBanner(Long id, MultipartFile file, String title, LocalDate start, LocalDate end, BannerStatus status) {
        UpdateBannerVo vo = new UpdateBannerVo(title, file, start, end, status);
        return bannerService.updateBanner(id, vo);
    }

    @SneakyThrows
    @Transactional
    public void updateOrder(Integer[] orderRanks, Long[] ids) {
        bannerService.updateBannerOrder(new UpdateBannerOrderVo(orderRanks, ids));
    }

}
