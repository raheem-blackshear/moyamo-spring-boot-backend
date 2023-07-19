package net.infobank.moyamo.dto;

import java.time.ZonedDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.common.configurations.ServiceHost;
import net.infobank.moyamo.dto.mapper.UserMapper;
import net.infobank.moyamo.enumeration.UserRole;
import net.infobank.moyamo.enumeration.UserStatus;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.ImageResource;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.UserActivity;
import net.infobank.moyamo.util.CommonUtils;

@EqualsAndHashCode(callSuper = false)
@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonView({Views.BaseView.class, Views.WebAdminJsonView.class})
//@JsonIgnoreProperties(ignoreUnknown = true, value = {"createdAt", "modifiedAt", "level", "status"})
public class UserModifyProviderLoginDto extends UserIdWithNicknameDto {

    private long id;
    private String nickname;

    private int level;
    private UserRole role;

    private UserStatus status;
    private LevelContainer.LevelInfo levelInfo = null;

    public LevelContainer.LevelInfo getLevelInfo() {
        if (levelInfo != null)
            return levelInfo;

        return LevelContainer.getInstance().findLevelInfo(level);
    }

    public void setLevelInfo(LevelContainer.LevelInfo levelInfo) {
        this.levelInfo = levelInfo;
    }

    @JsonView({Views.UserProfileDetailJsonView.class, Views.WebAdminJsonView.class})
    private UserActivity activity;

    @JsonIgnore
    private ImageResource imageResource;

    private String photoUrl = null;


    @JsonView({Views.MyProfileDetailJsonView.class, Views.WebAdminJsonView.class})
    private String provider;

    @Override
    public String getPhotoUrl() {
        if (photoUrl != null)
            return photoUrl;

        if(imageResource == null)
            return null;

        return ServiceHost.getS3Url( imageResource.getFilekey());
    }

    public void setPhotuUrl(String url) {
        this.photoUrl = url;
    }

    @JsonView(Views.WebAdminJsonView.class)
    private ZonedDateTime createdAt;


    private String userToken;
	private String userTokenExpireAt;
	private String refreshToken;
	private String refreshTokenExpireAt;

	@JsonInclude
	private Boolean adNotiAgreement;
	private ZonedDateTime adNotiConfirmedAt;

    public static UserModifyProviderLoginDto of(User user, String userToken, ZonedDateTime accessTokenExpireAt, String refreshToken, ZonedDateTime refreshTokenExpireAt, Boolean isAdNotiAgreement, ZonedDateTime adNotiConfirmedAti) {
        return UserMapper.INSTANCE.of(user, userToken, CommonUtils.convertDateToString(accessTokenExpireAt), refreshToken, CommonUtils.convertDateToString(refreshTokenExpireAt), isAdNotiAgreement, adNotiConfirmedAti);
    }
}
