<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/assets/css/reset.css">
    <link rel="stylesheet" href="/assets/css/header.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous"/>
    <script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.structure.min.css" integrity="sha512-oM24YOsgj1yCDHwW895ZtK7zoDQgscnwkCLXcPUNsTRwoW1T1nDIuwkZq/O6oLYjpuz4DfEDr02Pguu68r4/3w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.theme.min.css" integrity="sha512-9h7XRlUeUwcHUf9bNiWSTO9ovOWFELxTlViP801e5BbwNJ5ir9ua6L20tEroWZdm+HFBAWBLx2qH4l4QHHlRyg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="/assets/js/common/util.js"></script>
    <script>
        let keyword_index = 0;
        let rank_index = 0;
        $(function() {
            let leftPos = ($(window).width() - $(".movie_list_section")) /2 - $("header").width();
            if(leftPos < 0) leftPos = 0;
            $("header").css("left", leftPos+"px");
            // 창 크기 변경 시
            $(window).resize(function(){
                let leftPos = ($(window).width() - $(".movie_list_section")) /2 - $("header").width();
                if(leftPos < 0) leftPos = 0;
                $("header").css("left", leftPos+"px");
            })

            $.ajax({
                url:"http://localhost:9989/api/keyword/rank",
                type:"get",
                success:function(r) {
                    $(".keyword_rank_wrap").html("");
                    let cnt = r.list.length<20?r.list.length:20;
                    for(let i=0; i<cnt; i++) {
                        let tag = 
                        '<div class="rank_item">'+
                            '<span>'+(i+1)+'</span><a href="/?keyword='+r.list[i]+'">'+r.list[i]+'</a>'+
                        '</div>';
                        $(".keyword_rank_wrap").append(tag);
                    }

                    setInterval(function(){
                        $(".keyword_rank_wrap .rank_item").eq(keyword_index).stop().animate({"top":"-30px"}, 1000);
                        keyword_index++;
                        if((keyword_index) >= $(".keyword_rank_wrap .rank_item").length) {
                            keyword_index = 0;
                        }
                        $(".keyword_rank_wrap .rank_item").eq(keyword_index).css("top", "30px").stop().animate({"top":"0px"}, 1000);
                    }, 7000)
                }
            })

            $.ajax({
                url:"http://localhost:9989/api/movie/search/rank",
                type:"get",
                success:function(r) {
                    console.log(r);
                    $(".movie_rank_wrap").html("");
                    for(let i=0; i<r.list.length; i++) {
                        let tag =
                        '<div class="rank_item">'+
                            '<span>'+(i+1)+'</span><a title="'+r.list[i].title+'" href="/movie/detail?movie_no='+r.list[i].seq+'">'+r.list[i].title+'</a>'+
                        '</div>';
                        $(".movie_rank_wrap").append(tag);
                    }
                    setInterval(function(){
                        $(".movie_rank_wrap .rank_item").eq(rank_index).stop().animate({"top":"-30px"}, 1000);
                        rank_index++;
                        if((keyword_index) >= $(".movie_rank_wrap .rank_item").length) {
                            keyword_index = 0;
                        }
                        $(".movie_rank_wrap .rank_item").eq(rank_index).css("top", "30px").stop().animate({"top":"0px"}, 1000);
                    }, 7000)
                }
            })
        })
    </script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
    <header>
        <nav id="gnb">
            <div class="user_info">
                <c:if test="${user == null}">
                    <a href="/account/login">로그인</a>
                    <a href="/account/join">회원가입</a>
                </c:if>
                <c:if test="${user != null}">
                    <div class="pf_img" style="background-image:url('/images/account_profile/${user.ai_profile_img}')"></div>
                    <a href="/account/detail?member_no="${user.ai_seq}>
                        <c:if test="${user.ai_nickname == null}">
                            ${user.ai_name}
                        </c:if>
                        <c:if test="${user.ai_nickname != null}">
                            ${user.ai_nickname}
                        </c:if>
                        (${user.ai_id})
                    </a>
                    <a href="/account/logout">로그아웃</a>
                </c:if>
            </div>
            <ul>
                <li>
                    <a href="/">영화 홈</a>
                </li>
                <li>
                    <a href="/score">평점·리뷰</a>
                </li>
                <li>
                    <a href="/account/review">리뷰관리</a>
                </li>
                <li>
                    <a href="/account/comment">댓글·평점 관리</a>
                </li>
            </ul>
        </nav>
        <h2>영화 검색어 순위</h2>
        <div class="keyword_rank">
            <div class="keyword_rank_wrap">
                <div class="rank_item"></div>
            </div>
        </div>
        <h2>영화 검색 순위</h2>
        <div class="movie_rank">
            <div class="movie_rank_wrap"></div>
        </div>
    </header>
</body>
</html>


<%--  --%>