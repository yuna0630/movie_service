<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/header.jsp"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/assets/css/movie/detail.css">
    <script>
        let movie_seq = '${data.movie_info.mi_seq}';
        let user_seq = '${user.ai_seq}';
    </script>
    <script src="/assets/js/movie/detail.js"></script>
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
                            <img src="/assets/images/star_bg.png">
                            <div class="guage" style="width:${data.score*10}%"></div>
                        </div>
                        <p class="score_value">
                            <fmt:formatNumber value="${data.score}" pattern=".00" />
                        </p>

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
                                    <fmt:formatDate value="${data.movie_info.mi_opening_dt}" pattern="yyyy.MM.dd" />개봉
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>출연</td>
                            <td>
                                <c:forEach items="${data.movie_casting}" var="item" varStatus="stat">
                                    <span>${item.cai_name}(${item.maci_casting_name})<c:if
                                            test="${data.movie_casting.size() != stat.count}">,</c:if></span>
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
                                <img src=" ${item}">
                            </div>
                        </c:forEach>
                    </div>
                    <div class="btns">
                        <button id="gallery_prev">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                        <button id="gallery_next">
                            <i class="fas fa-chevron-right"></i>
                        </button>
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
                <h1>댓글/평점</h1>
                <!-- <div class="comment_item">
                    <div class="comment_score">
                        <div class="star_score">
                            <div class="star_guage"></div>
                        </div>
                        <p class="score">10</p>
                    </div>
                    <div class="comment_content">
                        <p>루피는 귀여오</p>
                        <p class="user">
                            <span class="user">닉네임(admi***)</span>
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
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
                </div> -->
            </div>
            <div class="input_comment_area">
                <c:if test="${data.user_comment != null}">
                    <h1>내 댓글/평점</h1>
                    <div class="score_input">
                        <div class="score_btn">
                            <img src="/assets/images/star_bg.png">
                            <c:forEach begin="1" end="10" varStatus="stat">
                                <span class="score_box_click" style="left:${(stat.count-1)*12}px"></span>
                            </c:forEach>
                            <c:forEach begin="1" end="${data.user_comment.mc_rate}">
                                <span class="score_box" style="background-color: orangered;"></span>
                            </c:forEach>
                            <c:forEach begin="${data.user_comment.mc_rate + 1}" end="10">
                                <span class="score_box"></span>
                            </c:forEach>
                        </div>
                        <p class="final_score">${data.user_comment.mc_rate}</p>
                        <script>
                            score = '${data.user_comment.mc_rate}'
                        </script>
                    </div>
                    <textarea id="input_comment" cols="30" rows="10">${data.user_comment.mc_content}</textarea>
                    <button id="modify_comment" data-seq="${data.user_comment.mc_seq}">댓글/평점 수정</button>
                    <button id="delete_comment" data-seq="${data.user_comment.mc_seq}">댓글/평점 삭제</button>
                </c:if>
                <c:if test="${data.user_comment == null}">
                    <h1>댓글/평점 입력</h1>
                    <div class="score_input">
                        <div class="score_btn">
                            <img src="/assets/images/star_bg.png">
                            <c:forEach begin="1" end="10" varStatus="stat">
                                <span class="score_box_click" style="left:${(stat.count-1)*12}px"></span>
                            </c:forEach>
                            <c:forEach begin="1" end="10">
                                <span class="score_box" style="background-color: orangered;"></span>
                            </c:forEach>
                        </div>
                        <p class="final_score">10</p>
                    </div>
                    <c:if test="${user != null}">
                        <textarea id="input_comment" cols="30" rows="10"></textarea>
                        <button id="save_comment">평점 등록</button>
                    </c:if>
                    <c:if test="${user == null}">
                        <textarea cols="30" rows="10" disabled>로그인 후 사용 가능합니다.</textarea>
                        <button disabled>평점 등록</button>
                    </c:if>
                </c:if>
            </div>
        </section>
    </main>
    <div class="comment_report_popup">
        <div class="comment_report">
            <h1>댓글 신고</h1>
            <div class="comment_content">
                <p class="content"></p>
            </div>
            <p>신고 사유</p>
            <div class="reasons">
                <input type="radio" value="1" name="reason" id="reason1" checked>
                <label for="reason1">욕설 및 비방글 입니다.</label>
                <input type="radio" value="2" name="reason" id="reason2">
                <label for="reason1">음란물입니다.</label>
                <input type="radio" value="3" name="reason" id="reason3">
                <label for="reason1">불법 광고 및 홍보글 입니다.</label>
                <input type="radio" value="4" name="reason" id="reason4">
                <label for="reason1">타인의 명예를 훼손할 수 있습니다.</label>
            </div>
            <button id="report">신고하기</button>
            <button id="report_cancel">취소</button>
        </div>
    </div>
</body>

</html>