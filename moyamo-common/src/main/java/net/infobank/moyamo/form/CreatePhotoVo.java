package net.infobank.moyamo.form;

import lombok.Data;
import net.infobank.moyamo.enumeration.PostingType;
import org.springframework.web.multipart.MultipartFile;

@Data
public class CreatePhotoVo {
    private MultipartFile[] files;

    private String[] texts;

    private String[] albumNames;

    private PostingType postingType;
}
