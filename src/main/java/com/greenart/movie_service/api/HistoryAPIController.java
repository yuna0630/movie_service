package com.greenart.movie_service.api;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.greenart.movie_service.data.AccountInfoVO;
import com.greenart.movie_service.mapper.HistoryMapper;

@RestController
@RequestMapping("/api/history")
public class HistoryAPIController {
    @Autowired HistoryMapper history_mapper;
    @PutMapping("/search/add")
    public Map<String,Object> putSearchHistory(HttpSession session, @RequestParam String keyword) {
        Map<String,Object> resultMap = new LinkedHashMap<String,Object>();
        AccountInfoVO user = (AccountInfoVO)session.getAttribute("user");
        if(user == null || keyword == null || keyword.trim().equals("")){
            return null;
        }
        history_mapper.insertMovieSearchHistory(user.getAi_seq(), keyword);
        resultMap.put("status", true);
        resultMap.put("message", new Date().toString()+" History 기록됨");

        return resultMap;
    }
}