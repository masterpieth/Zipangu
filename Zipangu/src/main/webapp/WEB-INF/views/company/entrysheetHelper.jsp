<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자기소개서 도우미</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script>

$(function(){
    test();
    var bookmarkList = ${bookmarkList}
    console.log(bookmarkList);
})
function test(){
	$('#testBtn').on('click',function(){
		$.ajax({
			url : "http://10.10.17.117:5000/test",
            type: "post",
            success: function(data){
                var result = data;
                $.each(result, function(index,item){
                    var str = '';
                    str += item['ABSORPTION'];
                    str += item['PR']
                    str += item['HOBBYNSKILL'];
                    str += item['STUDY'];
                });
            }, error : function(data){
                console.log(data);
            }
		})
	})
}
</script>
</head>
<body>

<h1>자소서 작업중</h1>

<input type="button" value="테스트" id="testBtn">
</body>
</html>