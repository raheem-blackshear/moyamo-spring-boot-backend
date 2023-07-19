package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.models.board.MagazineWait;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AdminMagazineCopyMapper {

    AdminMagazineCopyMapper INSTANCE = Mappers.getMapper( AdminMagazineCopyMapper.class );

    MagazineWait of(PostingDto posting);
}
