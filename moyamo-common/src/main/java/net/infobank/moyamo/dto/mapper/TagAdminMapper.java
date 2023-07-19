package net.infobank.moyamo.dto.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import net.infobank.moyamo.dto.TagAdminDto;
import net.infobank.moyamo.models.Tag;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface TagAdminMapper {
    TagAdminMapper INSTANCE = Mappers.getMapper( TagAdminMapper.class );
    TagAdminDto of(Tag tag);
}
