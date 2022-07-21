package com.greenart.movie_service.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.greenart.movie_service.data.AccountInfoVO;
import com.greenart.movie_service.mapper.AccountMapper;
import com.greenart.movie_service.mapper.MovieMapper;

@Controller
@RequestMapping("/account")
public class AccountController {
    @Autowired AccountMapper account_mapper;
    @Autowired MovieMapper movie_mapper;
    @GetMapping("/join")
    public String getAccountJoin() {
        return "/account/join";
    }
    @GetMapping("/login")
    public String getLogin() {
        return "/account/login";
    }
    @GetMapping("/logout")
    public String getLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/comment")
    public String getAccountComment(
        HttpSession session, @RequestParam @Nullable Integer page, Model model
        ) {
        AccountInfoVO user = (AccountInfoVO)session.getAttribute("user");
        if(user == null) {
            return "redirect:/account/login";
        }
        if(page == null) page =1;
        model.addAttribute("list", account_mapper.selectCommentsByAccountSeq(user.getAi_seq(), (page-1)*10));
        model.addAttribute("pageCnt", account_mapper.selectCommentsPageCountByAccountSeq(user.getAi_seq()));
        model.addAttribute("totalCnt",account_mapper.selectCommentsCountByAccountSeq(user.getAi_seq()));
        model.addAttribute("currentPage",page);
        return "/account/comment";
    }
}
