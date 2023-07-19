package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.models.board.BoastWait;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AdminBoastCopyMapper {
    AdminBoastCopyMapper INSTANCE = Mappers.getMapper( AdminBoastCopyMapper.class );
    BoastWait of(PostingDto posting);
}
