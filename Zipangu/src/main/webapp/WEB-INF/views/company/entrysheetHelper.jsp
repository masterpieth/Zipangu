<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>

var bookmarkCount;
var bookmarkList;
var totalEntrysheet;
var type_arr;

$(function(){
	getBookmarkCount();
	getBookmarkList();
	getTotalEntrysheet();
    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);
    
    setNavUl(bookmarkCount);
    bookmarkAnalysis(bookmarkCount);

    setEntrysheet();
})

function getBookmarkCount() {
	$.ajax({
        url : "/zipangu/analysis/getBookmarkCount",
        type: "post",
        async: false,
        success: function(data){
            bookmarkCount = data;
        },
        error: function(e){
            console.log(e);
        }
	});
}
function getBookmarkList(){
	$.ajax({
        url : "/zipangu/analysis/getBookmarkList",
        type: "post",
        async: false,
        success: function(data){
        	bookmarkList = data;
        },
        error: function(e){
            console.log(e);
        }
    });
}
function getTotalEntrysheet() {
    $.ajax({
        url : "http://192.168.0.8:5000/getTotalEntrysheet",
        type : "post",
        success: function(data){
            totalEntrysheet = data;
        }, error: function(e){
            console.log(e);
        }
    });
}
function drawChart(){
	var chartData = [];
	var totalCount = 0;
	$.each(bookmarkCount, function(index, item){
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

function bookmarkAnalysis(data) {
    var str = ''
    var temp = [];
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
                temp.push(data);
            }, error: function(e){
                console.log(e);
            }
        });
    })
    type_arr = temp;
}
function setNavUl(data) {
	var liStr = '';
	var divStr = '';
	$.each(data, function(index, item){
		if(index == 0){
			liStr += '<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#li' + index +'">';
			liStr += item.type;
			liStr += '</a></li>';
			divStr = '<div class="tab-pane fade show active" id="li' + index +'">'+ index + '</div>';
		} else {
			liStr += '<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#li' + index +'">';
			liStr += item.type;
			liStr += '</a></li>';
			divStr +='<div class="tab-pane fade" id="li' + index +'">' + index + '</div>';
		}
	});
	$('ul.nav-tabs').html(liStr);
	$('div.tab-content').html(divStr);

	var str = entrysheetOutput(data[0].type);
	if(str.length != 0){
		$('#li0').html(str);
	} else {
		$('#li0').html('검색 결과가 없습니다.');
	}
	$('#bookmark_tbody').html(bookmarkOutput(data[0].type));
}
function setEntrysheet(){
	$('a.nav-link').on('click', function(){
		var type = $(this).text();
		var divId = $(this).attr('href');
		var str = entrysheetOutput(type);
		if(str.length != 0){
			$(divId).html(str);
		} else {
			$(divId).html('검색 결과가 없습니다.');
		}
	});
}
function entrysheetOutput(type){
	var str = '';
    $.each(totalEntrysheet, function(index, item){
        if(item.JOBTYPE.indexOf(type) !== -1){
            str += item.ABSORPTION +'<br>';
            str += item.ADVICE +'<br>';
            str += item.COMLOCATION +'<br>';
            str += item.COMSIZE +'<br>';
            str += item.HOBBYNSKILL +'<br>';
            str += item.JOBTYPE +'<br>';
            str += item.PR +'<br>';
            str += item.QUALIFICATION +'<br>';
            str += item.STUDY +'<br>';
        }
    });
    return str;
}
function bookmarkOutput(type) {
	var str = '';
	$.each(bookmarkList, function(index, item){
		if(item.type.indexOf(type) !== -1) {
			str += '<tr><td>' + item.company_num + '</td>';
			str += '<td>'+ item.coname + '</td>';
			str += '<td>' + item.location + '</td>';
			str += '<td>' + item.contact + '</td></tr>';
		}
	});
	return str;
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
                        <a href="<c:url value="/analysis/company"/>">자기소개서 추천</a>
                    </div>
                    <h2>자기소개서 추천</h2>
                    <br>
                    <p style="color: white;"></p>
                </div>
            </div>
        </div>
    </section>
<!--================End Home Banner Area =================-->

	<div class="container-fluid">
	    <br>
		<div class="row">
		    <div class="col-md-6">
				<div id="chartDiv"></div>
		    </div>
			<div class="col-md-6">
	            <table class="table">
	                <thead>
	                    <tr>
	                        <th>#</th>
	                        <th>기업명</th>
	                        <th>위치</th>
	                        <th>연락처</th>
	                    </tr>
	                </thead>
	                <tbody id="bookmark_tbody">
	                </tbody>
	            </table>
			</div>
		</div>
		<div class="row">
		   <div class="container" id="inputContainer">
		       <ul class="nav nav-tabs">
	            </ul>
	            <div class="tab-content">
	            </div>
	        </div>
		</div>
	</div>
<input type="button" value="테스트2" id="testBtn2">
<div id="resultDiv2">
</div>
</body>
</html>