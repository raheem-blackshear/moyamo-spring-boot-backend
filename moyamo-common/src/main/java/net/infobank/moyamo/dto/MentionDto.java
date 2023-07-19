package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.MentionMapper;
import net.infobank.moyamo.json.Views;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
@JsonIgnoreProperties({"owner"})
public class MentionDto implements Serializable {
    private UserDto owner;
    public static MentionDto of(CommentDto comment) {
        return MentionMapper.INSTANCE.of(comment);
    }

}
