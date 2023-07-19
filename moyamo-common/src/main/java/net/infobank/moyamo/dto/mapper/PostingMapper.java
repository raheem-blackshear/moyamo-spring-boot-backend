package net.infobank.moyamo.dto.mapper;

import net.infobank.moyamo.dto.ClinicConditionDto;
import net.infobank.moyamo.dto.PhotoAlbumDto;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.dto.UserDto;
import net.infobank.moyamo.models.PhotoAlbum;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.board.ClinicCondition;
import net.infobank.moyamo.models.board.Photo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface PostingMapper {
    PostingMapper INSTANCE = Mappers.getMapper( PostingMapper.class );

    @Named("conditionOf")
    static ClinicConditionDto textOf(ClinicCondition clinicCondition) {
        return ClinicConditionDto.of(clinicCondition);
    }

    @Mapping(target = "condition", qualifiedByName = "conditionOf")
    @Mapping(target = "resource", qualifiedByName = "checkQualifiedNamed")
    PostingDto of(Posting posting);
    UserDto of(User user);


//    @Mapping(target = "photoAlbum", source = "posting", qualifiedByName = "setPhotoAlbum")
//    PostingDto ofPhoto(Posting posting);
//
//    @Named("setPhotoAlbum")
//    default PhotoAlbumDto setPhotoAlbum(Posting posting){
//        return PhotoAlbumDto.of(((Photo)posting).getPhotoAlbum());
//    }
}
