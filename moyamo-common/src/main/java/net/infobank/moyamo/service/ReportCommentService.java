package net.infobank.moyamo.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.enumeration.ReportStatus;
import net.infobank.moyamo.exception.MoyamoGlobalException;
import net.infobank.moyamo.form.CreateReportVo;
import net.infobank.moyamo.models.Comment;
import net.infobank.moyamo.models.ReportComment;
import net.infobank.moyamo.models.UserCommentRelation;
import net.infobank.moyamo.repository.CommentRepository;
import net.infobank.moyamo.repository.ReportCommentRepository;
import net.infobank.moyamo.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@AllArgsConstructor
public class ReportCommentService {

    private final UserRepository userRepository;
    private final CommentRepository commentRepository;
    private final ReportCommentRepository reportCommentRepository;

    @Transactional(isolation = Isolation.SERIALIZABLE)
    public boolean addReport(long id, long userId, CreateReportVo vo) {
        Comment comment = commentRepository.findLockOnly(id).orElseThrow(() -> new MoyamoGlobalException("not found Entity"));
        UserCommentRelation pk = new UserCommentRelation(userRepository.getOne(userId), comment);

        //optional 로 처리시 query 가 2 번 나감 (select 할 때, .get() 할 때)
        ReportComment userLike = reportCommentRepository.findByIdEquals(pk);
        if (userLike == null) {
            commentRepository.updateLikeCount(id, 1);
            reportCommentRepository.save((ReportComment)new ReportComment(pk).setTitle(vo.getTitle()).setText(vo.getText()).setReportStatus(ReportStatus.WAIT));
            return true;
        }
        return false;
    }

    @Transactional(isolation = Isolation.SERIALIZABLE)
    public boolean removeReport(long id, long userId) {
        Comment comment = commentRepository.findLockOnly(id).orElseThrow(() -> new MoyamoGlobalException("not found Entity"));
        UserCommentRelation pk = new UserCommentRelation(userRepository.getOne(userId), comment);

        //optional 로 처리시 query 가 2 번 나감 (select 할 때, .get() 할 때)
        ReportComment userLike = reportCommentRepository.findByIdEquals(pk);
        if (userLike != null) {
            commentRepository.updateLikeCount(id, -1);
            reportCommentRepository.delete(userLike);
            return false;
        }
        return true;
    }


}

