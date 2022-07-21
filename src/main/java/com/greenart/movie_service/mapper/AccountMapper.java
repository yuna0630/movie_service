package com.greenart.movie_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greenart.movie_service.data.AccountInfoVO;
import com.greenart.movie_service.data.CommentDetailInfoVO;

@Mapper
public interface AccountMapper {
    public Boolean isDuplicatedId(String id);
    public void insertAccountInfo(AccountInfoVO data);
    public AccountInfoVO login(AccountInfoVO data);

    public List<CommentDetailInfoVO> selectCommentsByAccountSeq(Integer seq, Integer offset);
    public Integer selectCommentsPageCountByAccountSeq(Integer seq);
    public Integer selectCommentsCountByAccountSeq(Integer seq);

}