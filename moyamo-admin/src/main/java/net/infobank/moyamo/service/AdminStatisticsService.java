package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.StatisticsDto;
import net.infobank.moyamo.repository.StatisticsRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@AllArgsConstructor
public class AdminStatisticsService {

    private final StatisticsRepository statisticsRepository;

    public List<StatisticsDto> findStatisticsList(LocalDate from, LocalDate to) {

        ZonedDateTime toDateTime = ZonedDateTime.of(to, LocalTime.MIN, ZoneId.of("Asia/Seoul"));
        ZonedDateTime fromDateTime = ZonedDateTime.of(from, LocalTime.MIN, ZoneId.of("Asia/Seoul"));

        return statisticsRepository.findByRange(fromDateTime, toDateTime).stream().map(StatisticsDto::of).collect(Collectors.toList());
    }

}
