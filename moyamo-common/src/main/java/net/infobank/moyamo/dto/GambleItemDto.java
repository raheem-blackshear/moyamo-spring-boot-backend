package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.GambleItemMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.GambleItem;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
public class GambleItemDto implements Serializable {

    private Long id;

    private String name;

    @JsonView(Views.WebAdminJsonView.class)
    private int remains;

    @JsonView(Views.WebAdminJsonView.class)
    private int amount;

    private boolean address;
    private boolean blank;

    public static GambleItemDto of(GambleItem gambleItem) {
        return GambleItemMapper.INSTANCE.of(gambleItem);
    }
}
