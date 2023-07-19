package net.infobank.moyamo.api.exceptions;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class AuthorizationException extends Exception {
    public AuthorizationException(String message) {
        super(message);
    }
}
