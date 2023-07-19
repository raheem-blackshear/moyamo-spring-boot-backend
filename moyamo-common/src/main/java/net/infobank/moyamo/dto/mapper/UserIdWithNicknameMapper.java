package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.UserIdWithNicknameDto;
import net.infobank.moyamo.models.User;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserIdWithNicknameMapper {
    UserIdWithNicknameMapper INSTANCE = Mappers.getMapper( UserIdWithNicknameMapper.class );
    UserIdWithNicknameDto of(User user);
}
