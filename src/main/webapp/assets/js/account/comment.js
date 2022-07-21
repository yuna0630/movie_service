$(function(){
    $(".delete").click(function(){
        if(!confirm("댓글/평점을 삭제하시겠습니까?")) return;
        let seq = $(this).attr("data-seq");
        $.ajax({
            url:"/api/movie/comment?seq="+seq,
            type:"delete",
            success:function(r) {
                alert(r.message);
                location.reload();
            }
        })
    })
})