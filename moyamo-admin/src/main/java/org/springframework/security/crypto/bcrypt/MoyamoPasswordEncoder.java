package org.springframework.security.crypto.bcrypt;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;

@AllArgsConstructor
@Slf4j
public class MoyamoPasswordEncoder implements PasswordEncoder  {

    private static final String DELIMITER = "\\[DELIMITER\\]";
    private PasswordEncoder passwordEncoder;

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        String[] strArray = encodedPassword.split(DELIMITER);

        String rawEncoded;
        boolean matched;
        if(strArray.length != 2) {
            rawEncoded = passwordEncoder.encode(rawPassword);
            matched = passwordEncoder.matches(rawPassword, encodedPassword);
        } else {
            String salt = strArray[0];
            String password = strArray[1];
            rawEncoded = net.infobank.moyamo.common.configurations.MoyamoPasswordEncoder.hashedPassword(rawPassword.toString(), salt);
            matched = password.equals(rawEncoded);
        }
        log.info("passwordEncoder {}, matches match : {}, raw : {}({}), {}", strArray.length, matched, rawPassword, rawEncoded, encodedPassword);
        return matched;
    }

    @Override
    public boolean upgradeEncoding(String encodedPassword) {
        return passwordEncoder.upgradeEncoding(encodedPassword);
    }

    @Override
    public String encode(CharSequence charSequence) {
        return passwordEncoder.encode(charSequence);
    }
}
