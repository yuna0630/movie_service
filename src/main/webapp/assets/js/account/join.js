let profile_img_file = "";
let duplicate = true;
$(function(){
    $("#file_del").click(function(){
        if(profile_img_file != '' && profile_img_file != null && profile_img_file != undefined) {
            $(".img_preview").css("background-image", "");
            deleteProfileImg(profile_img_file);
        }
    })

    $("#pf_img").change(function(){
        $("#file_del").trigger("click");
        let form = $("#profile_img_form");
        let formData = new FormData(form[0]);
        if($(this).val() == '' || $(this).val() == null) return;
        $.ajax({
            url:"/image/upload/profile",
            type:"put",
            data:formData, contentType:false, processData:false,
            success:function(r) {
                console.log(r);
                profile_img_file = r.file;
                $(".img_preview").css("background-image", "url('/images/account_profile/"+r.file+"')")
                $("#pf_img").val("");
            }
        })
    });
    
    $("#ai_id").keyup(function(){
        if(isEmpty($(this).val())) {
            $(".not_valid").css("display", "block");
        }
        else {
            $(".not_valid").css("display", "");
        }
    });
    $("#ai_id").change(function(){
        $.ajax({
            url:"/api/account/idchk?id="+$(this).val(),
            type:"get",
            success:function(r) {
                if(r) $(".duplicate").css("display", "block");
                else $(".duplicate").css("display", "");
            }
        })
    });
    $("#ai_pwd").keyup(function(){
        if(isEmpty($(this).val())) $("#ai_pwd~.not_valid").css("display", "block");
        else $("#ai_pwd~.not_valid").css("display", "");
    })

    $("#ai_pwd_confirm").keyup(function(){
        if($(this).val() != $("#ai_pwd").val()) $("#ai_pwd_confirm~.not_match").css("display", "block");
        else $("#ai_pwd_confirm~.not_match").css("display", "");
        
        if(isEmpty($(this).val())) $("#ai_pwd_confirm~.not_valid").css("display", "block");
        else $("#ai_pwd_confirm~.not_valid").css("display", "");
    });

    $("#ai_name").keyup(function(){
        if(isEmpty($(this).val(), false)) $("#ai_name~.not_valid").css("display", "block");
        else $("#ai_name~.not_valid").css("display", "");
    })

    $("#ai_gen").change(function(){
        if($(this).val() == 0) $("#ai_gen~.err_msg").css("display", "block");
        else $("#ai_gen~.err_msg").css("display", "");
    });

    $("#join").click(function(){
        let accept = true;
        if(isEmpty($("#ai_id").val())) {
            $("#ai_id~.not_valid").css("display", "block");
            accept = false;
        }
        else {
            $("#ai_id~.not_valid").css("display", "");
        }

        if(isEmpty($("#ai_pwd").val())){
            $("#ai_pwd~.not_valid").css("display", "block");
            accept = false;
        }
        else $("#ai_pwd~.not_valid").css("display", "");

        if($("#ai_pwd_confirm").val() != $("#ai_pwd").val()){
            $("#ai_pwd_confirm~.not_match").css("display", "block");
            accept = false;
        }
        else $("#ai_pwd_confirm~.not_match").css("display", "");
        
        if(isEmpty($("#ai_pwd_confirm").val())) {
            $("#ai_pwd_confirm~.not_valid").css("display", "block");
            accept = false;
        }
        else $("#ai_pwd_confirm~.not_valid").css("display", "");

        if(isEmpty($("#ai_name").val(), false)) {
            $("#ai_name~.not_valid").css("display", "block");
            accept = false;
        }
        else $("#ai_name~.not_valid").css("display", "");

        if($("#ai_gen").val() == 0) {
            $("#ai_gen~.err_msg").css("display", "block");
            accept = false;
        }
        else $("#ai_gen~.err_msg").css("display", "");

        if(!accept) return;
        let data = {
            ai_id:$("#ai_id").val(),
            ai_pwd:$("#ai_pwd").val(),
            ai_name:$("#ai_name").val(),
            ai_nickname:$("#ai_nickname").val(),
            ai_birth: new Date($("#year").val()+"-"+$("#month option:selected").val()+"-"+$("#date").val()),
            ai_gen:$("#ai_gen option:selected").val(),
            ai_profile_img:profile_img_file
        }
        console.log(JSON.stringify(data));
        $.ajax({
            url:"/api/account/join",
            type:"put",
            data:JSON.stringify(data),
            contentType:"application/json",
            success:function(r){
                alert(r.message);
                location.href = "/account/login";
            }
        })
    })
})

function deleteProfileImg(file) {
    $.ajax({
        url:"/image/delete/"+file,
        type:"delete",
        success:function(r) {
            console.log(r.message);
        }
    })
}