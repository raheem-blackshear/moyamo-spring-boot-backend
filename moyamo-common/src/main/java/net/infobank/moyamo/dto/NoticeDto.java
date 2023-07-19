package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.common.configurations.ServiceHost;
import net.infobank.moyamo.dto.mapper.NoticeMapper;
import net.infobank.moyamo.enumeration.NoticeStatus;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.ImageResource;
import net.infobank.moyamo.models.Notice;

import java.io.Serializable;
import java.time.ZonedDateTime;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class NoticeDto implements Serializable {

    private long id;

    private String title;
    private String description;

    //노출시작시간
    private ZonedDateTime start;

    //노출종료시간
    private ZonedDateTime end;

    @JsonIgnore
    private ImageResource imageResource;

    private int interval;
    private NoticeStatus status;
    private String url;
    private boolean popup;

    private String photoUrl = null;

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

    public static NoticeDto of(Notice notice) {
        return NoticeMapper.INSTANCE.of(notice);
    }

}
