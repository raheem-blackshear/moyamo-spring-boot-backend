package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.ReportCommentDto;
import net.infobank.moyamo.dto.UserCommentRelationDto;
import net.infobank.moyamo.models.ReportComment;
import net.infobank.moyamo.models.UserCommentRelation;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ReportCommentMapper {
	ReportCommentMapper INSTANCE = Mappers.getMapper( ReportCommentMapper.class );


    @Named("commentOf")
    static UserCommentRelationDto postingIdOf(UserCommentRelation relation) {
        UserCommentRelationDto dto = UserCommentRelationDto.of(relation);
        dto.getComment().setPostingId(relation.getComment().getPosting().getId());
        return dto;
    }

    @Mapping(target = "relation", qualifiedByName = "commentOf")
    ReportCommentDto of(ReportComment reportComment);
}
