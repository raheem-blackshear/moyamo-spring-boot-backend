package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.UserSettingDto;
import net.infobank.moyamo.models.UserSetting;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserSettingMapper {
    UserSettingMapper INSTANCE = Mappers.getMapper( UserSettingMapper.class );
    UserSettingDto of(UserSetting user);
}
