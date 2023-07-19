package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.UserSecurityDto;
import net.infobank.moyamo.models.UserSecurity;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserSecurityMapper {
    UserSecurityMapper INSTANCE = Mappers.getMapper( UserSecurityMapper.class );
    UserSecurityDto of(UserSecurity security);
}
