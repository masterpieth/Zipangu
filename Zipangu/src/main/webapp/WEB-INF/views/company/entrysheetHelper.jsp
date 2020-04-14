<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
$(function(){
    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);
	getBookmarkList();
})
var bookmarkList;

function getBookmarkList() {
	$.ajax({
        url : "/zipangu/analysis/getBookmarkList",
        type: "post",
        success: function(data){
            bookmarkList = data;
            var type_arr = bookmarkAnalysis(data);
            var result = getEntrysheetList(type_arr);
            output(result);
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
	return type_arr;
}
function drawChart(){
	var chartData = [];
	var totalCount = 0;
	$.each(bookmarkList, function(index, item){
		var temp = [item.type, item.count];
		totalCount += item.count;
		chartData.push(temp);
	});
	var data = new google.visualization.DataTable();
	data.addColumn('string','종류');
	data.addColumn('number','등록수');
    data.addRows(chartData);
    
	var options = {
			title : '등록된 즐겨찾기 수 : ' + totalCount,
			width : 600,
			height : 400,
			is3D : true, 
		};
	var chart = new google.visualization.PieChart(document.getElementById('chartDiv'));
    chart.draw(data, options);
}
function getEntrysheetList(type_arr) {
	var total_result = [];
	$.each(type_arr, function(index, item) {
		var entrysheetList = [];
		var obj = {};
		$.each(item, function(index2, item2){
			$.ajax({
// 				url : "http://10.10.17.117:5000/getEntrysheet",
                url : "http://192.168.0.8:5000/getEntrysheet",
                type : "post",
                data : JSON.stringify({
                    jobType : item2
                    }),
                contentType : "application/json; charset=UTF-8",
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
	return total_result;
}
function output(result) {
	$.each(result, function(index, item){
		var item_arr = Object.values(item)[0];
		console.log(item_arr);
	});
}
</script>
</head>
<body>
<!--================Home Banner Area =================-->
    <section class="banner_area">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <div class="page_link">
                        <a href="<c:url value="/"/>">메인페이지
                        </a>
                        <a href="<c:url value="/analysis/company"/>">기업분석</a>
                    </div>
                    <h2>기업분석</h2>
                    <br>
                    <p style="color: white;"></p>
                </div>
            </div>
        </div>
    </section>
<!--================End Home Banner Area =================-->

<h1>자소서 작업중</h1>
<pre>
해야되는거 -> 직종 nouns 까지 뽑았으니 순서대로 돌리면서 entrysheet jobtype이랑 맞는거 있는지 조회
->조회한 결과 가져옴 각 entrysheet이랑 등록된 파일과 유사도도 제시(유사도는 일단 보류)
->entrysheet는 전체를 보여줌(paging)
->즐겨찾기 없는 경우에는 없다고 함
->그 아래쪽에는 전체 entrysheet에서 뽑아낸 문장들 선택해서 파트별로 작성할 수 있게 함
->즐겨찾기 바탕으로 google chart사용해서 관심사 시각화해서 보여줌
</pre>
<div id="chartDiv"></div>
<input type="button" value="테스트2" id="testBtn2">
<div id="resultDiv2">
</div>
</body>
</html>