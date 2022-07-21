package com.greenart.movie_service.data;

import java.util.Date;

import lombok.Data;

@Data
public class MovieCommentDetailVO {
    private Integer mc_seq;
    private Integer mc_parent_seq;
    private Integer mc_mi_seq;
    private Integer mc_ai_seq;
    private String mc_content;
    private Integer mc_rate;
    private Date mc_reg_dt;
    private Date mc_mod_dt;

    private String ai_id;
    private String ai_name;
    private String ai_nickname;
    private String ai_profile_img;
    private Integer like_cnt;
    private Integer dislike_cnt;
}
