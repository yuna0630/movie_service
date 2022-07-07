<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/assets/css/movie/detail.css">
</head>
<body>
    <main>
        <section class="movie_info_section">
            <div class="basic_info">
                <div class="text">
                    <h2>
                        <span>${data.movie_info.mi_title}</span>
                        <i class="status stat${data.movie_info.mi_showing_status}">
                            <c:choose>
                                <c:when test="${data.movie_info.mi_showing_status == 0}">개봉전</c:when>
                                <c:when test="${data.movie_info.mi_showing_status == 1}">상영중</c:when>
                                <c:when test="${data.movie_info.mi_showing_status == 2}">스트리밍</c:when>
                            </c:choose>
                        </i>
                    </h2>
                    <div class="score">
                        <div class="star_score">
                            <div class="guage"></div>
                        </div>
                        <p class="score_value">9.90</p>
                    </div>
                    <table>
                        <tr>
                            <td>개요</td>
                            <td>
                                <span>${data.movie_info.genre_name}</span>
                                <span class="sep">|</span>
                                <span>${data.movie_info.mi_country}</span>
                                <span class="sep">|</span>
                                <span>${data.movie_info.mi_running_time}분</span>
                                <span class="sep">|</span>
                                <span>
                                    <fmt:formatDate value="${data.movie_info.mi_opening_dt}" pattern="yyyy.MM.dd"/>개봉
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>출연</td>
                            <td>
                                <c:forEach items="${data.movie_casting}" var="item" varStatus="stat">
                                    <span>${item.cai_name}(${item.maci_casting_name})<c:if test="${data.movie_casting.size() != stat.count}">,</c:if></span>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <td>등급</td>
                            <td>
                                <c:choose>
                                    <c:when test="${data.movie_info.mi_viewing_age == 0}">전체 관람가</c:when>
                                    <c:when test="${data.movie_info.mi_viewing_age == 12}">12세 관람가</c:when>
                                    <c:when test="${data.movie_info.mi_viewing_age == 15}">15세 관람가</c:when>
                                    <c:when test="${data.movie_info.mi_viewing_age == 19}">청소년 관람불가</c:when>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="img">
                    <div class="img_box" style="background-image:url('${data.movie_info.poster_img}');"></div>
                </div>
            </div>
            <div class="story_info">
                <h1>줄거리</h1>
                <c:forEach items="${data.movie_story}" var="item">
                    <c:if test="${item.type == 'img'}">
                        <img src="${item.content}">
                    </c:if>
                    <c:if test="${item.type == 'text'}">
                        <p>${item.content}</p>
                    </c:if>
                </c:forEach>
            </div>
            <div class="actor_list">
                <h1>배우/제작진</h1>
                <c:forEach items="${data.movie_casting}" var="item">
                    <div class="actor_item">
                        <div class="actor_pic" style="background-image:url('${item.cap_file_name}');"></div>
                        <div class="actor_txt">
                            <a href="/actor/detail?actor_no=${item.cai_seq}">${item.cai_name}</a>
                            <p>
                                <span>
                                    <c:if test="${item.maci_role == 1}">주연</c:if>
                                    <c:if test="${item.maci_role == 2}">조연</c:if>
                                </span>
                                <span class="sep">|</span>
                                <span>${item.maci_casting_name}</span>
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="movie_photo">
                <h1>포토</h1>
                <div class="gallery">
                    <div class="gallery_img_area">
                        <c:forEach items="${data.movie_imgs}" var="item">
                            <div class="gallery_img">
                                gallery_prev
                                gallery_next
                                <img src=" ${item}">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="movie_trailer">
                <h1>동영상</h1>
                <div class="trailers">
                    <c:forEach items="${data.movie_trailers}" var="item">
                        <video src=" ${item}" controls></video>
                    </c:forEach>
                </div>
            </div>
            <div class="comment_area">
                <div class="comment_item">
                    <div class="comment_score">
                        <div class="star_score">
                            <div class="star_guage"></div>
                        </div>
                    </div>
                    <div class="comment_content">
                        <p>루피는 귀여오</p>
                        <p>
                            <span class="user">닉네임(admi*******)</span>
                            <span class="sep">|</span>
                            <span class="reg_dt">2022.07.06 17:57</span>
                            <span class="sep">|</span>
                            <a href="/comment/report" class="report">신고</a>
                        </p>
                    </div>
                    <div class="comment_like_dislike">
                        <button class="like">
                            <i class="fas fa-thumbs-up"></i>
                            <span class="cnt">1,232</span>
                        </button>
                        <button class="dislike">
                            <i class="fas fa-thumbs-down"></i>
                            <span class="cnt">32</span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="input_comment_area">
                <div class="score_input">
                    <div class="score_btn">
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                        <span class="score_box"></span>
                    </div>
                    <p class="final_score">9</p>
                </div>
                <textarea id="input_comment" cols="30" rows="10"></textarea>
                <button id="save_comment">평점 등록</button>
            </div>
        </section>
    </main>
</body>
</html>
