package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.GambleResultMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.GambleResult;

import java.io.Serializable;
import java.time.ZonedDateTime;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
public class GambleResultDto implements Serializable {

    private Long id;

    @JsonIgnoreProperties("gamble")
    private GambleItemDto item;

    @JsonIgnoreProperties({"photoUrl", "level", "role", "status", "levelInfo", "activity", "provider", "createdAt"})
    private ShopUserDto user;

    private Boolean needAddress;

    @JsonView(Views.WebAdminJsonView.class)
    private ShippingDto address;

    @JsonView(Views.WebAdminJsonView.class)
    private ZonedDateTime createdAt;

    public static GambleResultDto of(GambleResult result) {
        return GambleResultMapper.INSTANCE.of(result);
    }
}
