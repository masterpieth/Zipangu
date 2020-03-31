<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<title>기업 분석</title>
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
				var str = output(data_arr);
				$('#tbody').html(str);
				
				comList(value);
			}, error : function(data){
				console.log(data);
			}
		})
	})
	
	function output(data_arr){
		var str = '';
		$.each(data_arr, function(index,item){
			str += '<tr><td class="typename">' + item + '</td></tr>';
		})
		return str
	}
	
	function comList(inputText){
		$('td.typename').on('click',function() {
			var type = $(this).html();
			var data = {
				inputText : inputText,
				comtype : type
			}
			var jsonData = JSON.stringify(data);
			$.ajax({
				url : "http://10.10.17.117:5000/comlist",
				type: "post",
				contentType : "application/json; charset=UTF-8",
				data: jsonData,
				success: function(data){
					var str = '';
					$.each(data, function(index, item){
						str += '번호' + item.company_num + '회사명' + item.coname + '<br>' + '회사위치' + item.location + '<br>' + '연락처' + item.contact + '<br>';
					})
					$('#listResult').html(str);
				},
				error: function(){}
			})
		});
	}
})
</script>
</head>
<body>

<h1>작업중</h1>
<span>여기서 돌아야되는 작업 -> <br>
텍스트 보내기 -> 파이썬 서버에서 값 받기(까지 함)
그 다음 할 일: 각 목록별 추천 기업 리스트(오긴 함)
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
<table>
    <thead>
        <tr>
            <th>이름</th>
        </tr>
    </thead>
    <tbody id="tbody">
    </tbody>
</table>
<hr>
<div id="listResult"></div>
</body>
</html>