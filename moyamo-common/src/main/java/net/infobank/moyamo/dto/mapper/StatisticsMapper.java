package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.StatisticsDto;
import net.infobank.moyamo.models.Statistics;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface StatisticsMapper {

    StatisticsMapper INSTANCE = Mappers.getMapper( StatisticsMapper.class );
    StatisticsDto of(Statistics statistics);
}
