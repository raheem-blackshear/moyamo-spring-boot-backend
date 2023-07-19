package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.models.board.BoastWait;
import net.infobank.moyamo.models.board.FreeWait;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AdminFreeCopyMapper {
    AdminFreeCopyMapper INSTANCE = Mappers.getMapper( AdminFreeCopyMapper.class );
    FreeWait of(PostingDto posting);
}
