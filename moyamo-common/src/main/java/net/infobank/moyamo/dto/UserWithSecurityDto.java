package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.UserWithSecurityMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.User;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView({Views.BaseView.class, Views.WebAdminJsonView.class})
public class UserWithSecurityDto extends UserDto {

    @JsonView({Views.MyProfileDetailJsonView.class, Views.WebAdminJsonView.class})
    private UserSecurityDto security;

    @JsonView({Views.MyProfileDetailJsonView.class, Views.WebAdminJsonView.class})
    private String provider;

    public static UserWithSecurityDto of(User user) {
        return UserWithSecurityMapper.INSTANCE.of(user);
    }

    public static UserWithSecurityDto ofPhotoEnable(User user) {
        return UserWithSecurityMapper.INSTANCE.ofWithPhotoProperty(user);
    }
}
