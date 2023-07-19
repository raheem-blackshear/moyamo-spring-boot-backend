package net.infobank.moyamo.form;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.multipart.MultipartFile;

@Data
@EqualsAndHashCode(callSuper = true)
@Validated
public class CreateCommentVo extends BaseCommentVo {

    private MultipartFile files;
}
