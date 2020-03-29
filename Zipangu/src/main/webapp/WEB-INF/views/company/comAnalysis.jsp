<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<title>인재상 분석</title>
<script>
$(function(){
	$('#testBtn2').on('click', function(){
		var value = $('#inputText').val();
		var selValue = $('#listnumSel').val();
		var data = {
			inputText : value,
			listnum : selValue
		}
		var jsonData = JSON.stringify(data);
        $.ajax({
            //서버컴 IP 주소
            url : "http://10.10.17.117:5000/analysis",
            type: "post",
            contentType : "application/json; charset=UTF-8",
            data: jsonData,
            success: function(data){
                var data_arr = data['type'];
                var str = '';
                $.each(data_arr, function(index, item){
                    str += item + ' ';
                })
                $('#result').html(str);
                console.log(data_arr);
            }, error : function(data){
                console.log(data);
            }
        })
	})
})
</script>
</head>
<body>
<h1>작업중</h1>

<span>여기서 돌아야되는 작업 -> <br>
텍스트 보내기 -> 파이썬 서버에서 값 받기(까지 함)
그 다음 할 일: 각 목록별 추천 기업 리스트
분야별 자기소개서 추천 -> 자기소개서 자동완성
</span>
<br>
<div id="result"></div>
<textarea rows="4" cols="40" id="inputText" placeholder="텍스트 입력"></textarea>
<select id="listnumSel">
<option value="10">10</option>
<option value="20">20</option>
<option value="30">30</option>
</select>
<input type="button" value="클릭2" id="testBtn2">
</body>
</html>