package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.RecommendKeywordAdminDto;
import net.infobank.moyamo.dto.RecommendKeywordDto;
import net.infobank.moyamo.models.RecommendKeywordAdmin;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.factory.Mappers;

import java.util.List;
import java.util.stream.Collectors;

@Mapper
public interface RecommendKeywordAdminMapper {

    RecommendKeywordAdminMapper INSTANCE = Mappers.getMapper(RecommendKeywordAdminMapper.class);

    @Mapping(target = "keywords", source = "recommendKeywordAdmin", qualifiedByName = "recommendKeywords")
    RecommendKeywordAdminDto of(RecommendKeywordAdmin recommendKeywordAdmin);

    @Named("recommendKeywords")
    default List<RecommendKeywordDto> recommendKeywords(RecommendKeywordAdmin recommendKeywordAdmin){
        return recommendKeywordAdmin.getKeywords().stream().map(RecommendKeywordMapper.INSTANCE::of).collect(Collectors.toList());
    }
}
