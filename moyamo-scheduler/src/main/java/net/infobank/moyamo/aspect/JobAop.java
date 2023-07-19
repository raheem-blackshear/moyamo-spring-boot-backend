package net.infobank.moyamo.aspect;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Slf4j
@Aspect
@Component
public class JobAop {

    @Pointcut("@annotation(org.springframework.scheduling.annotation.Scheduled)")
    public void isScheduled() {}

    @AfterThrowing(pointcut="execution(* net.infobank.moyamo.jobs.statistics.RankingJobs.RankingJob.worker(..))", throwing="ex")
    public void afterThrowing(JoinPoint point, Throwable ex)  {
        // Do what you want
        log.error("RankingJobs Error", ex);
    }
}
