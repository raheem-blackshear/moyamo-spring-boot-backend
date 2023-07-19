package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.ShippingDto;
import net.infobank.moyamo.dto.GambleResultDto;
import net.infobank.moyamo.models.GambleResult;
import net.infobank.moyamo.models.UserEventInfo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface GambleResultMapper {
    GambleResultMapper INSTANCE = Mappers.getMapper( GambleResultMapper.class );


    @Named("addressOf")
    static ShippingDto addressOf(UserEventInfo userEventInfo) {
        return ShippingDto.of(userEventInfo);
    }

    @Mapping(target = "address", source = "user.eventInfo", qualifiedByName = "addressOf")
    GambleResultDto of(GambleResult gambleResult);
}
