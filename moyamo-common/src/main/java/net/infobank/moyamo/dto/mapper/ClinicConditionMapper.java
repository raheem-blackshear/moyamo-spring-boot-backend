package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.ClinicConditionDto;
import net.infobank.moyamo.models.board.ClinicCondition;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface ClinicConditionMapper {
    ClinicConditionMapper INSTANCE = Mappers.getMapper( ClinicConditionMapper.class );

    ClinicConditionDto of(ClinicCondition clinicCondition);
}
