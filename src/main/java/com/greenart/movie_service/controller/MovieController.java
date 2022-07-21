package com.greenart.movie_service.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.greenart.movie_service.service.MovieService;

@Controller
@RequestMapping("/movie")
public class MovieController {
    @Autowired MovieService movie_service;
    @GetMapping("/detail")
    public String getMovieDetail(@RequestParam Integer movie_no, Model model, HttpSession session) {
        
        model.addAttribute("data", movie_service.getMovieInfoAll((movie_no), session));
        return "/movie/detail";
    }
    
}
