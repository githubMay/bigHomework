function login(type){
    alert("login begin!!!");
    var user,pwd,kind;

    if(type==1){user = $("#stu_username_hide").val();pwd = $("#stu_password_hide").val();}        
                else if(type==2){user = $("#tea_username_hide").val();pwd = $("#tea_password_hide").val();}
                else if(type==3){user = $("#sec_username_hide").val();pwd = $("#sec_password_hide").val();};

    alert(user);
    alert(type);

    var pd = {"username":user, "password":pwd,"type":type};
    $.ajax({
        type:"post",
        url:"/",
        data:pd,
        cache:false,
        success:function(data){
            //alert(data);
            if(data=='success'){
                //$("#comtain").html(data);    
                if(type==1){window.location.href = "/student";}        
                else if(type==2){window.location.href = "/teacher";}
                else if(type==3){window.location.href = "/secretary";};
        }
        else {alert(data+"please login again!!!");window.location.href = "/"};
            //$("#courseTable").html(data);
            
        },
        error:function(){
            alert("error!");
        },
    });
}



$(document).ready(function(){
    //alert("ready");
    var loginType=0;
    $( "#login" ).on( "click", function( event ) {loginType=1;login(loginType);return false;});
    $( "#tealogin" ).on( "click", function( event ) {loginType=2;login(loginType);return false;});
    $( "#seclogin" ).on( "click", function( event ) {loginType=3;login(loginType);return false;});
    //$("#login").click(login());
});

