package net.infobank.moyamo.dto.shop;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@lombok.Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class GoodsResponseDto implements Serializable {
    private HeaderDto header;

    @JacksonXmlElementWrapper(localName = "return")
    @JacksonXmlProperty(localName = "goods_data")
    private List<GoodsDataDto> goodsDataDtos;
}
