package com.greenart.movie_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greenart.movie_service.data.CommentLikeVO;
import com.greenart.movie_service.data.MovieCastingInfoVO;
import com.greenart.movie_service.data.MovieCommentDetailVO;
import com.greenart.movie_service.data.MovieCommentVO;
import com.greenart.movie_service.data.MovieHomeItemVO;
import com.greenart.movie_service.data.MovieInfoVO;
import com.greenart.movie_service.data.MovieStoryInfoVO;

@Mapper
public interface MovieMapper {
    public List<MovieHomeItemVO> selectHomeItemList(Integer opening_status, String keyword);
    public MovieInfoVO selectMovieInfoBySeq(Integer seq);
    public List<MovieStoryInfoVO> selectMovieStoryInfoBySeq(Integer seq);
    public List<MovieCastingInfoVO> selectMovieCastingInfoBySeq(Integer seq);
    public List<String> selectMovieImagesBySeq(Integer seq);
    public List<String> selectMovieTrailerBySeq(Integer seq);

    public void insertCommentInfo(MovieCommentVO data);
    public MovieCommentVO selectMovieCommentByAccount(Integer seq, Integer mi_seq); 
    // id로도 가져올수 있지만 Integer > String 이기때문에 보통 Integer를 사용한다
    public void updateMovieComment(MovieCommentVO data);
    public void deleteMovieComment(Integer seq);

    public List<MovieCommentDetailVO> selectMovieCommentList(Integer seq, Integer offset);
    public Integer selectMovieCommentPageCount(Integer seq);
    public Integer selectMovieCommentsCount(Integer seq);

    public void insertCommentLike(CommentLikeVO data);
    public CommentLikeVO selectCommentInfo(CommentLikeVO data);
    public void updateCommentLike(CommentLikeVO data);

    public Double selectMovieAvgScore(Integer seq);
    public void insertReportInfo(Integer ai_seq, Integer mc_seq, Integer reason);
    public Boolean isReported(Integer ai_seq, Integer mc_seq);
}
