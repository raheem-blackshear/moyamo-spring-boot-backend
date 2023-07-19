package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.PostingActivityDto;
import net.infobank.moyamo.models.Posting;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface PostingActivityMapper {
    PostingActivityMapper INSTANCE = Mappers.getMapper( PostingActivityMapper.class );
    PostingActivityDto of(Posting posting);
}
