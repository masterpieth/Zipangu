<jsp:include page="../include/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>Zipangu</title>
</head>
<script>

var bookmarkList;
var temp;

$(function(){
	$('#loadingDiv').hide();
	bookmarkList = getBookmarkList();
	analysis();
})
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
function analysis(){
	$('#startBtn').on('click', function(){
        var value = $('#revisedContent').val();
        var selValue = $('#listnumSel').val();
        if(value.length == 0){
            alert('텍스트 파일을 업로드해주세요.');
            return;
        }
        var data = {
            inputText : value,
            listnum : selValue
        }
        var jsonData = JSON.stringify(data);
        $.ajax({
            //서버컴 IP 주소
//             url : "http://10.10.17.117:5000/analysis",
            url : "http://192.168.0.8:5000/analysis",
            type: "post",
            contentType : "application/json; charset=UTF-8",
            data: jsonData,
            success: function(data){
                var str = output(data);
                $('#tbody').html(str);
                $('#resultContainer').removeAttr('hidden');
                comList(value);
            }, error : function(data){
                console.log(data);
            }, beforeSend : function(){
            	$('#loadingDiv').show();
            	$('#resultContainer').attr('hidden','hidden');
            }, complete : function(){
            	$('#loadingDiv').hide();
            }
        })
    })
}
function output(data){
    var str = '';
    $.each(data, function(index,item){
        str += '<tr><td style="text-align: center;">' + (index+1) + '</td>';
        str += '<td class="typename">' + item['type'] + '</td>';
        str += '<td style="text-align: center;">' + (Math.round(item['score']*100)) + '%</td>';
        str += '<td><input type="button" value="상세" class="detailBtn genric-btn danger e-large container-fluid" data-toggle="modal" data-target="#exampleModal"/></td></tr>';
    })
    return str
}

function comList(inputText){
    $('.detailBtn:button').on('click',function() {
        var type = $(this).closest('tr').find('td').eq(1).text();
        var data = {
            inputText : inputText,
            comtype : type
        }
        var jsonData = JSON.stringify(data);
        $.ajax({
//             url : "http://10.10.17.117:5000/comlist",
            url : "http://192.168.0.8:5000/comlist",
            type: "post",
            contentType : "application/json; charset=UTF-8",
            data: jsonData,
            success: function(data){
                data.splice(0,1);

                temp = data;

                
                var str = modalOutput(data);
                $('#modalTbody').html(str);
                bookmark();
                $('#myModal').modal('show');
            },
            error: function(e){
                console.log(e);
            }
        })
    });
}

function modalOutput(data){
    var str = '';
    $.each(data, function(index,item){
        str += '<tr><td>' + (index+1) + '</td>';
        str += '<td>' + item['coname'] + '</td>';
        str += '<td>' + item['location'] + '</td>';
        str += '<td>' + item['contact'] + '</td>';
        str += '<td>' + (Math.round(item['score']*100)) + '%</td>';
        if(bookmarkList.findIndex(x => x.coname === item.coname) > 0){
        	str += '<td><input type="button" value="등록됨" class="selectBtn genric-btn info e-large container-fluid" disabled="disabled"/>';
        } else if(bookmarkList.findIndex(x => x.coname === item.coname) == -1){
        	 str += '<td><input type="button" value="등록하기" class="selectBtn genric-btn info e-large container-fluid"/>';
             str += '<input type="hidden" class="type" value="'+item['type'] + '"/>';
             str += '<input type="hidden" class="company_num" value="'+item['company_num'] + '"/></td></tr>';
        }
    });
    return str;
}

function bookmark(){
	$('.selectBtn:button').on('click',function() {
		var company_num = $(this).siblings('input.company_num').val();
		var type = $(this).siblings('input.type').val();
		var coname = $(this).closest('tr').find('td').eq(1).text();
		var location = $(this).closest('tr').find('td').eq(2).text();
		var contact = $(this).closest('tr').find('td').eq(3).text();
		$.ajax({
			url : "/zipangu/analysis/bookmark",
            type: "post",
            data: {
                company_num : company_num,
                type : type,
                coname : coname,
                location : location,
                contact : contact
            },
            success: function(data){
                if(data) alert("즐겨찾기에 등록되었습니다.");
                else alert("이미 등록된 기업입니다.");
            },
            error: function(e){
                console.log(e);
            }
		});
		$(this).attr('disabled','disabled');
		$(this).attr('value','등록됨');
	})
}
function openUploadTextForm() {
    open("<c:url value='/personality/uploadTextForm'/>",
            "_blank",
            "width=600, height=800");   
}
</script>
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
     <!--================ Start Blog Area =================-->
     <section class="service-area-2 section_gap">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-lg-6">
                    <div class="service-2-left">
                        <div class="get-know">
                            <p class="df-color">기업분석</p>
                            <h1>개인 맞춤형 기업 추천 서비스</h1>
                            <hr>
                            <p>
                               업로드한 텍스트 파일과 Zipangu에 등록된 22632개의 기업정보와의 유사도를 비교하여, 개인에게 맞는 기업 리스트를 추천합니다.
                               <br>
                               아래의 가이드를 참고하여, 원하는 기업을 즐겨찾기에 등록해주세요. 등록된 즐겨찾기를 바탕으로 해당 업종의 합격자소서를 추천합니다.
                            </p>            
                            <button class="genric-btn danger e-large" onclick="openUploadTextForm()">파일 업로드</button>
                        </div>
                    </div>
                    <h4>기업분석 사용 가이드</h4>
                    <p>
                       상세순위 버튼을 누르고 관심 기업을 즐겨찾기에 추가해보세요.
                    </p>
                    <img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/comanalysis.jpg" style="width: 625px;">
                </div>
                <div class="col-lg-6">
                    <div class="service-2-right">
                        <div class="get-know">
                            <p>아래의 텍스트를 바탕으로 기업정보와의 유사도를 비교하여,
                                <br>총 126 건 중 선택한 순위만큼의 기업 종류를 추천합니다.
                                <br>분석 전 텍스트의 내용을 확인해주세요.
                            </p>
                            <select class="form-control" id="listnumSel">
                                <option value="10">10위까지</option>
                                <option value="20">20위까지</option>
                                <option value="30">30위까지</option>
                                <option value="126">전부</option>
                            </select>
                            <br>
                            <textarea rows="23" cols="74" id="revisedContent" style="resize: none;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body" style="padding-top: 85px;">
            <div  class="row justify-content-center">
                <a href="#" class="genric-btn danger e-large" id="startBtn" style="width: 300px; font-size: 15px;">시작하기</a>
            </div>
        </div>
        <div id="loadingDiv" class="row justify-content-center align-items-center" style="padding-top: 100px; padding-bottom: 200px;">
           <img src="<c:url value="/resources/img/loading.gif"/>">
        </div>
            <div class="container text-center" id="resultContainer" hidden="hidden">
               <div class="card-body" style="padding-top: 50px;" align="center">
                    <div class="col-md-7">
                        <h2 class="mb-30 title_color">분석결과 : 추천순위</h2>
                        <hr>
                        <p>사용자와 가장 유사한 기업 종류를 순위별로 표시하였습니다. 
                            <br>
                            해당 업종의 기업명 순위를 조회하려면 상세 버튼을 눌러주세요.
                        </p>
                        <hr>
                    </div>
                    <table class="table-bordered table-hover">
                        <thead>
                           <tr>
                               <th style="width: 10%;">순위</th>
                               <th style="width: 50%;">분류</th>
                               <th style="width: 20%;">추천도</th>
                               <th style="width: 20%;">상세순위</th>
                           </tr>
                       </thead>
                       <tbody id="tbody">
                       </tbody>
                   </table>
                </div>
                <div class="card-body" align="center">
                    <div class="col-md-7">
                        <hr>
                        <div  class="row justify-content-center">
	                        <p>즐겨찾기를 추가하셨나요?
	                           <br>
	                           Zipangu에 등록된 587건의 합격자소서를 통해 관심 기업에의 합격률을 올려보세요.
	                       </p>
                        </div>
	                    <div  class="row justify-content-center">
	                        <a href="<c:url value="/analysis/entrysheet"/>" class="genric-btn info e-large" id="startBtn" style="width: 300px; font-size: 15px;">자기소개서 추천 페이지로 이동</a>
	                    </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="myModalLabel">분류: 상세순위</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <table class="table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th style="width: 5%;">순위</th>
                                        <th style="width: 30%;">회사명</th>
                                        <th style="width: 15%;">지역</th>
                                        <th style="width: 40%;">연락처</th>
                                        <th style="width: 10%;">추천도</th>
                                        <th style="width: 10%;">즐겨찾기</th>
                                    </tr>
                               </thead>
                               <tbody id="modalTbody">
                               </tbody>
                           </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="genric-btn danger e-large" data-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
    </section>
    <!--================ End Blog Area =================-->
<jsp:include page="../include/footer.jsp"></jsp:include>
