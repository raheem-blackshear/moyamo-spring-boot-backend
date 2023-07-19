package net.infobank.moyamo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminCopyPostingDto {
    private String title;
    private String text;
    private List<AttachmentDto> attachments;
    private int readCount;
    private int shareCount;
    private int scrapCount;
}
