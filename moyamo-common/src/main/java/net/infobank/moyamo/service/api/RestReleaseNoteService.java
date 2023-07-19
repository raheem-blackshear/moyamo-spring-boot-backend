package net.infobank.moyamo.service.api;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.ReleaseNoteDto;
import net.infobank.moyamo.enumeration.OsType;
import net.infobank.moyamo.service.ReleaseNoteService;
import net.infobank.moyamo.service.elasticsearch.CacheValues;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;


@Slf4j
@Service
@AllArgsConstructor
public class RestReleaseNoteService<T extends ReleaseNoteDto> {

    private final ReleaseNoteService releaseNoteService;

//    @Cacheable(value = CacheValues.RELEASE_NOTES, key = "{#osType}", unless = "#result == null || #osType == null")
    @Cacheable(value = CacheValues.RELEASE_NOTES, key = "{#osType}", unless = "#osType == null")
    public T findReleaseNote(OsType osType) {
        return (T)T.of(releaseNoteService.findReleaseNote(osType));
    }


    @Cacheable(value = CacheValues.RELEASE_NOTES, key = "{#osType, #version}", unless = "#osType == null")
    public T findReleaseNote(OsType osType, String version) {
        return (T)T.of(releaseNoteService.findReleaseNote(osType, version));
    }
}
