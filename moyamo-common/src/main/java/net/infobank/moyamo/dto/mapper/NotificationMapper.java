package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.NotificationDto;
import net.infobank.moyamo.models.Notification;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface NotificationMapper {
    NotificationMapper INSTANCE = Mappers.getMapper( NotificationMapper.class );
    NotificationDto of(Notification notification);
}
