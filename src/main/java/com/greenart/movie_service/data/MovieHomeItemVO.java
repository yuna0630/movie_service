package com.greenart.movie_service.data;

import java.util.Date;

import lombok.Data;

@Data
public class MovieHomeItemVO {
    private Integer mi_seq;
    private Integer mi_genre_seq;
    private String mi_title;
    private Integer mi_viewing_age;
    private Date mi_opening_dt;
    private String mimg_file_name;    
}
