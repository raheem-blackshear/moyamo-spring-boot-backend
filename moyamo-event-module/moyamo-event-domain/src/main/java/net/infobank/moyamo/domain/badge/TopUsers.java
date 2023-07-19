package net.infobank.moyamo.domain.badge;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeSet;


@ToString
public class TopUsers implements Iterable<TopUsers.UserScore>, Serializable {

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserScore implements Comparable<UserScore> {

        private long id;
        private int score;

        @Override
        public int compareTo(UserScore o) {
            int result = Integer.compare(o.score, this.score);
            if(result != 0)
                return result;

            return Integer.compare(this.score, o.score);
        }
    }

    private static final int MAX = 200;
    private static final int MIN_SCORE = 5000;

    private final Map<Long, UserScore> currentSongs = new HashMap<>();

    private final TreeSet<UserScore> rankings = new TreeSet<>();

    public void add(final UserScore activity) {

        if(MIN_SCORE > activity.getScore())
            return;

        if(currentSongs.containsKey(activity.getId())) {
            rankings.remove(currentSongs.remove(activity.getId()));
        }

        rankings.add(activity);
        currentSongs.put(activity.getId(), activity);
        if (rankings.size() > MAX) {
            final UserScore last = rankings.last();
            currentSongs.remove(last.getId());
            rankings.remove(last);
        }
    }

    @SuppressWarnings("unused")
    void remove(final UserScore value) {
        rankings.remove(value);
        currentSongs.remove(value.getId());
    }

    @Override
    public Iterator<UserScore> iterator() {
        return rankings.iterator();
    }
}

