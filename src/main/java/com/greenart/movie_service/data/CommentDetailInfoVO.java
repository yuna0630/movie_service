package com.greenart.movie_service.data;

import java.util.Date;

import lombok.Data;

@Data
public class CommentDetailInfoVO {
    private Integer mc_seq;
    private Integer mc_parent_seq;
    private Integer mc_mi_seq;
    private Integer mc_ai_seq;
    private String mc_content;
    private Integer mc_rate;
    private Date mc_reg_dt;
    private Date mc_mod_dt;
    private Integer mi_genre_seq;
    private String mi_title;
    private Integer mi_viewing_age;
    private String mi_country;
    private Integer mi_year;
    private Integer like_cnt;
    private Integer dislike_cnt;
    
}
