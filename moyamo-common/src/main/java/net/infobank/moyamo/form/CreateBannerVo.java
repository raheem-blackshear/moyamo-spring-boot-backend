package net.infobank.moyamo.form;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.enumeration.BannerStatus;
import net.infobank.moyamo.models.Resource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateBannerVo {
    private String title;
    private Resource.ResourceType resourceType;
    private String resourceId;

    @DateTimeFormat(pattern="yyyy-MM-dd", iso = DateTimeFormat.ISO.DATE)
    private LocalDate start;
    @DateTimeFormat(pattern="yyyy-MM-dd", iso = DateTimeFormat.ISO.DATE)
    private LocalDate end;
    private BannerStatus status;
    private MultipartFile file;
}
