package net.infobank.moyamo.form;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.models.board.ClinicCondition;
import org.springframework.validation.annotation.Validated;

import java.util.List;


@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Validated
@ToString(callSuper = true)
public class CreatePostVo extends BasePostVo {

    private PostingType postingType;

    private List<String> goodsNos;

    private ClinicCondition.ClinicConditionPlace place;
    private ClinicCondition.ClinicConditionLight light;
    private ClinicCondition.ClinicConditionWater water;
    private ClinicCondition.ClinicDetailRepotting repotting;

    private String youtubeId;

}
