package net.infobank.moyamo.domain.badge;

import net.infobank.moyamo.domain.Event;
import net.infobank.moyamo.domain.EventAction;
import net.infobank.moyamo.domain.EventType;
import net.infobank.moyamo.domain.PostingType;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Map;
import java.util.Optional;

public interface UserActivity {

    int getPostingCount();
    int getCommentCount();
    int getFirstCommentCount();
    int getLikeCount();
    int getSmileCommentCount();
    int getThanksCommentCount();
    int getAdoptedCommentCount();
    int getRankerCount();

    void setPostingCount(int count);
    void setCommentCount(int count);
    void setFirstCommentCount(int count);
    void setLikeCount(int count);
    void setSmileCommentCount(int count);
    void setThanksCommentCount(int count);
    void setAdoptedCommentCount(int count);
    void setRankerCount(int count);

    //누적관련
    Map<String, Integer> getCumulativeValues();

    @SuppressWarnings("java:S3776")
    default void create(Event event, int num) {
        if (event.getType().equals(EventType.POSTING)) {
            this.setPostingCount(this.getPostingCount() + num);

            this.getCumulativeValues().merge("postingCount", Optional.ofNullable(event.getCumulative()).orElse(1), (v1, v2) -> Optional.ofNullable(v1).orElse(0) + Optional.ofNullable(v2).orElse(0));
        } else if (event.getType().equals(EventType.COMMENT) || event.getType().equals(EventType.FIRST_COMMENT)) {
            if (event.getContent() != null && event.getContent().contains("^^")) {
                this.setSmileCommentCount(this.getSmileCommentCount() + num);
            }
            if (event.getContent() != null && event.getContent().contains("감사")) {
                this.setThanksCommentCount(this.getThanksCommentCount() + num);
            }

            if(event.getType().equals(EventType.FIRST_COMMENT)) {
                if(event.getPostingType().equals(PostingType.question)) {
                    if(event.getContent() != null && event.getContent().contains("#") && event.getContent().length() > 1) {
                        this.setFirstCommentCount(this.getFirstCommentCount() + num);
                    }
                } else {
                    this.setFirstCommentCount(this.getFirstCommentCount() + num);
                }

            } else {
                this.setCommentCount(this.getCommentCount() + num);
                this.getCumulativeValues().merge("commentCount", Optional.ofNullable(event.getCumulative()).orElse(1), (v1, v2) -> Optional.ofNullable(v1).orElse(0) + Optional.ofNullable(v2).orElse(0));
            }

        } else if (event.getType().equals(EventType.LIKE)) {
            this.setLikeCount(this.getLikeCount() + num);
        } else if (event.getType().equals(EventType.ADOPTED)) {
            this.setAdoptedCommentCount(this.getAdoptedCommentCount() + num);
        } else if(event.getType().equals(EventType.RANKING)) {
            this.setRankerCount(this.getRankerCount() + num);
        }
    }

    @SuppressWarnings("java:S3776")
    default void add(Event event) {

        if(event == null || event.getPostingType() == null)
            return;

        // 1시간이 지난 이벤트는 과거 데이터로 본다.
        int num = (event.getTimestamp() == null || ZonedDateTime.ofInstant(Instant.ofEpochMilli(event.getTimestamp()), ZoneId.of("UTC")).isAfter(ZonedDateTime.now().minusHours(1L))) ? 1 : 0;
        if (event.getAction() == EventAction.CREATE) {
            create(event, num);
        }
        //TODO EventAction 에 따른 분기 추가.
    }
}
