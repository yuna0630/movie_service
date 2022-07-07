package com.greenart.movie_service.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greenart.movie_service.data.MovieCastingInfoVO;
import com.greenart.movie_service.data.MovieHomeItemVO;
import com.greenart.movie_service.data.MovieInfoVO;
import com.greenart.movie_service.data.MovieStoryInfoVO;

@Mapper
public interface MovieMapper {
    public List<MovieHomeItemVO> selectHomeItemList(Integer opening_status);
    public MovieInfoVO selectMovieInfoBySeq(Integer seq);
    public List<MovieStoryInfoVO> selectMovieStoryInfoBySeq(Integer seq);
    public List<MovieCastingInfoVO> selectMovieCastingInfoBySeq(Integer seq);
    public List<String> selectMovieImagesBySeq(Integer seq);
    public List<String> selectMovieTrailerBySeq(Integer seq);

}
