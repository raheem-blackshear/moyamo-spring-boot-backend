package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.enumeration.ExpertGroup;
import net.infobank.moyamo.json.Views;

import java.io.Serializable;

@Data
@NoArgsConstructor
@JsonView(Views.WebAdminJsonView.class)
public class UserExpertGroupDto implements Serializable {

    @JsonView(Views.WebAdminJsonView.class)
    private ExpertGroup expertGroup;
}
