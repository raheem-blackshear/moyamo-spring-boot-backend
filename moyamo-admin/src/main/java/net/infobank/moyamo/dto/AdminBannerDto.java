package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.common.configurations.ServiceHost;
import net.infobank.moyamo.dto.mapper.AdminBannerDtoMapper;
import net.infobank.moyamo.enumeration.BannerStatus;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Banner;
import net.infobank.moyamo.models.ImageResource;

import java.io.Serializable;
import java.time.ZonedDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.WebAdminJsonView.class)
public class AdminBannerDto implements Serializable {

    private Long id;

    private String title;

    private ImageResource imageResource;

    private String photoUrl = null;

    public String getPhotoUrl() {
        if (this.photoUrl != null) {
            return this.photoUrl;
        } else {
            return this.imageResource == null ? null : ServiceHost.getS3Url(this.imageResource.getFilekey());
        }
    }

    public void setPhotoUrl(String url) {
        this.photoUrl = url;
    }

    private ResourceDto resource;

    private ZonedDateTime start;

    private ZonedDateTime end;

    private int seq;

    private BannerStatus status;

    public static AdminBannerDto of(Banner banner) {
        return AdminBannerDtoMapper.INSTANCE.of(banner);
    }
}
