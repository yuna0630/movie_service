package com.greenart.movie_service.api;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.greenart.movie_service.data.AccountInfoVO;
import com.greenart.movie_service.data.CommentLikeVO;
import com.greenart.movie_service.data.MovieCommentVO;
import com.greenart.movie_service.mapper.MovieMapper;

@RestController
@RequestMapping("/api/movie")
public class MovieAPIController {
    @Autowired MovieMapper movie_mapper;
    @PutMapping("/comment")
    public Map<String, Object> putMovieComment(@RequestBody MovieCommentVO data) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        movie_mapper.insertCommentInfo(data);
        resultMap.put("status", true);
        resultMap.put("message", "댓글이 등록되었습니다.");
        return resultMap;
    }

    @PatchMapping("/comment")
    public Map<String, Object> patchMovieComment(@RequestBody MovieCommentVO data) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        movie_mapper.updateMovieComment(data);
        resultMap.put("status", true);
        resultMap.put("message", "댓글이 수정되었습니다.");

        return resultMap;
    }

    @DeleteMapping("/comment")
    public Map<String, Object> deleteMovieComment(@RequestParam Integer seq) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        movie_mapper.deleteMovieComment(seq);
        resultMap.put("status", true);
        resultMap.put("message", "댓글이 삭제되었습니다.");
        return resultMap;
    }

    @GetMapping("/comment/list")
    public Map<String, Object> selectMovieCommentList(
        @RequestParam Integer seq, @RequestParam Integer page
        ) {
        if(page == null) page = 1;
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        resultMap.put("totalCount", movie_mapper.selectMovieCommentsCount(seq));
        resultMap.put("pageCount", movie_mapper.selectMovieCommentPageCount(seq));
        resultMap.put("currentPage", page);
        resultMap.put("list", movie_mapper.selectMovieCommentList(seq, (page-1)*10));
        return resultMap;
    }        

    @PutMapping("/comment/like")
    public Map<String, Object> putCommentLikeInfo(@RequestBody CommentLikeVO data) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        // like 클릭 - Data가 있을 때 - 값이 dislike 였을때 -> dislike ->like변경
        // like 클릭 - Data가 있을 때 - 값이 like 였을때 -> 입력금지
        // dislike 클릭 - Data가 있을 때 - 값이 like 였을때 -> like -> dislike변경
        // dislike 클릭 - Data가 있을 때 - 값이 like 였을때 -> 입력금지
        CommentLikeVO comment = movie_mapper.selectCommentInfo(data);
        if(comment == null) {
            movie_mapper.insertCommentLike(data);
            resultMap.put("status", true);
            resultMap.put("message", "댓글 좋아요/싫어요 정보 추가");
            return resultMap;
        }
        else if(data.getCld_like_dislike() != comment.getCld_like_dislike()){
            movie_mapper.updateCommentLike(data);
            resultMap.put("status", true);
            resultMap.put("message", "댓글 좋아요/싫어요 정보 수정");
            return resultMap;
        }
        resultMap.put("status", false);
        resultMap.put("message", "이미 댓글에 좋아요/싫어요를 등록하였습니다. ");
        return resultMap;
    }
    @PutMapping("/comment/report")
    public Map<String, Object> putCommentReport(HttpSession session, @RequestParam Integer reason, @RequestParam Integer mc_seq) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        AccountInfoVO user = (AccountInfoVO)session.getAttribute("user");
        if(user == null) {
            resultMap.put("status", false);
            resultMap.put("message", "로그인 후 사용할 수 있습니다.");
            return resultMap;
        }
        if(movie_mapper.isReported(user.getAi_seq(), mc_seq)) {
            resultMap.put("status", false);
            resultMap.put("message", "이미 신고한 댓글 입니다.");
            return resultMap;
        }
        movie_mapper.insertReportInfo(user.getAi_seq(),mc_seq, reason);
            resultMap.put("status", true);
            resultMap.put("message", "댓글 신고가 등록되었습니다.");
            return resultMap;
    }
}
