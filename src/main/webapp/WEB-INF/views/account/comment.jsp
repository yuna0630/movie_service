<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="/assets/js/account/comment.js"></script>
</head>
<body>
    <main>
        <h1>댓글 평점 관리</h1>
        <p>총 ${totalCnt}건</p>
        <div class="comment_list">
        <c:forEach items="${list}" var="item">
            <div class="comment_item">
                <div class="movie_info">
                    <p>
                        <span>${item.mi_year}</span>
                        <span>${item.mi_country}</span>
                    </p>
                    <a href="/movie/detail?movie_no=${item.mc_mi_seq}" target="_blank">${item.mi_title}</a>
                </div>
                <div class="comment_and_score">
                    <div class="info1">
                        <div class="score">
                            <img src="/assets/images/star_bg.png">
                            <div class="progress" style="width:${item.mc_rate*10}%"></div>
                        </div>
                        <div class="reg_dt">
                            <fmt:formatDate value="${item.mc_reg_dt}" pattern="yyyy.MM.dd HH:mm"/>
                        </div>
                        <c:if test="${item.mc_reg_dt != item.mc_mod_dt}">
                            <div class="mod_dt">
                                <fmt:formatDate value="${item.mc_mod_dt}" pattern="yyyy.MM.dd HH:mm"/>
                            </div>
                        </c:if>
                    </div>
                    <div class="info2">
                        <div class="content">
                            <p>${item.mc_content}</p>
                        </div>
                        <div class="like"><i class="fas fa-thumbs-up"></i><span>${item.like_cnt}</span></div>
                        <div class="dislike"><i class="fas fa-thumbs-down"></i><span>${item.dislike_cnt}</span></div>
                    </div>
                    <div class="buttons">
                        <button id="delete" data-seq="${item.mc_seq}">삭제</button>
                    </div>
                </div>
            </div>
        </c:forEach>
        </div>
        <div class="pager_area">
            <c:forEach begin="1" end="${pageCnt}" var="i">
                <a href="/account/comment?page=${i}" class="pager">${i}</a>
            </c:forEach>
        </div>
    </main>
</body>
</html>
    