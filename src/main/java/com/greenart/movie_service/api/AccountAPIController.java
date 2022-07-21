package com.greenart.movie_service.api;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.greenart.movie_service.data.AccountInfoVO;
import com.greenart.movie_service.mapper.AccountMapper;
import com.greenart.movie_service.utils.AESAlgorithm;

@RestController
@RequestMapping("/api/account")
public class AccountAPIController {
    @Autowired AccountMapper account_mapper;
    @GetMapping("/idchk")
    public Boolean getAccountIDChk(@RequestParam String id) {
        return account_mapper.isDuplicatedId(id);
    }
    @PutMapping("/join")
    public Map<String,Object> putAccountInfo(@RequestBody AccountInfoVO data) throws Exception{
        Map<String,Object> resultMap = new LinkedHashMap<String,Object>();

        data.setAi_pwd(AESAlgorithm.Encrypt(data.getAi_pwd()));

        account_mapper.insertAccountInfo(data);
        resultMap.put("status", true);
        resultMap.put("message", "회원가입이 정상적으로 완료되었습니다.");
        return resultMap;
    }
    @PostMapping("/login")
    public Map<String,Object> postAccountLogin(@RequestBody AccountInfoVO data, HttpSession session) throws Exception{
        Map<String,Object> resultMap = new LinkedHashMap<String,Object>();

        data.setAi_pwd(AESAlgorithm.Encrypt(data.getAi_pwd()));
        AccountInfoVO user = account_mapper.login(data);
        if(user == null) {
            resultMap.put("status", false);
            resultMap.put("message", "아이디 또는 비밀번호 오류입니다.");    
            return resultMap;
        }
        else if(user.getAi_status() == 2) {
            resultMap.put("status", false);
            resultMap.put("message","이용 정지된 계정입니다.");
        }
        else if(user.getAi_status() == 3) {
            resultMap.put("status", false);
            resultMap.put("message","영구 정지된 계정입니다.");
        }
        else if(user.getAi_status() == 4) {
            resultMap.put("status", false);
            resultMap.put("message","탈퇴 대기 사용자입니다.\n탈퇴 취소는 관련 부서로 문의 바랍니다.");
        }
        else if(user.getAi_status() == 5) {
            resultMap.put("status", false);
            resultMap.put("message", "탈퇴한 회원입니다.");
        }
        else {
            resultMap.put("status", true);
            resultMap.put("message", "로그인 성공");
            session.setAttribute("user", user);
        }
        return resultMap;
    }
}
