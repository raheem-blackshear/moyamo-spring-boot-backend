package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.UserDto;
import net.infobank.moyamo.dto.UserModifyProviderLoginDto;
import net.infobank.moyamo.models.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import java.time.ZonedDateTime;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper( UserMapper.class );
    UserDto of(User user);


    @Mapping(target = "photoEnable", source = "user", qualifiedByName = "setPhotoEnable")
    UserDto ofWithPhotoProperty(User user);

    @Named("setPhotoEnable")
    default boolean setPhotoEnable(User user){
        return user.getUserSetting().getPhotoEnable();
    }

    UserModifyProviderLoginDto of(User user, String userToken, String userTokenExpireAt, String refreshToken, String refreshTokenExpireAt, Boolean isAdNotiAgreement, ZonedDateTime adNotiAgreedAt);
}
