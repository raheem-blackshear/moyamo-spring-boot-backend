package net.infobank.moyamo.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonView;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.dto.mapper.UserPostingRelationMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.UserPostingRelation;

@Data
@Getter
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.WebAdminJsonView.class)
public class UserPostingRelationDto  implements Serializable {

	private static final long serialVersionUID = -900104790061831037L;
	private UserDto user;
    private PostingDto posting;

	public static UserPostingRelationDto of(UserPostingRelation userPostingRelation) {
        return  UserPostingRelationMapper.INSTANCE.of(userPostingRelation);
    }
}
