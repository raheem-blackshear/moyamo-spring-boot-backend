package net.infobank.moyamo.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.UserModifyProviderHistoryMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.UserModifyProviderHistory;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserModifyProviderHistoryDto implements Serializable {


    private Long id;

    private String provider;

    private String providerId;

    private String nickname;

    public static UserModifyProviderHistoryDto of(UserModifyProviderHistory userModifyProviderHistory) {
        return UserModifyProviderHistoryMapper.INSTANCE.of(userModifyProviderHistory);
    }

}
