package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.ShareMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Resource;
import net.infobank.moyamo.models.Share;

import java.io.Serializable;
import java.util.UUID;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
public class ShareDto implements Serializable {

    //https://blog.deliwind.com/posts/235

    private UUID uuid;

    @JsonView(Views.BaseView.class)
    private Resource resource;

    private String deeplink;

    public static ShareDto of(Share share) {
        return ShareMapper.INSTANCE.of(share);
    }


}
