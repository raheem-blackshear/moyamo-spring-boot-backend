package net.infobank.moyamo.api.service;

import net.infobank.moyamo.dto.RankingResponseBodyDto;

import java.time.ZonedDateTime;

public interface RankingCacheService {
    RankingResponseBodyDto findRanking(ZonedDateTime date, boolean rewrite);
}
