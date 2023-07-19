package net.infobank.moyamo.util;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.repository.UserRepository;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class AuthUtils {

    private final UserRepository userRepository;

    public AuthUtils(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User getCurrentUser() {
        User loginUser = null;
        String userId;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(principal instanceof DefaultOAuth2User) {
            DefaultOAuth2User oauthUser = (DefaultOAuth2User) principal;
            userId = oauthUser.getName();
            if(log.isDebugEnabled()) {
                log.debug("DefaultOAuth2User principal : {}", userId);
            }
            loginUser = (User)oauthUser.getAttributes().get("moyamo_user");
        } else if(principal instanceof  org.springframework.security.core.userdetails.User) {
            org.springframework.security.core.userdetails.User user = ( org.springframework.security.core.userdetails.User) principal;
            userId = user.getUsername();
            if(log.isDebugEnabled()) {
                log.debug("User principal : {}", userId);
            }
            String provider = (userId.indexOf("@", 1) > -1) ? "email" : "phone";
            final String providerId = userId;
            loginUser = userRepository.findByProviderIdAndProvider(userId, provider).orElseThrow(() -> new UsernameNotFoundException("providerId " + providerId + " not found"));
        }
        return loginUser;
    }
}
