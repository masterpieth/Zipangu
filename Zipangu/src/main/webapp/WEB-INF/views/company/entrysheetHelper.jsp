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
	getBookmarkList();
    test();
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
function getBookmarkList() {
	$.ajax({
        url : "/zipangu/analysis/getBookmarkList",
        type: "post",
        success: function(data){
            var type_arr = bookmarkAnalysis(data);
            getEntrysheetList(type_arr);
        },
        error: function(e){
            console.log(e);
        }
	});
}
function bookmarkAnalysis(data) {
	var str = ''
	var type_arr = [];
	$.each(data, function(index, item) {
		str += item.type + '/' + item.count+'<br>';
		$.ajax({
			url : "/zipangu/analysis/kuromoji",
			type : "post",
			data : {
				type : item.type
			},
			async: false,
			success: function(data){
				data = $.unique(data.split(' '));
				type_arr.push(data);
			}, error: function(e){
				console.log(e);
			}
		});
	})
	$('#resultDiv').html(str);
	return type_arr;
}
function getEntrysheetList(type_arr) {
	var total_result = [];
	$.each(type_arr, function(index, item) {
		var entrysheetList = [];
		var obj = {};
		$.each(item, function(index2, item2){
			$.ajax({
				url : "http://10.10.17.117:5000/getEntrysheetList",
	            type : "post",
	            data : {
		            type : item2
	            },
	            async: false,
	            success: function(data){
		            $.each(data, function(index3, item3){
			            entrysheetList.push(item3);
			         });
	            }, error: function(e){
	                console.log(e);
	            }
			});
		});
		obj[item] = entrysheetList;
		total_result.push(obj);
	});
	console.log(total_result);
}
</script>
</head>
<body>

<h1>자소서 작업중</h1>
<pre>
해야되는거 -> 직종 nouns 까지 뽑았으니 순서대로 돌리면서 entrysheet jobtype이랑 맞는거 있는지 조회
->조회한 결과 가져옴 각 entrysheet이랑 등록된 파일과 유사도도 제시(유사도는 일단 보류)
->entrysheet는 전체를 보여줌(paging)
->즐겨찾기 없는 경우에는 없다고 함
->그 아래쪽에는 전체 entrysheet에서 뽑아낸 문장들 선택해서 파트별로 작성할 수 있게 함
->즐겨찾기 바탕으로 google chart사용해서 관심사 시각화해서 보여줌
</pre>
<input type="button" value="테스트" id="testBtn">
<div id="resultDiv"></div>
</body>
</html>