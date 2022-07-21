<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/assets/css/account/join.css">
    <script>
        $(function(){
            $("#login").click(function(){
                $.ajax({
                    url:"/api/account/login",
                    type:"post",
                    contentType:"application/json",
                    data:JSON.stringify({
                        ai_id:$("#ai_id").val(),
                        ai_pwd:$("#ai_pwd").val()
                }),
                success:function(r) {
                    alert(r.message)
                    if(r.status) {
                        location.href="/"
                    }
                }
            })
        })
    })

    </script>
</head>
<body>
    <main>
        <div class="login_form">
            <h1>사용자 로그인</h1>
            <p>아이디</p>
            <input type="text" id="ai_id">
            <p>비밀번호</p>
            <input type="password" id="ai_pwd">
            <button id="login">로그인</button>
        </div>
    </main>
</body>
</html>
    