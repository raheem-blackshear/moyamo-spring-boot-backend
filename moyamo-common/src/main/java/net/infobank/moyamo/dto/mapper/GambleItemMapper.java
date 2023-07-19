package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.GambleItemDto;
import net.infobank.moyamo.models.GambleItem;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface GambleItemMapper {
    GambleItemMapper INSTANCE = Mappers.getMapper( GambleItemMapper.class );
    GambleItemDto of(GambleItem gambleItem);
}
