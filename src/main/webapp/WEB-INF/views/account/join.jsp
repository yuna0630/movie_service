<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/assets/css/account/join.css">
    <script src="/assets/js/account/join.js"></script>
</head>
<body>
    <main>
        <h1>회원가입</h1>
        <div class="input_form">
            <div class="data_cell">
                <p class="data_title">아이디</p>
                <input type="text" id="ai_id">
                <p class="msg not_valid">아이디를 올바르게 입력해주세요</p>
                <p class="msg err_msg">필수 정보입니다.</p>
                <p class="msg duplicate">이미 사용 중인 아이디 입니다.</p>
            </div>
            <div class="data_cell">
                <p class="data_title">비밀번호</p>
                <input type="password" id="ai_pwd">
                <p class="msg err_msg">필수 정보입니다.</p>
                <p class="msg not_valid">비밀번호를 올바르게 입력해주세요.</p>
            </div>
            <div class="data_cell">
                <p class="data_title">비밀번호 확인</p>
                <input type="password" id="ai_pwd_confirm">
                <p class="msg err_msg">필수 정보입니다.</p>
                <p class="msg not_match">비밀번호가 일치 하지 않습니다.</p>
                <p class="msg not_valid">비밀번호를 올바르게 입력해주세요.</p>
            </div>
            <div class="data_cell">
                <p class="data_title">이름</p>
                <input type="text" id="ai_name">
                <p class="msg err_msg">필수 정보입니다.</p>
                <p class="msg not_valid">이름을 올바르게 입력해주세요.</p>
            </div>
            <div class="data_cell">
                <p class="data_title">닉네임</p>
                <input type="text" id="ai_nickname">
            </div>
            <div class="data_cell">
                <p class="data_title">성별</p>
                <select id="ai_gen">
                    <option value="0">성별</option>
                    <option value="1">남자</option>
                    <option value="2">여자</option>
                    <option value="3">선택안함</option>
                </select>
                <p class="msg err_msg">필수 정보입니다.</p>
            </div>
            <div class="data_cell">
                <p class="data_title">생년월일</p>
                <input type="text" id="year" placeholder="년(4자)">
                <select id="month">
                    <option value="0">월</option>
                    <c:forEach begin="1" end="12" var="i">
                        <option value="${i}">${i}</option>
                    </c:forEach>
                </select>
                <input type="text" id="date" placeholder="일">
                <p class="msg err_msg">필수 정보입니다.</p>
            </div>
            <div class="data_cell">
                <p class="data_title">프로필 사진</p>
                <div class="img_preview"></div>
                <form id="profile_img_form">
                    <input type="file" id="pf_img" name="file" hidden>
                </form>
                <button id="file_sel" onclick="document.getElementById('pf_img').click()">파일선택</button>
                <button id="file_del">프로필 이미지 삭제</button>
            </div>
            <button id="join">가입하기</button>
        </div>
    </main>
</body>
</html>
    