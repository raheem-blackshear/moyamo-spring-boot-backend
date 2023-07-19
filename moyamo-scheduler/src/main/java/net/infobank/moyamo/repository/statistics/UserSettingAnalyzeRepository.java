package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.UserSetting;
import org.springframework.data.jpa.repository.Query;

import java.time.ZonedDateTime;

public interface UserSettingAnalyzeRepository extends IAnalyzeRepository<UserSetting>{


    /**
     * @param from gte
     * @param to lt
     * @return
     */
    @Query("select count(us) from UserSetting us where us.createdAt >= :from and us.createdAt < :to and us.adNotiEnable = false")
    Long countByNotiEnableFalse(ZonedDateTime from, ZonedDateTime to);

}
