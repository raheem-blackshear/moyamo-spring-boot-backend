package net.infobank.moyamo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.enumeration.RecommendKeywordType;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecommendKeywordDto {

    private Long id;
    private String name;
    private RecommendKeywordType type;
}
