$(document).ready(function(){
        $("#search").click(function(){

        var searchTerm=$("#term").val();
        var pd={"otherTerm":searchTerm};
        $.ajax({
            type:"POST",
            url:"/student",
            data:pd,
            cache:false,
            //datatype:"html",
            success:function(data){
                alert("hope all right!!!");
                alert(data);
                //data='"'+data+'"';
                console.log(data);

                //window.location.href = "/yusirxiaer";
                $("#comtain").html(data);
                
            },
            error:function(XMLHttpResquest,textStatus,errorThrown){
                alert(XMLHttpResquest);
                alert(textStatus);
                alert(errorThrown);
                
                alert("error!");
            },
        });
        return false;
    });  
      
});