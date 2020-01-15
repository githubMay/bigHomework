
function render_list(list) {
    var tbody =  $("#list-tbody").empty();
    var k=0
    for (i in list) {
        var student = list[i];
        //console.log(student['cname']);
        if(student['cname']){
        var row = $('<tr>');

        $('<td>').text(parseInt(++k)).appendTo(row);
        $('<td>').text(student['cname']).appendTo(row);
        //$('<td>').text(student['ctime']).appendTo(row);
        var cTime2=student['ctime'];
        var c=cTime2%10;var noUse=parseInt(cTime2/10);var a=parseInt(noUse/10);var b=noUse%10;
        var str='';
        if(c=='1'){str+='星期一'}else if(c=='2'){str+='星期二'}else if(c=='3'){str+='星期三'}
        else if(c=='4'){str+='星期四'}else if(c=='5'){str+='星期五'}else if(c=='6'){str+='星期六'}else if(c=='7'){str+='星期日'};
       if(a=='1'){str+='上午'}else if(a=='2'){str+='下午'}else if(a=='3'){str+='晚上'};
       if(b=='1'){str+='第一大节'}else if(b=='2'){str+='第二大节'};
       $('<td>').text(str).appendTo(row);
        $('<td>').text(student['cteacher']).appendTo(row);
        $('<td>').text(student['cclass']).appendTo(row);
        $('<td>').text(student['cstudent']).appendTo(row);
        var btn_edit = $('<button>')
            .text('修改')
            .on( "click", (function(student) {
                return function( event ) {
                    var time_id = student['time_id'];
                    console.log('edit: ' + time_id);
                    edit_student(time_id);
                }
            })(student));

        var btn_del = $('<button>')
            .text('删除')
            .on( "click", (function(item) { 
                return function( event ) {
                    delete_student(item['time_id']);
                }
            })(student));

        $('<td>').append(btn_edit).append(btn_del).appendTo(row);


        row.appendTo(tbody);};
    }
}

function load_list() {
    $('#dlg-student-form').hide();
	$.ajax({
        type: 'GET',
  		url: "/s/student/",
        data: '',
        dataType: 'json' 
	})
    .done(function(data) {
        alert("return success!!!");
        render_list(data);
    });
}

function get_details(time_id) {
  $.ajax({ 
    type: 'get', 
    url: '/subscriptions/' + id,
    data: "subscription[title]=" + encodeURI(value),
    dataType: 'script' 
 	}); 
 
$.ajax({ 
type: 'PUT', 
url: '/subscriptions/' + id,
data: "subscription[title]=" + encodeURI(value),
dataType: 'script' 
}); 

}

function edit_student(time_id) {
    $('input[type=radio][name="radio3"]:checked').prop("checked", false);
    $('input[type=radio][name="radio2"]:checked').prop("checked", false);
    $('input[type=radio][name="radio1"]:checked').prop("checked", false);

    function put_student() {
        var item = {};
        var time_id = $('#frm-student input[name="time_id"]').val();
        item['time_id'] = time_id;
        item['cName'] = $('#frm-student input[name="cName"]').val();
        //item['cTime'] = $('#frm-student input[name="cTime"]').val();
        var cTime=0;
        var indexWeek=$("input[name='radio3']:checked").parent().parent().index();
        var indexMOrA=$("input[name='radio1']:checked").parent().parent().index();
        var indexFOrS=$("input[name='radio2']:checked").parent().parent().index();
        cTime=indexMOrA*100+indexFOrS*10+indexWeek;
        alert(cTime)
        item['cTime'] =cTime;


        item['cTeacher'] = $('#frm-student input[name="cTeacher"]').val();
        item['cClass'] = $('#frm-student input[name="cClass"]').val();
        item['cStudent'] = $('#frm-student input[name="cStudent"]').val();
        var jsondata = JSON.stringify(item);
        $.ajax({ 
            type: 'PUT', 
            url: '/s/student/' + time_id,
            data: jsondata,
            dataType: 'json' 
        })
        .done(function(){
            load_list();
            $('#dlg-student-form').hide()
        });

        return false; // 在AJAX下，不需要浏览器完成后续的工作。
    }

    $.ajax({ 
        type: 'GET', 
        url: '/s/student/' + time_id,
        dataType: 'json' 
    })
    .then(function(item) {
        $('#frm-student input[name="time_id"]').val(item['time_id']);
        $('#frm-student input[name="cName"]').val(item['cname']);
        $('#frm-student input[name="cTime"]').val(item['ctime']);
        $('#frm-student input[name="cTeacher"]').val(item['cteacher']);
        $('#frm-student input[name="cClass"]').val(item['cclass']);
        $('#frm-student input[name="cStudent"]').val(item['cstudent']);

        $('#frm-student').off('submit').on('submit', put_student);
        $('#frm-student input:submit').val('修改')
        $('#dlg-student-form').show()
    }); 

}


function conflict_test(){
    /*var rand = Math.floor((Math.random()*1000000)+1000000);
	var req_data = {
		name: "测试-" + rand,
		no: "S#R" + rand
	}; */
    //$('#list-tbody').empty();#take trouble to do this!!!


	$.ajax({
        type: 'GET',
  		url: "/s/student/conflict",
        data: '',
        dataType: 'json' 
	})
    .done(function(data) {
        console.log(data);
        render_list(data);
    }); 

}

function register_student() {
    // 因为新添和修改都使用和这个表单，因此需要置空这个表单
    $('#frm-student input[name="time_id"]').val('');
    $('#frm-student input[name="cName"]').val('');
    $('#frm-student input[name="cTime"]').val('');
    $('#frm-student input[name="cTeacher"]').val('');
    $('#frm-student input[name="cClass"]').val('');
    $('#frm-student input[name="cStudent"]').val('');
    $('input[type=radio][name="radio3"]:checked').prop("checked", false);
    $('input[type=radio][name="radio2"]:checked').prop("checked", false);
    $('input[type=radio][name="radio1"]:checked').prop("checked", false);

    $('#frm-student input:submit').val('新增');
     // 要先把前面事件处理取消掉，避免累积重复事件处理
    $('#frm-student').off('submit').on('submit', function() {
        var item = {};
        item['cName'] = $('#frm-student input[name="cName"]').val();
        //item['cTime'] = $('#frm-student input[name="cTime"]').val();
        var cTime=0;
        var indexWeek=$("input[name='radio3']:checked").parent().parent().index();
        var indexMOrA=$("input[name='radio1']:checked").parent().parent().index();
        var indexFOrS=$("input[name='radio2']:checked").parent().parent().index();
        var cTime=indexMOrA*100+indexFOrS*10+indexWeek;
        alert(cTime);
            item['cTime'] =cTime;
        item['cTeacher'] = $('#frm-student input[name="cTeacher"]').val();
        item['cStudent'] = $('#frm-student input[name="cStudent"]').val();
        item['cClass'] = $('#frm-student input[name="cClass"]').val();
        $.ajax({ 
            type: 'POST', 
            url: '/s/student/',
            data: JSON.stringify(item),
            dataType: 'json' 
        })
        .done(function(){
            load_list();
            $('#dlg-student-form').hide()
        });

        return false; // 在AJAX下，不需要浏览器完成后续的工作。
    });
    $('#dlg-student-form').show()
}


function delete_student(time_id) {
    $.ajax({
        type: 'DELETE',
        url: '/s/student/' + time_id,
        dataType: 'html'
    })
    .done(function() {
        load_list();
    });
}

//----------------------------------------------------
$(document).ready(function() {
    $('#dlg-student-form').hide();
    $( "#btn-radd" ).on( "click", function( event ) {
        conflict_test();
    });
    $( "#btn-refresh" ).on( "click", load_list);
    $( "#btn-new" ).on( "click", register_student);
    $( "#btn-student-frm-close" ).on( "click", function() {
        // 在关闭浏览器时，可能会自动提交，需要设置一个空提交方法。
        $('#frm-student').off('submit').on('submit', function() {
            return false;
        });
        $('#dlg-student-form').hide();
    });

    load_list();
});

//---设置AJAX缺省的错误处理方式
//---有时需要禁止全局错误处理时，可以在调用ajax时增添{global: false}禁止
$(document).ajaxError(function(event, jqxhr, settings, exception) {
    var msg = jqxhr.status + ': ' + jqxhr.statusText + "\n\n";
    if (jqxhr.status == 404 || jqxhr.status == 405 ) { 
        msg += "访问REST资源时，URL错误或该资源的请求方法\n\n"
        msg += settings.type + '  ' + settings.url  
    } else {
        msg += jqxhr.responseText;
    }
    alert(msg);
});


