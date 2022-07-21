package com.greenart.movie_service.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HistoryMapper {
    public void insertMovieSearchHistory(Integer seq, String keyword);
    public void insertMovieLookupHistory(Integer mi_seq, Integer ai_seq);
}