package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.ReleaseNoteDto;
import net.infobank.moyamo.models.ReleaseNote;
import net.infobank.moyamo.util.VersionComparer;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ReleaseNoteMapper {
    ReleaseNoteMapper INSTANCE = Mappers.getMapper( ReleaseNoteMapper.class );

    ReleaseNoteDto of(ReleaseNote releaseNote);
    ReleaseNoteDto of(VersionComparer.AppUpdateResult appUpdateResult);
}
