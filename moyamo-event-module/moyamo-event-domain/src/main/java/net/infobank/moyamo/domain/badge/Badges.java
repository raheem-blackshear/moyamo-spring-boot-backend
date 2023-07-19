package net.infobank.moyamo.domain.badge;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@SuppressWarnings({"unused", "java:S101"})
public class Badges {

    private Badges() throws IllegalAccessException {
        throw new IllegalAccessException("Badges is static");
    }

    public static class Total {

        private Total() throws IllegalAccessException {
            throw new IllegalAccessException("Total is static");
        }

        private static final List<Badge> badges = Arrays.asList(
                new SmileBadge(),
                new ThanksBadge(),
                new LikeBadge()
        );

        public static List<Badge> getBadges() {
            return badges;
        }

    }


    public static class Question {

        private Question() throws IllegalAccessException {
            throw new IllegalAccessException("Question is static");
        }

        private static final List<Badge> badges = Arrays.asList(
                /*
                //댓글 갯수 뱃지는 제거
                new BadgeQ1_1(),
                new BadgeQ1_2(),
                new BadgeQ1_3(),
                */
                new BadgeQ2_1(),
                new BadgeQ2_2(),
                new BadgeQ2_3(),
                new FirstBadge(),
                new BadgeQR1(),
                new BadgeQR2(),
                new BadgeQR3()
        );

        public static List<Badge> getBadges() {
            return badges;
        }

    }

    public static class Magazine {

        private Magazine() throws IllegalAccessException {
            throw new IllegalAccessException("Magazine is static");
        }

        private static final List<Badge> badges = Arrays.asList(
                new BadgeM1(),
                new BadgeM2(),
                new BadgeM3()
        );

        public static List<Badge> getBadges() {
            return badges;
        }

    }

    public static class Clinic {

        private Clinic() throws IllegalAccessException {
            throw new IllegalAccessException("Clinic is static");
        }

        private static final List<Badge> badges = Arrays.asList(
                new BadgeC1(),
                new BadgeC2(),
                new BadgeC3(),
                new FirstBadge(),
                new BadgeCR1(),
                new BadgeCR2(),
                new BadgeCR3()
        );

        public static List<Badge> getBadges() {
            return badges;
        }

    }

    public static class Free {

        private Free() throws IllegalAccessException {
            throw new IllegalAccessException("Free is static");
        }

        private static final List<Badge> badges = Collections.singletonList(
                new BadgeF1()
        );

        public static List<Badge> getBadges() {
            return badges;
        }

    }

    public static class BoastWithClinic {

        private BoastWithClinic() throws IllegalAccessException {
            throw new IllegalAccessException("BoastWithClinic is static");
        }

        private static final List<Badge> badges = Arrays.asList(
                new BadgeFBR1(),
                new BadgeFBR2(),
                new BadgeFBR3()
        );

        public static List<Badge> getBadges() {
            return badges;
        }
    }

    public static class BadgeQ1_1 extends AbstractBadge {

        @Override
        public String getName() {
            return "만사마";
        }

        @Override
        public String getKey() {
            return "4";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null && activity.getCommentCount() >= 10000;
        }
    }

    public static class BadgeQ1_2 extends AbstractBadge {

        @Override
        public String getName() {
            return "십만사마";
        }

        @Override
        public String getKey() {
            return "5";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null && activity.getCommentCount() >= 100000;
        }
    }

    public static class BadgeQ1_3 extends AbstractBadge {

        @Override
        public String getName() {
            return "백만사마";
        }

        @Override
        public String getKey() {
            return "6";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getCommentCount() >= 1000000;
        }
    }

    public static class BadgeQ2_1 extends AbstractBadge {

        @Override
        public String getName() {
            return "빠른 속도";
        }

        @Override
        public String getKey() {
            return "1";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null &&  activity.getFirstCommentCount() >= 10;
        }
    }

    public static class BadgeQ2_2 extends AbstractBadge {

        @Override
        public String getName() {
            return "발빠른 속도";
        }

        @Override
        public String getKey() {
            return "2";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null &&  activity.getFirstCommentCount() >= 100;
        }
    }

    public static class BadgeQ2_3 extends AbstractBadge {

        @Override
        public String getName() {
            return "빛의 속도";
        }

        @Override
        public String getKey() {
            return "3";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null && activity.getFirstCommentCount() >= 1000;
        }
    }

    public static class ThanksBadge extends AbstractBadge {

        @Override
        public String getName() {
            return "매너왕";
        }

        @Override
        public String getKey() {
            return "27";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getThanksCommentCount() >= 100;
        }
    }

    public static class SmileBadge extends AbstractBadge {

        @Override
        public String getName() {
            return "미소천사";
        }

        @Override
        public String getKey() {
            return "28";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null && activity.getSmileCommentCount() >= 100;
        }
    }

    public static class FirstBadge extends AbstractBadge {

        @Override
        public String getName() {
            return "첫 질문의 설렘";
        }

        @Override
        public String getKey() {
            return "10";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null && activity.getPostingCount() >= 1;
        }
    }

    public static class BadgeM1 extends AbstractBadge {

        @Override
        public String getName() {
            return "배우는 즐거움";
        }

        @Override
        public String getKey() {
            return "11";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null && activity.getCommentCount() >= 10;
        }
    }

    public static class BadgeM2 extends AbstractBadge {

        @Override
        public String getName() {
            return "학습의 기쁨";
        }

        @Override
        public String getKey() {
            return "12";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getCommentCount() >= 30;
        }
    }

    public static class BadgeM3 extends AbstractBadge {

        @Override
        public String getName() {
            return "공부의 신";
        }

        @Override
        public String getKey() {
            return "13";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null && activity.getCommentCount() >= 50;
        }
    }

    public static class BadgeF1 extends AbstractBadge {

        @Override
        public String getName() {
            return "소통왕";
        }

        @Override
        public String getKey() {
            return "15";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null && activity.getCommentCount() >= 100;
        }
    }

    public static class LikeBadge extends AbstractBadge {

        @Override
        public String getName() {
            return "하트요정";
        }

        @Override
        public String getKey() {
            return "25";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getLikeCount() >= 100;
        }
    }


    public static class BadgeC1 extends AbstractBadge {

        @Override
        public String getName() {
            return "식물 의원";
        }

        @Override
        public String getKey() {
            return "7";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getAdoptedCommentCount() >= 10;
        }
    }

    public static class BadgeC2 extends AbstractBadge {

        @Override
        public String getName() {
            return "식물 명의";
        }

        @Override
        public String getKey() {
            return "8";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getAdoptedCommentCount() >= 100;
        }
    }

    public static class BadgeC3 extends AbstractBadge {

        @Override
        public String getName() {
            return "식물 어의";
        }

        @Override
        public String getKey() {
            return "9";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getAdoptedCommentCount() >= 500;
        }
    }

    /**
     * 이름이뭐야 랭킹 노출
     */
    public static class BadgeQR1 extends AbstractBadge {

        @Override
        public String getName() {
            return "이름 학사";
        }

        @Override
        public String getKey() {
            return "16";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 1;
        }
    }

    /**
     * 이름이뭐야 랭킹 노출
     */
    public static class BadgeQR2 extends AbstractBadge {

        @Override
        public String getName() {
            return "이름 석사";
        }

        @Override
        public String getKey() {
            return "17";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 30;
        }
    }

    /**
     * 이름이뭐야 랭킹 노출
     */
    public static class BadgeQR3 extends AbstractBadge {

        @Override
        public String getName() {
            return "이름 박사";
        }

        @Override
        public String getKey() {
            return "18";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 100;
        }
    }


    /**
     * 클리닉 랭킹 노출
     */
    public static class BadgeCR1 extends AbstractBadge {

        @Override
        public String getName() {
            return "클리닉 학사";
        }

        @Override
        public String getKey() {
            return "19";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 1;
        }
    }

    /**
     * 클리닉 랭킹 노출
     */
    public static class BadgeCR2 extends AbstractBadge {

        @Override
        public String getName() {
            return "클리닉 석사";
        }

        @Override
        public String getKey() {
            return "20";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 30;
        }
    }

    /**
     * 클리닉 랭킹 노출
     */
    public static class BadgeCR3 extends AbstractBadge {

        @Override
        public String getName() {
            return "클리닉 박사";
        }

        @Override
        public String getKey() {
            return "21";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 100;
        }
    }


    public static class BadgeFBR1 extends AbstractBadge {

        @Override
        public String getName() {
            return "작가지망생";
        }

        @Override
        public String getKey() {
            return "22";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 1;
        }
    }

    public static class BadgeFBR2 extends AbstractBadge {

        @Override
        public String getName() {
            return "등단작가";
        }

        @Override
        public String getKey() {
            return "23";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 30;
        }
    }

    public static class BadgeFBR3 extends AbstractBadge {

        @Override
        public String getName() {
            return "프로작가";
        }

        @Override
        public String getKey() {
            return "24";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return activity != null  && activity.getRankerCount() >= 100;
        }
    }

    public static class BadgeHeavy extends AbstractBadge {

        @Override
        public String getName() {
            return "터줏대감";
        }

        @Override
        public String getKey() {
            return "26";
        }

        @Override
        public boolean issue(UserActivity activity) {
            return false;
        }
    }

}
