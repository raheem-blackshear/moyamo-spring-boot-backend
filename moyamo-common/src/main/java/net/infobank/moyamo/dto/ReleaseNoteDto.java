package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.ReleaseNoteMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.ReleaseNote;
import net.infobank.moyamo.util.VersionComparer;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReleaseNoteDto implements Serializable {

    private String version;
    private Boolean needUpdate;
    private Boolean forceUpdate;

    public static ReleaseNoteDto of(ReleaseNote releaseNote) {
        return ReleaseNoteMapper.INSTANCE.of(releaseNote);
    }

    public static ReleaseNoteDto of(VersionComparer.AppUpdateResult updateResult) {
        return ReleaseNoteMapper.INSTANCE.of(updateResult);
    }

}
