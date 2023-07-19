package net.infobank.moyamo.dto;

import java.io.Serializable;
import java.time.ZonedDateTime;

import org.mapstruct.Mapper;

import com.fasterxml.jackson.annotation.JsonView;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.RequiredArgsConstructor;
import net.infobank.moyamo.common.configurations.ServiceHost;
import net.infobank.moyamo.dto.mapper.NotificationAdminMapper;
import net.infobank.moyamo.enumeration.ExpertGroup;
import net.infobank.moyamo.enumeration.OsType;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.ImageResource;
import net.infobank.moyamo.models.NotificationAdmin;

@Data
@EqualsAndHashCode(callSuper = false)
@AllArgsConstructor
@RequiredArgsConstructor
@JsonView(Views.WebAdminJsonView.class)
@Mapper
public class NotificationAdminDto implements Serializable {

	private Long id;

	private UserDto owner;

	private String title;

	private String text;

	private String link;

	private boolean isReserved;

	// 예약시간
    private ZonedDateTime reservedTime;

    // 발송테스트시간
    private ZonedDateTime testTime;

    // 발송시간
    private ZonedDateTime sendTime;

    private boolean isSendTest;

    private OsType deviceGroup;

    private ExpertGroup targetGroup;

    private UserDto user;
    private PostingDto posting;

    private ZonedDateTime createdAt;
    private ZonedDateTime modifiedAt;

    private ImageResource thumbnail;

    private String photoUrl = null;

    public String getPhotoUrl() {
        if (photoUrl != null)
            return photoUrl;

        if(thumbnail == null)
            return null;

        return ServiceHost.getS3Url(thumbnail.getFilekey());
    }

    public static NotificationAdminDto of(NotificationAdmin notification) {
        return NotificationAdminMapper.INSTANCE.of(notification);
    }

}
