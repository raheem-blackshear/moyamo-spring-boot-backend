package net.infobank.moyamo.exception;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class MoyamoIOException extends RuntimeException {
    public MoyamoIOException(String message) {
        super(message);
    }
}
