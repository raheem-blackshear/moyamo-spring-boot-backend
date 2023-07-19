package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.*;
import net.infobank.moyamo.dto.mapper.UserCommentRelationMapper;
import net.infobank.moyamo.json.Views;
import net.infobank.moyamo.models.UserCommentRelation;

import java.io.Serializable;

@Data
@Getter
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.WebAdminJsonView.class)
public class UserCommentRelationDto implements Serializable {

	private static final long serialVersionUID = -900104790061831037L;
	private UserDto user;
    private CommentDto comment;

	public static UserCommentRelationDto of(UserCommentRelation userCommentRelation) {
        return  UserCommentRelationMapper.INSTANCE.of(userCommentRelation);
    }
}
