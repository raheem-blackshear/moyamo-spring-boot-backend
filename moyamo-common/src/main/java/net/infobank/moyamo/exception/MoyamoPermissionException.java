package net.infobank.moyamo.exception;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class MoyamoPermissionException extends MoyamoGlobalException {

    public static final class Messages {

        private Messages() throws IllegalAccessException {
            throw new IllegalAccessException("Messages is static");
        }


        public static final String NOT_AUTHORIZED = "권한이 없습니다.";
    }

    public MoyamoPermissionException(String message) {
        super(message);
    }
}
