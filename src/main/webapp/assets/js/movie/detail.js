let score = 10;
$(function(){
    getMovieComments(1);
    $(".score_box_click").click(function(){
        if(user_seq == null || user_seq == '') {
            alert("로그인 후 사용 가능합니다.")
            return;
        }
        // 점수 박스의 모든 배경 색을 투명으로 지정
        $(".score_box").css("background-color", "transparent");
        // 현재 클릭된 스코어박스의 순서를 가져와서
        let index = $(this).index()-1;
        // 인덱스는 0부터 시작하기 때문에 1의 오차를 계산
        score = index+1;
        for(let i=0; i<index+1; i++) {
            // 0번 부터 클릭된 위치의 박스까지 순차적으로 조회하며, 배경색을 오렌지레드로 설정
            $(".score_box").eq(i).css("background-color", "orangered");
        }
        // 점수 텍스트를 계산한 값으로 설정
        $(".final_score").html(score);
    })

    $("#modify_comment").click(function(){
        if(!confirm("댓글과 평점을 수정하시겠습니까?")) return;
        let data = {
            mc_seq:$(this).attr("data-seq"),
            mc_content:$("#input_comment").val(),
            mc_rate:score
        }
        $.ajax({
            url:"/api/movie/comment",
            type:"patch",
            contentType:"application/json",
            data:JSON.stringify(data),
            success:function(r) {
                alert(r.message);
                location.reload();
            }
        })
    })

    $("#delete_comment").click(function(){
        if(!confirm("댓글과 평점을 삭제 하시겠습니까?")) return;
        $.ajax({
            url:"/api/movie/comment?seq="+$(this).attr("data-seq"),
            type:"delete",
            success:function(r) {
                alert(r.message);
                location.reload();
            }
        })
    })

    $("#save_comment").click(function(){
        let data = {
            mc_mi_seq:movie_seq,
            mc_ai_seq:user_seq,
            mc_content:$("#input_comment").val(),
            mc_rate:score
        }
        $.ajax({
            url:"/api/movie/comment",
            type:"put",
            contentType:"application/json",
            data:JSON.stringify(data),
            success:function(r) {
                alert(r.message);
                location.reload();
            }
        })
    })
})

function getMovieComments(page) {
    if(page == undefined) page = 1;
    $.ajax({
        url:"/api/movie/comment/list?seq="+movie_seq+"&page="+page,
        type:"get",
        success:function(r) {
            console.log(r);
            if(r.list.length == 0) {
                let tag = 
                '<div class="comment_item">'+
                    '<h1>등록된 댓글 및 평점이 없습니다.</h1>'+
                '</div>'
                $(".comment_area").append(tag);
            }
            for(let i=0; i<r.list.length; i++) {
                let data = r.list[i];
                let user = (data.ai_nickname==null?data.ai_name:data.ai_nickname)+"("+data.ai_id+")";
                let tag =
                    '<div class="comment_item">'+
                        '<div class="star_score">'+
                            '<img src="/assets/images/star_bg.png">'+
                            '<div class="star_guage" style="width:'+data.mc_rate*10+'%;"></div>'+
                        '<p class="score">'+data.mc_rate+'</p>'+
                        '</div>'+
                        '<div class="comment_content">'+
                            '<p class="comment">'+data.mc_content+'</p>'+
                            '<p class="user">'+
                                '<span class="user">'+user+'</span>'+
                                '<span class="sep">|</span>'+
                                '<span class="reg_dt">'+data.mc_reg_dt+'</span>'+
                                '<span class="sep">|</span>'+
                                '<span class="mod_dt">'+data.mc_mod_dt+'</span>'+
                                '<span class="sep">|</span>'+
                                '<a href="/comment/report?seq='+data.mc_seq+'" class="report" data-seq="'+data.mc_seq+'">신고</a>'+
                            '</p>'+
                        '</div>'+
                        '<div class="comment_like_dislike">'+
                            '<button class="like" data-seq="'+data.mc_seq+'">'+
                                '<i class="fas fa-thumbs-up"></i>'+
                                '<span class="cnt">'+data.like_cnt+'</span>'+
                            '</button>'+
                            '<button class="dislike" data-seq="'+data.mc_seq+'">'+
                                '<i class="fas fa-thumbs-down"></i>'+
                                '<span class="cnt">'+data.dislike_cnt+'</span>'+
                            '</button>'+
                        '</div>'+
                    '</div>'
                    $(".comment_area").append(tag);
            }
            $(".like, .dislike").click(function(){
                if(user_seq == '' || user_seq == null) {
                    alert("로그인 후 사용 가능합니다.")
                    return;
                }
                let seq =$(this).attr("data-seq");
                let data = {
                    cld_ai_seq:user_seq,
                    cld_mc_seq:seq,
                    cld_like_dislike:$(this).attr("class") == 'like'?1:0
                }
                console.log(data);
                $.ajax({
                    url:"/api/movie/comment/like",
                    type:"put",
                    contentType:"application/json",
                    data:JSON.stringify(data),
                    success:function(r){
                        if(!r.status) {
                            alert(r.message);
                            return;
                        }
                        location.reload();
                    }
                })
            })
            $(".report").click(function(e){
                e.preventDefault();
                $(".comment_report_popup").show();
                $("#report").attr("data-seq", $(this).attr("data-seq"));
                $(".comment_report .content").html($(this).parent().parent().find(".comment").html());
            });
            $("#report_cancel").click(function(){
                if(!confirm("신고를 취소하시겠습니까?")) return;
                $(".comment_report_popup").hide();
            })
            $("#report").click(function(){
                if(!confirm("댓글을 신고하시겠습니까?")) return;
                $.ajax({
                    url:"/api/movie/comment/report?mc_seq="+$(this).attr("data-seq")+"&reason="+$(".reasons input:checked").val(),
                    type:"put",
                    success:function(r) {
                        alert(r.message);
                        $(".comment_report_popup").hide();
                    }
                })
            })
        }
    })
}




