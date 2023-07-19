package net.infobank.moyamo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class SearchQueryCountDto {

    private String keyword;

    private long count;

}
