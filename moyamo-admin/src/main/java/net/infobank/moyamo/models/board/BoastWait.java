package net.infobank.moyamo.models.board;

import lombok.*;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.models.*;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.search.annotations.Indexed;
import org.mapstruct.Named;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import java.util.List;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Entity
@Indexed(index = ElasticsearchConfig.INDEX_NAME)
@DiscriminatorValue(BoardDiscriminatorValues.BOAST_WAIT)
@DynamicUpdate
@ToString(callSuper = true)
/*
 * 자랑하기
 */
public class BoastWait extends Posting implements INotification {

    @Override
    public PostingType getPostingType() {
        return PostingType.boast_wait;
    }

    @NonNull
    private String title;

    @Override
    @Named("checkQualifiedNamed")
    public Resource asResource() {
        return new Resource(getId(), Resource.ResourceType.boast, getId(), Resource.ResourceType.boast);
    }

    @Override
    public List<PosterAttachment> getPosters() {
        return null; //NOSONAR
    }

    @Override
    public void setPosters(List<PosterAttachment> posters) {
        //
    }
}
