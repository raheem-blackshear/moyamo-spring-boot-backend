package net.infobank.moyamo.dto.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import net.infobank.moyamo.dto.NotificationAdminDto;
import net.infobank.moyamo.models.NotificationAdmin;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface NotificationAdminMapper {
    NotificationAdminMapper INSTANCE = Mappers.getMapper( NotificationAdminMapper.class );
    NotificationAdminDto of(NotificationAdmin notification);
}
