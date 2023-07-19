package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.GambleVersionDto;
import net.infobank.moyamo.models.GambleVersion;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface GambleVersionMapper {
    GambleVersionMapper INSTANCE = Mappers.getMapper( GambleVersionMapper.class );
    GambleVersionDto of(GambleVersion gambleVersion);
}
