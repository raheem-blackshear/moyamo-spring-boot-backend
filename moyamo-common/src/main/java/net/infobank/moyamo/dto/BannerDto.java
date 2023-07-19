package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.common.configurations.ServiceHost;
import net.infobank.moyamo.dto.mapper.BannerMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Banner;
import net.infobank.moyamo.models.ImageResource;

import java.io.Serializable;

@Data
@JsonView(Views.BaseView.class)
@NoArgsConstructor
@AllArgsConstructor
public class BannerDto implements Serializable {

    private String title;
    private ResourceDto resource;
    @JsonIgnore
    private ImageResource imageResource;

    private String photoUrl;

    public String getPhotoUrl() {
        if (photoUrl != null)
            return photoUrl;

        if(imageResource == null)
            return null;

        return ServiceHost.getS3Url(imageResource.getFilekey());
    }

    public void setPhotoUrl(String url) {
        this.photoUrl = url;
    }


    public static BannerDto of(Banner banner) {
        return BannerMapper.INSTANCE.of(banner);
    }
}
