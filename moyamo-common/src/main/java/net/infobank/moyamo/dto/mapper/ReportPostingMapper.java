package net.infobank.moyamo.dto.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import net.infobank.moyamo.dto.ReportPostingDto;
import net.infobank.moyamo.models.ReportPosting;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ReportPostingMapper {
	ReportPostingMapper INSTANCE = Mappers.getMapper( ReportPostingMapper.class );
    ReportPostingDto of(ReportPosting reportPosting);
}
