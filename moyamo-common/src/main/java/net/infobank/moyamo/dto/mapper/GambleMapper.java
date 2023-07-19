package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.GambleDto;
import net.infobank.moyamo.models.Gamble;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface GambleMapper {
    GambleMapper INSTANCE = Mappers.getMapper( GambleMapper.class );
    GambleDto of(Gamble gamble);
}
