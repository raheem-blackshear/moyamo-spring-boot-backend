package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.UserWithExpertGroupDto;
import net.infobank.moyamo.models.User;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserWithExpertGroupMapper {
    UserWithExpertGroupMapper INSTANCE = Mappers.getMapper( UserWithExpertGroupMapper.class );
    UserWithExpertGroupDto of(User user);
}
