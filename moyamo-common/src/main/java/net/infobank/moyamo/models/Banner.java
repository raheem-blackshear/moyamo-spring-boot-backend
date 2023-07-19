package net.infobank.moyamo.models;

import lombok.*;
import net.infobank.moyamo.enumeration.BannerStatus;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.time.ZonedDateTime;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@DynamicUpdate
@EqualsAndHashCode(callSuper = false)
public class Banner extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @JoinColumn(foreignKey = @ForeignKey(value = ConstraintMode.NO_CONSTRAINT))
    @ManyToOne(fetch = FetchType.LAZY)
    private BannerManager manager;

    @Embedded
    private ImageResource imageResource;

    @Embedded
    private Resource resource;

    //노출시작시간
    private ZonedDateTime start;

    //노출종료시간
    private ZonedDateTime end;

    private int seq;

    @Column(columnDefinition = "tinyint")
    private BannerStatus status;
}
