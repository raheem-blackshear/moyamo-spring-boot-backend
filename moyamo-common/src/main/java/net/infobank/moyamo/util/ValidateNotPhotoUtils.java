package net.infobank.moyamo.util;

import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.exception.MoyamoPermissionException;
import net.infobank.moyamo.models.Posting;

public class ValidateNotPhotoUtils {

    private ValidateNotPhotoUtils() throws IllegalAccessException{
        throw new IllegalAccessException("ValidateNotPhotoUtils is static");
    }

    public static void validateNotPhoto(Posting posting) {
        if(posting.getPostingType().equals(PostingType.photo)) {
            throw new MoyamoPermissionException(MoyamoPermissionException.Messages.NOT_AUTHORIZED);
        }
    }
}
