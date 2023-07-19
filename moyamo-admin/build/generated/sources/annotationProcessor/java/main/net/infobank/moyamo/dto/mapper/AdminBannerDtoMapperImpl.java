package net.infobank.moyamo.dto.mapper;

import javax.annotation.Generated;
import net.infobank.moyamo.dto.AdminBannerDto;
import net.infobank.moyamo.dto.ResourceDto;
import net.infobank.moyamo.models.Banner;
import net.infobank.moyamo.models.Resource;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2022-08-05T00:02:36+0800",
    comments = "version: 1.3.1.Final, compiler: javac, environment: Java 1.8.0_333 (Oracle Corporation)"
)
public class AdminBannerDtoMapperImpl implements AdminBannerDtoMapper {

    @Override
    public AdminBannerDto of(Banner banner) {
        if ( banner == null ) {
            return null;
        }

        AdminBannerDto adminBannerDto = new AdminBannerDto();

        adminBannerDto.setId( banner.getId() );
        adminBannerDto.setTitle( banner.getTitle() );
        adminBannerDto.setImageResource( banner.getImageResource() );
        adminBannerDto.setResource( resourceToResourceDto( banner.getResource() ) );
        adminBannerDto.setStart( banner.getStart() );
        adminBannerDto.setEnd( banner.getEnd() );
        adminBannerDto.setSeq( banner.getSeq() );
        adminBannerDto.setStatus( banner.getStatus() );

        return adminBannerDto;
    }

    protected ResourceDto resourceToResourceDto(Resource resource) {
        if ( resource == null ) {
            return null;
        }

        ResourceDto resourceDto = new ResourceDto();

        resourceDto.setResourceId( resource.getResourceId() );
        resourceDto.setResourceType( resource.getResourceType() );
        resourceDto.setReferenceId( resource.getReferenceId() );
        resourceDto.setReferenceType( resource.getReferenceType() );

        return resourceDto;
    }
}
