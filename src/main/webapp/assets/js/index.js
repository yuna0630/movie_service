$(function(){
    $(".tab_button").click(function(){
        let index = $(this).index();
        $(".tab_button, .movieList").removeClass("on")
        $(".movieList").eq(index).addClass("on");
        $(this).addClass("on");
    })
})