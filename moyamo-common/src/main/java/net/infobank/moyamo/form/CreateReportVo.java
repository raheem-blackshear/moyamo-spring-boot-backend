package net.infobank.moyamo.form;

import lombok.Data;
import net.infobank.moyamo.util.CommonUtils;

import javax.validation.constraints.NotEmpty;

@Data
public class CreateReportVo {

    @NotEmpty
    private String title;

    private String text;


    public String getTitle() {
        return CommonUtils.convertDotString(this.title, 32);
    }

    public String getText() {
        return CommonUtils.convertDotString(this.title, 1024);
    }
}
