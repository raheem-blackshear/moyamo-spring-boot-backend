package net.infobank.moyamo.domain.badge;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.HashMap;
import java.util.Map;

@ToString
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AbstractUserActivity implements UserActivity {

    //사용자ID
    private long owner;

    //댓글수
    @ToString.Include
    private int commentCount;

    //첫댓글
    @ToString.Include
    private int firstCommentCount;

    //좋아요수
    @ToString.Include
    private int likeCount;

    //'^^'포함 댓글수
    @ToString.Include
    private int smileCommentCount;

    //'감사'포함 댓글수
    @ToString.Include
    private int thanksCommentCount;

    //게시글수
    @ToString.Include
    private int postingCount;

    //채택 댓글수
    @ToString.Include
    private int adoptedCommentCount;

    //랭킹노출 1회
    @ToString.Include
    private int rankerCount;

    //누적값 key, value
    @ToString.Include
    private Map<String, Integer> cumulativeValues;

    public Map<String, Integer> getCumulativeValues() {
        if(cumulativeValues == null)
            this.cumulativeValues = new HashMap<>();
        return cumulativeValues;
    }

}
