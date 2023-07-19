package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.AdminBannerDto;
import net.infobank.moyamo.models.Banner;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AdminBannerDtoMapper {
    AdminBannerDtoMapper INSTANCE = Mappers.getMapper( AdminBannerDtoMapper.class );
    AdminBannerDto of(Banner banner);
}
