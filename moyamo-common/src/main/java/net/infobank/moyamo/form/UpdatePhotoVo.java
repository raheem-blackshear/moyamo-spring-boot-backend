package net.infobank.moyamo.form;

import lombok.Data;
import net.infobank.moyamo.enumeration.PostingType;

@Data
public class UpdatePhotoVo {

    private PostingType postingType;
    private String text;

}
