package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.UserSecurityMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.UserSecurity;

import java.io.Serializable;
import java.time.ZonedDateTime;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.MyProfileDetailJsonView.class)
public class UserSecurityDto implements Serializable {

    private String email;
    private String phoneNumber;

    private String authIdKey; //휴대폰 번호 인증번호
    private ZonedDateTime authIdKeySendedAt; //휴대폰 번호 인증번호 발송 시간

    public static UserSecurityDto of(UserSecurity security) {
        return UserSecurityMapper.INSTANCE.of(security);
    }

}
