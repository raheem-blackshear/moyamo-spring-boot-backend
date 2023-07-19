package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.ShippingDto;
import net.infobank.moyamo.models.UserEventInfo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AddressMapper {
    AddressMapper INSTANCE = Mappers.getMapper( AddressMapper.class );

    ShippingDto of(UserEventInfo userEventInfo);
}
