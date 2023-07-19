package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.TagDto;
import net.infobank.moyamo.models.Tag;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface TagMapper {
    TagMapper INSTANCE = Mappers.getMapper( TagMapper.class );
    TagDto of(Tag tag);
}
