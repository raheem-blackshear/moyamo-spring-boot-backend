package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.AttachmentMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Attachment;
import net.infobank.moyamo.models.ImageResource;
import net.infobank.moyamo.common.configurations.ServiceHost;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AttachmentDto implements Serializable {

    private long id;

    private String description;

    @JsonIgnore
    private ImageResource imageResource;

    private String photoUrl = null;

    private String dimension;

    private String placeName;

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

    public static AttachmentDto of(Attachment attachment) {
        return AttachmentMapper.INSTANCE.of(attachment);
    }

}
