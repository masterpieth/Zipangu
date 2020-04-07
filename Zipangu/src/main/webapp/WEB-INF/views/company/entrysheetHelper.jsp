<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자기소개서 도우미</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script>

$(function(){
    test();
})

function test(){
	$('#testBtn').on('click',function(){
		$.ajax({
			url : "http://10.10.17.117:5000/test",
            type: "post",
            success: function(data){
//                 var result = data;
//                 $.each(result, function(index,item){
//                     var str = '';
//                     str += item['ABSORPTION'];
//                     str += item['PR']
//                     str += item['HOBBYNSKILL'];
//                     str += item['STUDY'];
//                     keyword = kuromoji(str);
//                     item.feature = keyword;
//                 });
//                 console.log(result);
                var str = data[0]['PR'];
                console.log(kuromoji(str));
            }, error : function(data){
                console.log(data);
            }
		})
	})
}
function kuromoji(str){
	$.ajax({
		url:"/zipangu/analysis/kuromoji",
		data: {
			  str: str
		},
		type: "post",
		success: function(data){
			return data;
		}, error: function(data){
			console.log(data);
		}
	})
}
</script>
</head>
<body>

<h1>자소서 작업중</h1>

<input type="button" value="테스트" id="testBtn">

</body>
</html>