package net.infobank.moyamo.dto.shop;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 쇼핑몰 사용자 예치금 정보
 */
@Data
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true, value = ("memNo"))
@NoArgsConstructor
public class MileageDto implements Serializable {
    private String mileage;
    private String memNo;

    public BigDecimal getMileage() {
        return new BigDecimal(mileage);
    }
}
