package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.OsType;
import net.infobank.moyamo.models.ReleaseNote;
import net.infobank.moyamo.repository.ReleaseNoteRepository;
import net.infobank.moyamo.util.VersionComparer;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@AllArgsConstructor
public class ReleaseNoteService {

    private final ReleaseNoteRepository releaseNoteRepository;

    public ReleaseNote findReleaseNote(OsType osType) {
        List<ReleaseNote> releaseNotes = releaseNoteRepository.findByOsTypeOrderByReleaseDateDesc(osType);
        if(!releaseNotes.isEmpty()) {
            return releaseNotes.get(0);
        }

        return null;
    }

    public VersionComparer.AppUpdateResult findReleaseNote(OsType osType, String version) {
        List<ReleaseNote> releaseNotes = releaseNoteRepository.findByOsTypeOrderByReleaseDateDesc(osType);
        if(!releaseNotes.isEmpty()) {
            ReleaseNote releaseNote = releaseNotes.get(0);
            VersionComparer.AppUpdateResult result;
            if(version != null && !version.isEmpty()) {
                result = VersionComparer.checkVersion(releaseNote, version);
            } else {
                result = new VersionComparer.AppUpdateResult(releaseNote.getVersion(), null, releaseNote.getForceUpdate());
            }
            return result;
        }
        return null;
    }



}
