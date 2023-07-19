package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.NoticeDto;
import net.infobank.moyamo.models.Notice;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface NoticeMapper {
    NoticeMapper INSTANCE = Mappers.getMapper( NoticeMapper.class );
    NoticeDto of(Notice notice);
}
