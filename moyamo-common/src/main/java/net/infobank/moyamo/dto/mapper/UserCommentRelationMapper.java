package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.UserCommentRelationDto;
import net.infobank.moyamo.models.UserCommentRelation;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserCommentRelationMapper {
	UserCommentRelationMapper INSTANCE = Mappers.getMapper( UserCommentRelationMapper.class );
	UserCommentRelationDto of(UserCommentRelation userRelation);
}
