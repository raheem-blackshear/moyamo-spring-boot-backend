package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.GoodsDto;
import net.infobank.moyamo.dto.shop.GoodsDataDto;
import net.infobank.moyamo.models.shop.Goods;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface GoodsMapper {
    GoodsMapper INSTANCE = Mappers.getMapper( GoodsMapper.class );
    Goods of(GoodsDataDto goodsDataDto);
    GoodsDto of(Goods goods);
}
