package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.UserPostingRelationDto;
import net.infobank.moyamo.models.UserPostingRelation;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserPostingRelationMapper {
	UserPostingRelationMapper INSTANCE = Mappers.getMapper( UserPostingRelationMapper.class );
	UserPostingRelationDto of(UserPostingRelation userRelation);
}
