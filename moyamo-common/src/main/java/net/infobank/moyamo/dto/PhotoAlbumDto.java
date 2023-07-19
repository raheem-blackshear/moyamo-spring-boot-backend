package net.infobank.moyamo.dto;


import com.fasterxml.jackson.annotation.JsonView;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.PhotoAlbumMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.PhotoAlbum;

import java.io.Serializable;
import java.time.ZonedDateTime;

@Data
@NoArgsConstructor
@JsonView({Views.BaseView.class})
public class PhotoAlbumDto implements Serializable {

    private long id;
    private String name;
    private Boolean isDelete;
//    private long ownerId;

    private PostingDto representPhoto;
    private ZonedDateTime createdAt;
    private int photoCnt;

    public static PhotoAlbumDto of(PhotoAlbum photoAlbum) {
        return PhotoAlbumMapper.INSTANCE.of(photoAlbum);
    }

}
