package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.Resource;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
public class ResourceDto implements Serializable {
    private String resourceId;
    private Resource.ResourceType resourceType;
    private String referenceId;
    private Resource.ResourceType referenceType;
}
