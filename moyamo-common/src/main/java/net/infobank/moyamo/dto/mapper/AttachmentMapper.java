package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.AttachmentDto;
import net.infobank.moyamo.models.Attachment;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AttachmentMapper {
    AttachmentMapper INSTANCE = Mappers.getMapper( AttachmentMapper.class );
    AttachmentDto of(Attachment attachment);
}
