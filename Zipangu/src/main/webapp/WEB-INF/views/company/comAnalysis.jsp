<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/header.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>

<script>
$(function(){
	analysis();
})

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
            url : "http://10.10.17.117:5000/analysis",
//             url : "http://192.168.0.8:5000/analysis",
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
        str += '<td><input type="button" value="상세" class="detailBtn genric-btn danger e-large" data-toggle="modal" data-target="#exampleModal"/></td></tr>';
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
            url : "http://10.10.17.117:5000/comlist",
//             url : "http://192.168.0.8:5000/comlist",
            type: "post",
            contentType : "application/json; charset=UTF-8",
            data: jsonData,
            success: function(data){
                data.splice(0,1);
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
        str += '<td><input type="button" value="선택" class="selectBtn genric-btn info e-large"/>';
        str += '<input type="hidden" class="type" value="'+item['type'] + '"/>';
        str += '<input type="hidden" class="company_num" value="'+item['company_num'] + '"/></td></tr>';
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
                            <p>업로드한 텍스트 파일과 기업정보의 유사도를 비교하여, 개인에게 맞는 기업 리스트를 추천합니다.
                               사용방법에 대한 자세한 매뉴얼 들어가야 함(아래쪽에 있는 div에)
                               전체 22612개의 기업 정보를 바탕으로 분석을 제공합니다.</p>            
                            <button class="genric-btn danger e-large" onclick="openUploadTextForm()">파일 업로드</button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="service-2-right">
                        <div class="get-know">
                            <p>아래의 텍스트를 바탕으로 기업정보와의 유사도를 비교하여, 
                                <br>선택한 순위만큼의 기업 종류를 추천합니다.
                                <br>분석 전 텍스트의 내용을 확인해주세요.
                            </p>
                            <select class="form-control" id="listnumSel">
                                <option value="10">10위까지</option>
                                <option value="20">20위까지</option>
                                <option value="30">30위까지</option>
                                <option value="126">전부</option>
                            </select>
                            <br>
                            <textarea rows="20" cols="74" id="revisedContent" style="resize: none;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body" style="padding-top: 85px;">
            <div  class="row justify-content-center">
                <a href="#" class="genric-btn danger e-large" id="startBtn" style="width: 300px; font-size: 15px;">시작하기</a>
                <table id="insightList" hidden="hidden"></table>
            </div>
        </div>
            <div class="container text-center" id="resultContainer" hidden="hidden">
               <div class="card-body" style="padding-top: 50px;" align="center">
                    <div class="col-md-7">
                        <h2 class="mb-30 title_color">분석결과 : 추천순위</h2>
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
<script src="${pageContext.request.contextPath}/resources/template_js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/template_js/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/template_js/bootstrap.min.js"></script>