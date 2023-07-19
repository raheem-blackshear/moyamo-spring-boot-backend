package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.common.configurations.FeedScoreProperties;
import net.infobank.moyamo.enumeration.PostingStatus;
import net.infobank.moyamo.enumeration.PostingType;


@Slf4j
//@Service
@AllArgsConstructor
public class FeedService {

    private final FeedScoreProperties properties;

    @SuppressWarnings({"unused", "java:S3776"})
    public PostingStatus getPostStatus(PostingType postingType, int receiving, int readCount, int commentCount) {
        if (postingType == null) {
            return PostingStatus.outdate;
        } else if (PostingType.question.equals(postingType)) {
            if (readCount >= properties.getStatus().getMax().getRead() && commentCount <= properties.getStatus().getMin().getComment()) {
                return PostingStatus.hardtoo;
            }

            //receiving update 가 disable 되었을 경우
            if (receiving >= properties.getStatus().getMin().getReceiving()) {

                if (commentCount >= properties.getStatus().getMax().getComment()) {
                    return PostingStatus.answered;
                } else {
                    if (receiving >= properties.getStatus().getMax().getReceiving()) {
                        return PostingStatus.outdate;
                    } else if (receiving >= properties.getStatus().getMid().getReceiving() && readCount < properties.getStatus().getMin().getRead()) {
                        return PostingStatus.unviewed;
                    }
                    return PostingStatus.unanswered;
                }

            } else {
                return PostingStatus.created;
            }
        } else {
            if (receiving >= properties.getStatus().getRanked().getReceiving()) {
                return PostingStatus.ranked;
            } else {
                return PostingStatus.created;
            }
        }
    }
}
