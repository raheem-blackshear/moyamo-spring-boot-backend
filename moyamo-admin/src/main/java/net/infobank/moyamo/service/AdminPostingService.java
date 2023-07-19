package net.infobank.moyamo.service;

import lombok.extern.slf4j.Slf4j;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.dto.mapper.AdminBoastCopyMapper;
import net.infobank.moyamo.dto.mapper.AdminFreeCopyMapper;
import net.infobank.moyamo.dto.mapper.AdminMagazineCopyMapper;
import net.infobank.moyamo.dto.mapper.AdminTelevisionCopyMapper;
import net.infobank.moyamo.enumeration.PostingType;
import net.infobank.moyamo.exception.MoyamoGlobalException;
import net.infobank.moyamo.models.PosterAttachment;
import net.infobank.moyamo.models.Posting;
import net.infobank.moyamo.models.PostingAttachment;
import net.infobank.moyamo.models.shop.Goods;
import net.infobank.moyamo.repository.GoodsRepository;
import net.infobank.moyamo.repository.PostingRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
public class AdminPostingService {

    final GoodsRepository goodsRepository;

    final PostingRepository postingRepository;

    public AdminPostingService(GoodsRepository goodsRepository, PostingRepository postingRepository) {
        this.goodsRepository = goodsRepository;
        this.postingRepository = postingRepository;
    }

    @SuppressWarnings("UnusedReturnValue")
    @Transactional
    public PostingDto addGoods(long id, String goodsNo) {
        Goods goods = goodsRepository.findById(goodsNo).orElseThrow(() -> new MoyamoGlobalException("상품정보를 찾을 수 없습니다."));
        Posting posting = postingRepository.findById(id).orElseThrow(() -> new MoyamoGlobalException(MoyamoGlobalException.Messages.NOT_FOUND_POSTING));
        posting.getGoodses().clear();
        posting.getGoodses().add(goods);
        return PostingDto.of(posting);
    }

    @SuppressWarnings("UnusedReturnValue")
    @Transactional
    public PostingDto removeGoods(long id) {
        Posting posting = postingRepository.findById(id).orElseThrow(() -> new MoyamoGlobalException(MoyamoGlobalException.Messages.NOT_FOUND_POSTING));
        posting.getGoodses().clear();
        return PostingDto.of(posting);
    }


    @Transactional
    public PostingDto copy(long id) {
        return PostingDto.of(copyOrigin(id));
    }

    @Transactional
    public Posting copyOrigin(long id) {
        Posting posting = postingRepository.findById(id).orElseThrow(() -> new MoyamoGlobalException(MoyamoGlobalException.Messages.NOT_FOUND_POSTING));

        Posting newPosting = null;

        if(PostingType.magazine.equals(posting.getPostingType()) || PostingType.magazine_wait.equals(posting.getPostingType())) {
            newPosting = AdminMagazineCopyMapper.INSTANCE.of(PostingDto.of(posting));
        } else if(PostingType.television.equals(posting.getPostingType()) || PostingType.television_wait.equals(posting.getPostingType())) {
            newPosting = AdminTelevisionCopyMapper.INSTANCE.of(PostingDto.of(posting));
        } else if(PostingType.boast.equals(posting.getPostingType()) || PostingType.boast_wait.equals(posting.getPostingType())) {
            newPosting = AdminBoastCopyMapper.INSTANCE.of(PostingDto.of(posting));
        }  else if(PostingType.free.equals(posting.getPostingType()) || PostingType.free_wait.equals(posting.getPostingType())) {
            newPosting = AdminFreeCopyMapper.INSTANCE.of(PostingDto.of(posting));
        }

        if(newPosting != null) {
            initPosting(newPosting);
            newPosting = postingRepository.save(newPosting);
        }

        return newPosting;
    }

    private void initPosting(Posting posting) {
        posting.setReadCount(0);
        posting.setCommentCount(0);
        if(posting.getComments() != null)
            posting.getComments().clear();
        posting.setLikeCount(0);
        posting.setScrapCount(0);
        posting.setId(null);
        if(posting.getAttachments() != null) {
            for(PostingAttachment attachment : posting.getAttachments()) {
                attachment.setId(null);
                attachment.setParent(posting);
            }
        }

        if(posting.getPosters() != null) {
            for(PosterAttachment attachment : posting.getPosters()) {
                attachment.setId(null);
                attachment.setParent(posting);
            }
        }
    }


}
