package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.GoodsRankingDto;
import net.infobank.moyamo.models.GoodsRanking;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface GoodsRankingMapper {

    GoodsRankingMapper INSTANCE = Mappers.getMapper(GoodsRankingMapper.class);

    GoodsRankingDto of(GoodsRanking goodsRanking);
}
