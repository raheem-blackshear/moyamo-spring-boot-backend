package net.infobank.moyamo.form;

import lombok.Data;
import net.infobank.moyamo.enumeration.PostingType;
import org.springframework.validation.annotation.Validated;

@Data
@Validated
public class SwitchingPostTypeVo {
    private PostingType postingType;
}
