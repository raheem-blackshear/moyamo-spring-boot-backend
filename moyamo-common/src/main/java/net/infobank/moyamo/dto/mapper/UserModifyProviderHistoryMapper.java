package net.infobank.moyamo.dto.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import net.infobank.moyamo.dto.UserModifyProviderHistoryDto;
import net.infobank.moyamo.models.UserModifyProviderHistory;

@Mapper
public interface UserModifyProviderHistoryMapper {

    UserModifyProviderHistoryMapper INSTANCE = Mappers.getMapper( UserModifyProviderHistoryMapper.class );

    UserModifyProviderHistoryDto of(UserModifyProviderHistory userModifyProviderHistory);
}
