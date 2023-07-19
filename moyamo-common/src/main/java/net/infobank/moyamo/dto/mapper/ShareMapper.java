package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.ShareDto;
import net.infobank.moyamo.models.Share;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface ShareMapper {

    ShareMapper INSTANCE = Mappers.getMapper( ShareMapper.class );
    ShareDto of(Share share);
}
