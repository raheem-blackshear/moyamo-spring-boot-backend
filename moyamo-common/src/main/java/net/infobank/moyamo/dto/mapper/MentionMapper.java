package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.CommentDto;
import net.infobank.moyamo.dto.MentionDto;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface MentionMapper {
    MentionMapper INSTANCE = Mappers.getMapper( MentionMapper.class );
    MentionDto of(CommentDto comment);
}
