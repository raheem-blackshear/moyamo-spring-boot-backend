package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import net.infobank.moyamo.dto.mapper.ClinicConditionMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.board.ClinicCondition;

import java.io.Serializable;

@JsonView({Views.BaseView.class})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClinicConditionDto implements Serializable {

    @NonNull
    private ClinicCondition.ClinicConditionPlace place;

    @NonNull
    private ClinicCondition.ClinicConditionLight light;

    @NonNull
    private ClinicCondition.ClinicConditionWater water;

    @NonNull
    private ClinicCondition.ClinicDetailRepotting repotting;

    public static ClinicConditionDto of(ClinicCondition clinicCondition) {
        return ClinicConditionMapper.INSTANCE.of(clinicCondition);
    }

}
