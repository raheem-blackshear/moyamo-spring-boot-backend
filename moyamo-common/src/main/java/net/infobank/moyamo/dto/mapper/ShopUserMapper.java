package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.ShopUserDto;
import net.infobank.moyamo.models.User;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ShopUserMapper {

    ShopUserMapper INSTANCE = Mappers.getMapper( ShopUserMapper.class );
    ShopUserDto of(User user);
}
