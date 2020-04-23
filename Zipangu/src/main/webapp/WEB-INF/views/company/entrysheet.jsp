<jsp:include page="../include/header.jsp"></jsp:include>
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
	bookmarkList = getBookmarkList();
	if(bookmarkList.length == 0) {
		$('#resultDiv').attr('hidden','hidden');
		$('#resultDivIfnoResult').removeAttr('hidden','hidden');
		return;
	}
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
	var result;
	$.ajax({
        url : "/zipangu/analysis/getBookmarkList",
        type: "post",
        async: false,
        success: function(data){
        	result = data;
        },
        error: function(e){
            console.log(e);
        }
    });
    return result;
}
function getTotalEntrysheet() {
    $.ajax({
//         url : "http://192.168.0.8:5000/getTotalEntrysheet",
        url : "http://10.10.17.117:5000/getTotalEntrysheet",
        type : "post",
        success: function(data){
            totalEntrysheet = data;
        }, error: function(e){
            console.log(e);
        },beforeSend: function(){
            $('#loadingDiv').show();
            $('#resultDiv').hide();
            $('#resultDiv2').hide();
        },complete: function(){
        	$('#loadingDiv').hide();
            $('#resultDiv').show();
            $('#resultDiv2').show();
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
			title : '등록된 즐겨찾기 수 : ' + totalCount + '개',
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
			divStr = '<div class="tab-pane fade show active" id="li' + index +'"></div>';
		} else {
			liStr += '<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#li' + index +'">';
			liStr += item.type;
			liStr += '</a></li>';
			divStr +='<div class="tab-pane fade" id="li' + index +'"></div>';
		}
	});
	$('ul.nav-tabs').html(liStr);
	$('div.tab-content').html(divStr);
	$('#bookmark_tbody').html(bookmarkOutput(data[0].type));
}
function setEntrysheet(){
	$('a.nav-link').on('click', function(){
		var type = $(this).text();
		var divId = $(this).attr('href');
		
		var typeResult = searchEntrysheet(type);
		entrysheetOutput(typeResult, divId);
		
		var tbodyStr = bookmarkOutput(type);
		$('#bookmark_tbody').html(tbodyStr);
		$('#currentBookmarkTitle').html('즐겨찾기 상세 : ' + type);
	});
}
function searchEntrysheet(type){
	var str = '';
	var typeResult = [];
    $.each(totalEntrysheet, function(index, item){
        if(item.JOBTYPE.indexOf(type) !== -1){
            typeResult.push(item);
        }
    });
    return typeResult;
}
function bookmarkOutput(type) {
    var str = '';
    var num = 1;
    var typeResult = [];
    $.each(bookmarkList, function(index, item){
        if(item.type.indexOf(type) !== -1) {
            typeResult.push(item);
            str += '<tr><td>' + (num++) + '</td>';
            str += '<td><a href="<c:url value="/analysis/deleteBookmark"/>?company_num=' + item.company_num + '">'+ item.coname + '</a></td>';
            str += '<td>' + item.location + '</td>';
            str += '<td>' + item.contact + '</td></tr>';
        }
    });
    return str;
}

function entrysheetOutput(typeResult, divId){
	var str = '';
	str += '<table class="table paginated">';
	
	if(typeResult.length != 0){
		str += '<tr><th>규모</th></tr>';
		str += '<tr><th>' + typeResult[0].COMSIZE + '</th></tr>';
		str += '<tr><th>업종</th></tr>';
	    str += '<tr><th>' + typeResult[0].JOBTYPE + '</th></tr>';
	    str += '<tr><th>위치</th></tr>';
	    str += '<tr><th>' + typeResult[0].COMLOCATION + '</th></tr>';
	    str += '<tr><th>자격사항</th></tr>';
	    str += '<tr><th>' + typeResult[0].QUALIFICATION + '</th></tr>';
	    str += '<tr><th>취미/특기</th></tr>';
	    str += '<tr><th>' + typeResult[0].HOBBYNSKILL + '</th></tr>';
	    str += '<tr><th>공부/연구</th></tr>';
	    str += '<tr><th>' + typeResult[0].STUDY + '</th></tr>';
	    str += '<tr><th>PR</th></tr>';
	    str += '<tr><th>' + typeResult[0].PR + '</th></tr>';
	    str += '<tr><th>몰두했던 것</th></tr>';
	    str += '<tr><th>' + typeResult[0].ABSORPTION + '</th></tr>';
	    str += '<tr><th>조언</th></tr>';
	    str += '<tr><th>' + typeResult[0].ADVICE + '</th></tr>';
	} else {
		str += '<tr><th>검색결과가 없습니다.</th></tr>';
	}
	str += '</table>';
	$(divId).html(str);
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
	    <div class="row justify-content-center align-items-center">
	        <div class="card-body col-md-6" align="center">
	            <h1>합격자소서 추천</h1>
	            <hr>
	            <p>기업 분석에서 즐겨찾기 해놓은거랑,,,맞는,, 587건의 자소서를 바탕으로 해당 분야의 합격 자소서를 추천합니다.</p>
	        </div>
	    </div>
	    <br>
	    <div id="loadingDiv" class="row justify-content-center align-items-center" style="padding-top: 100px; padding-bottom: 200px;">
	       <img src="<c:url value="/resources/img/loading.gif"/>">
	    </div>
		<div class="row" id="resultDiv">
			<div class="container">
				<div class="col-md-6" style="float: right;">
				    <div class="card">
			            <h4 class="card-title">즐겨찾기 등록 현황</h4>
			            <hr>
			            <div id="chartDiv"></div>
			        </div>
				</div>
			    <div class="col-md-6">
			       <div class="card-body">
		                <h4 class="card-title" id="currentBookmarkTitle">즐겨찾기 상세</h4>
		                <hr>
		                <p>즐겨찾기 해제를 원하는 경우 해당 기업명을 클릭해주세요.</p>
		                <div class="card-body pre-scrollable" style="height: 100%;">
		                <table class="table table-hover" id="testTable">
		                    <thead>
		                        <tr>
		                            <th style="width: 10%;">#</th>
		                            <th style="width: 20%;">기업명</th>
		                            <th style="width: 15%;">위치</th>
		                            <th style="width: 55%;">연락처</th>
		                        </tr>
		                    </thead>
		                    <tbody id="bookmark_tbody">
		                    </tbody>
		                </table>
		                </div>
		            </div>
			    </div>
			</div>
		</div>
		<div class="row justify-content-center align-items-center" id="resultDivIfnoResult" hidden="hidden">
		    <div class="jumbotron" align="center">
		        <div class="card-body col-md-9">
	                <h2>등록된 즐겨찾기가 없습니다.</h2>
	                <hr>
                </div>
                <div class="row justify-content-center align-items-center">
                    <p>먼저 기업분석을 진행해주세요.</p>
                </div>
                <a href="<c:url value="/analysis/company"/>" class="genric-btn danger e-large" style="width: 300px; font-size: 15px;">기업분석 페이지로 이동</a>
		    </div>
		</div>
		<div class="row" id="resultDiv2">
		   <div class="container" id="inputContainer">
		       <ul class="nav nav-tabs">
	            </ul>
	            <div class="tab-content">
	            </div>
	        </div>
		</div>
	</div>
<div class="card">
</div>
<c:choose>
    <c:when test="${requestScope.deleteResult == true}">
        <script>
            alert('즐겨찾기가 해제되었습니다.');
        </script>
    </c:when>
    <c:when test="${requestScope.deleteResult == false}">
        <script>
        alert('즐겨찾기가 해제에 실패하였습니다.');
        </script>
    </c:when>
</c:choose>
<jsp:include page="../include/footer.jsp"></jsp:include>
