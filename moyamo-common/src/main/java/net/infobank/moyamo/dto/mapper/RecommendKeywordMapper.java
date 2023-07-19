package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.RecommendKeywordDto;
import net.infobank.moyamo.models.RecommendKeyword;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface RecommendKeywordMapper {
    RecommendKeywordMapper INSTANCE = Mappers.getMapper(RecommendKeywordMapper.class);
    RecommendKeywordDto of(RecommendKeyword recommendKeyword);
}
