package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.BannerDto;
import net.infobank.moyamo.models.Banner;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BannerMapper {
    BannerMapper INSTANCE = Mappers.getMapper( BannerMapper.class );
    BannerDto of(Banner banner);
}
