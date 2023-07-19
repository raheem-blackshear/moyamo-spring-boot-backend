package net.infobank.moyamo.repository.statistics;

import net.infobank.moyamo.models.board.Question;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<Question, Long> {

}
