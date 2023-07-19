package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.json.Views;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.BaseView.class)
public class AdminPostingListResultDto {
    private int totalCnt;
    private int recordsFiltered;
    private int draw;
    private List<PostingDto> data;
}
