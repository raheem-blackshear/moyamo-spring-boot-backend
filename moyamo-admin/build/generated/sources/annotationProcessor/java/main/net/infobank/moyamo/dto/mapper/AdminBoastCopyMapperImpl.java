package net.infobank.moyamo.dto.mapper;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Generated;
import net.infobank.moyamo.dto.AttachmentDto;
import net.infobank.moyamo.dto.BadgeDto;
import net.infobank.moyamo.dto.GoodsDto;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.dto.UserDto;
import net.infobank.moyamo.models.Badge;
import net.infobank.moyamo.models.PosterAttachment;
import net.infobank.moyamo.models.PosterAttachment.PosterAttachmentBuilder;
import net.infobank.moyamo.models.PostingAttachment;
import net.infobank.moyamo.models.PostingAttachment.PostingAttachmentBuilder;
import net.infobank.moyamo.models.User;
import net.infobank.moyamo.models.board.BoastWait;
import net.infobank.moyamo.models.shop.Goods;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2022-08-05T00:02:36+0800",
    comments = "version: 1.3.1.Final, compiler: javac, environment: Java 1.8.0_333 (Oracle Corporation)"
)
public class AdminBoastCopyMapperImpl implements AdminBoastCopyMapper {

    @Override
    public BoastWait of(PostingDto posting) {
        if ( posting == null ) {
            return null;
        }

        BoastWait boastWait = new BoastWait();

        boastWait.setYoutubeId( posting.getYoutubeId() );
        boastWait.setCreatedAt( posting.getCreatedAt() );
        boastWait.setModifiedAt( posting.getModifiedAt() );
        boastWait.setId( posting.getId() );
        boastWait.setText( posting.getText() );
        boastWait.setAttachments( attachmentDtoListToPostingAttachmentList( posting.getAttachments() ) );
        boastWait.setReadCount( posting.getReadCount() );
        boastWait.setCommentCount( posting.getCommentCount() );
        boastWait.setReportCount( posting.getReportCount() );
        boastWait.setLikeCount( posting.getLikeCount() );
        boastWait.setScrapCount( posting.getScrapCount() );
        boastWait.setOwner( userDtoToUser( posting.getOwner() ) );
        boastWait.setDelete( posting.isDelete() );
        boastWait.setBlind( posting.isBlind() );
        boastWait.setAdopt( posting.isAdopt() );
        boastWait.setGoodses( goodsDtoListToGoodsList( posting.getGoodses() ) );
        boastWait.setPosters( attachmentDtoListToPosterAttachmentList( posting.getPosters() ) );
        boastWait.setTitle( posting.getTitle() );

        return boastWait;
    }

    protected PostingAttachment attachmentDtoToPostingAttachment(AttachmentDto attachmentDto) {
        if ( attachmentDto == null ) {
            return null;
        }

        PostingAttachmentBuilder<?, ?> postingAttachment = PostingAttachment.builder();

        postingAttachment.id( attachmentDto.getId() );
        postingAttachment.description( attachmentDto.getDescription() );
        postingAttachment.imageResource( attachmentDto.getImageResource() );
        postingAttachment.dimension( attachmentDto.getDimension() );
        postingAttachment.placeName( attachmentDto.getPlaceName() );

        return postingAttachment.build();
    }

    protected List<PostingAttachment> attachmentDtoListToPostingAttachmentList(List<AttachmentDto> list) {
        if ( list == null ) {
            return null;
        }

        List<PostingAttachment> list1 = new ArrayList<PostingAttachment>( list.size() );
        for ( AttachmentDto attachmentDto : list ) {
            list1.add( attachmentDtoToPostingAttachment( attachmentDto ) );
        }

        return list1;
    }

    protected Badge badgeDtoToBadge(BadgeDto badgeDto) {
        if ( badgeDto == null ) {
            return null;
        }

        Badge badge = new Badge();

        badge.setId( badgeDto.getId() );
        badge.setTitle( badgeDto.getTitle() );
        badge.setDescription1( badgeDto.getDescription1() );
        badge.setDescription2( badgeDto.getDescription2() );
        badge.setActive( badgeDto.getActive() );
        badge.setOrderCount( badgeDto.getOrderCount() );
        badge.setTrueImageResource( badgeDto.getTrueImageResource() );
        badge.setFalseImageResource( badgeDto.getFalseImageResource() );

        return badge;
    }

    protected User userDtoToUser(UserDto userDto) {
        if ( userDto == null ) {
            return null;
        }

        User user = new User();

        user.setCreatedAt( userDto.getCreatedAt() );
        user.setId( userDto.getId() );
        user.setNickname( userDto.getNickname() );
        user.setRole( userDto.getRole() );
        user.setStatus( userDto.getStatus() );
        user.setProvider( userDto.getProvider() );
        user.setImageResource( userDto.getImageResource() );
        user.setActivity( userDto.getActivity() );
        user.setLevel( userDto.getLevel() );
        user.setRepresentBadge( badgeDtoToBadge( userDto.getRepresentBadge() ) );
        user.setBadgeCount( userDto.getBadgeCount() );
        user.setTotalPhotosCnt( userDto.getTotalPhotosCnt() );
        user.setTotalPhotosLikeCnt( userDto.getTotalPhotosLikeCnt() );

        return user;
    }

    protected Goods goodsDtoToGoods(GoodsDto goodsDto) {
        if ( goodsDto == null ) {
            return null;
        }

        Goods goods = new Goods();

        goods.setGoodsNo( goodsDto.getGoodsNo() );
        goods.setGoodsNm( goodsDto.getGoodsNm() );
        goods.setImageResource( goodsDto.getImageResource() );
        goods.setGoodsPrice( goodsDto.getGoodsPrice() );
        goods.setGoodsDiscount( goodsDto.getGoodsDiscount() );
        goods.setGoodsDiscountUnit( goodsDto.getGoodsDiscountUnit() );
        goods.setReviewCnt( goodsDto.getReviewCnt() );

        return goods;
    }

    protected List<Goods> goodsDtoListToGoodsList(List<GoodsDto> list) {
        if ( list == null ) {
            return null;
        }

        List<Goods> list1 = new ArrayList<Goods>( list.size() );
        for ( GoodsDto goodsDto : list ) {
            list1.add( goodsDtoToGoods( goodsDto ) );
        }

        return list1;
    }

    protected PosterAttachment attachmentDtoToPosterAttachment(AttachmentDto attachmentDto) {
        if ( attachmentDto == null ) {
            return null;
        }

        PosterAttachmentBuilder<?, ?> posterAttachment = PosterAttachment.builder();

        posterAttachment.id( attachmentDto.getId() );
        posterAttachment.description( attachmentDto.getDescription() );
        posterAttachment.imageResource( attachmentDto.getImageResource() );
        posterAttachment.dimension( attachmentDto.getDimension() );

        return posterAttachment.build();
    }

    protected List<PosterAttachment> attachmentDtoListToPosterAttachmentList(List<AttachmentDto> list) {
        if ( list == null ) {
            return null;
        }

        List<PosterAttachment> list1 = new ArrayList<PosterAttachment>( list.size() );
        for ( AttachmentDto attachmentDto : list ) {
            list1.add( attachmentDtoToPosterAttachment( attachmentDto ) );
        }

        return list1;
    }
}
