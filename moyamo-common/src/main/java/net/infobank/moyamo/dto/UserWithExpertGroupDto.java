package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.UserWithExpertGroupMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.UserBadge;

import java.util.List;
import java.util.stream.Collectors;

@EqualsAndHashCode(callSuper = true)
@Data
@JsonView(Views.BaseView.class)
@NoArgsConstructor
public class UserWithExpertGroupDto extends UserDto {

    @JsonView(Views.WebAdminJsonView.class)
	private List<UserExpertGroupDto> expertGroup;

    @JsonView(Views.WebAdminJsonView.class)
    private String memo;

    private Long reportPostingCount;
    private Long reportCommentCount;


    @JsonView({Views.WebAdminJsonView.class})
    private String providerId;

    private String shopUserId;

    public static UserWithExpertGroupDto of(User user) {
        UserWithExpertGroupDto dto = UserWithExpertGroupMapper.INSTANCE.of(user);
        if(user.getSecurity() != null)
            dto.setMemo(user.getSecurity().getMemo());

        ShopUserDto shopUser = ShopUserDto.of(user);
        if(shopUser != null) {
            dto.shopUserId = shopUser.getShopUserId();
        }

        dto.setMyBadges(user.getMyBadges().stream().map(UserBadge::getBadge).map(BadgeDto::of).collect(Collectors.toList()));
        dto.setPhotoEnable(user.getUserSetting().getPhotoEnable());
        return dto;
    }

    private List<BadgeDto> myBadges;
}
