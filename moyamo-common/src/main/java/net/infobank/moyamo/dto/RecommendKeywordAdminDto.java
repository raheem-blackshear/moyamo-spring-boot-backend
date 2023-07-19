package net.infobank.moyamo.dto;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.enumeration.RecommendKeywordType;
import net.infobank.moyamo.json.Views;

import java.time.ZonedDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonView(Views.WebAdminJsonView.class)
public class RecommendKeywordAdminDto {
    private Long id;

    private RecommendKeywordType type;

    private String content;

    private List<RecommendKeywordDto> keywords;

    private ZonedDateTime createdAt;
}