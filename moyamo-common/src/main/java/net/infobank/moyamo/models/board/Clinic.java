package net.infobank.moyamo.models.board;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.models.*;
import net.infobank.moyamo.models.converter.ClinicDetailConverter;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.search.annotations.Indexed;
import org.mapstruct.Named;

import javax.persistence.*;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
@Entity
@Indexed(index = ElasticsearchConfig.INDEX_NAME)
@DiscriminatorValue(BoardDiscriminatorValues.CLINIC)
@DynamicUpdate
@ToString(callSuper = true)
/*
 * 자랑하기
 */
public class Clinic extends Posting implements INotification, WithCondition {

    @Override
    public PostingType getPostingType() {
        return PostingType.clinic;
    }

    @Override
    @Named("checkQualifiedNamed")
    public Resource asResource() {
        return new Resource(getId(), Resource.ResourceType.clinic, getId(), Resource.ResourceType.clinic);
    }

    private String title;

    @Override
    public List<PosterAttachment> getPosters() {
        return null; //NOSONAR
    }

    @Override
    public void setPosters(List<PosterAttachment> posters) {
        //
    }

    @Override
    public ClinicCondition getCondition() {
        return condition;
    }

    @Column(name = "environment_condition", columnDefinition = "varchar(120) comment '환경'")
    @Convert(converter = ClinicDetailConverter.class)
    private ClinicCondition condition;

}
