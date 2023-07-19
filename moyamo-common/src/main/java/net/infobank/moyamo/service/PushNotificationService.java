package net.infobank.moyamo.service;

import net.infobank.moyamo.dto.NotificationDto;
import net.infobank.moyamo.models.UserPushToken;

import java.util.List;

public interface PushNotificationService {
    boolean subscribeTopic(String topic, List<UserPushToken> userPushTokens);
    boolean unsubscribeTopic(String topic, List<UserPushToken> userPushTokens);
    void send(NotificationDto message, List<UserService.NotiRecipientInfo> pushInfos);
}
