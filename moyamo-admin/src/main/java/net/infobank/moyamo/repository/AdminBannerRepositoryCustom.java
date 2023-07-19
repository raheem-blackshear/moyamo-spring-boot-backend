package net.infobank.moyamo.repository;


import net.infobank.moyamo.dto.AdminBannerDto;
import net.infobank.moyamo.enumeration.BannerStatus;
import net.infobank.moyamo.models.BannerManager;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class AdminBannerRepositoryCustom {

    private final BannerManagerRepository bannerManagerRepository;

    @SuppressWarnings("unused")
    public AdminBannerRepositoryCustom(EntityManager em, BannerManagerRepository bannerManagerRepository) {
        this.bannerManagerRepository = bannerManagerRepository;
    }

    public List<AdminBannerDto> findAll(String query, BannerStatus status) {
        List<BannerManager> managers = bannerManagerRepository.findAll();
        if(managers.isEmpty()) {
            return Collections.emptyList();
        }

        return managers.get(0).getBanners().stream().filter(banner -> {

            boolean filtered = true;
            if(StringUtils.isNotBlank(query)) {
                filtered = (banner.getTitle() != null && banner.getTitle().contains(query));
            }

            if(status != null) {
                filtered &= (banner.getStatus().equals(status));
            }

            return filtered;
        }).map(AdminBannerDto::of).sorted(Comparator.comparingInt(AdminBannerDto::getSeq)).collect(Collectors.toList());
    }

}
