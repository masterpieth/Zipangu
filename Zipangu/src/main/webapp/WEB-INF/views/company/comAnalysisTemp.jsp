<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script>
$(function(){
    $('#startBtn').on('click', function(){
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
                $('#resultContainer').removeAttr('hidden');
                comList(value);
            }, error : function(data){
                console.log(data);
            }
        })
    })
    
    function output(data_arr){
        var str = '';
        $.each(data_arr, function(index,item){
            str += '<tr><td style="text-align: center;">' + (index+1) + '</td>';
            str += '<td class="typename">' + item + '</td>';
            str += '<td><input type="button" value="詳細" class="detailBtn genric-btn danger e-large" data-toggle="modal" data-target="#exampleModal"/></td></tr>';
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
                type: "post",
                contentType : "application/json; charset=UTF-8",
                data: jsonData,
                success: function(data){
                    var data_arr = data;
                    var str = modalOutput(data_arr);
                    $('#modalTbody').html(str);
                    $('#myModal').modal('show');
                },
                error: function(){}
            })
        });
    }
    function modalOutput(data_arr){
        var str = '';
        $.each(data_arr, function(index,item){
            str += '<tr><td>' + (index+1) + '</td>';
            str += '<td>' + item['coname'] + '</td>';
            str += '<td>' + item['location'] + '</td>';
            str += '<td>' + item['contact'] + '</td>';
            str += '<td><input type="button" value="選択" class="selectBtn genric-btn info e-large"/></td></tr>';
        });
        return str;
    }
})
</script>
    <!--================Home Banner Area =================-->
    <section class="banner_area">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <div class="page_link">
                        <a href="<c:url value="/"/>">ホーム
                        </a>
                        <a href="<c:url value="/analysis/company"/>">企業分析</a>
                    </div>
                    <h2>企業分析</h2>
                    <br>
                    <p style="color: white;"></p>
                </div>
            </div>
        </div>
    </section>
    <!--================End Home Banner Area =================-->
     <!--================ Start Blog Area =================-->
    <section class="section_gap">
        <div class="container-fluid">
	        <div class="row justify-content-center">
	            <div class="col-lg-7">
	                <div class="main_title">
	                    <h2>カスタマイズ型企業おすすめサービス</h2>
	                    <hr>
	                    <p>アップロードされたテキストと企業情報との類似度を分析し、個人に合わせた企業リストをおすすめします。
	                    사용방법에 대한 자세한 매뉴얼 들어가야 함
	                    전체 22612개의 기업 정보를 바탕으로 분석을 제공합니다.
	                    </p>
	                </div>
	            </div>
	        </div>
	        <div class="container" id="inputContainer">
	             <ul class="nav nav-tabs">
	                <li class="nav-item">
	                    <a class="nav-link active" data-toggle="tab" href="#qwe">テキストアップロード</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" data-toggle="tab" href="#asd">直接入力</a>
	                </li>
	            </ul>
	                <div class="tab-content">
	                   <br>
	                   <div class="col-lg-12">
		                   <select class="form-control" id="listnumSel">
	                            <option value="10">10位まで</option>
	                            <option value="20">20位まで</option>
	                            <option value="30">30位まで</option>
	                            <option value="126">すべて</option>
	                        </select>
	                   </div>
	                    <div class="tab-pane fade show active" id="qwe">
	                       <div class="section-top-border">
	                               <div class="col-lg-12">
                                       <form>
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input form-control-file" id="customFile">
                                                <label class="custom-file-label" for="customFile">ファイル選択</label>
                                            </div>
                                        </form>
	                               </div>
	                       </div>
	                   </div>
	                    <div class="tab-pane fade" id="asd">
	                        <div class="section-top-border">
	                           <div class="col-lg-12">
	                               <textarea rows="10" cols="100%" class="form-control single-textarea" id="inputText" placeholder="ここにテキストを入力してください。"></textarea>
	                           </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="row justify-content-center">
                        <a href="#" class="genric-btn danger e-large" id="startBtn" style="width: 300px; font-size: 20px;">始める</a>
                    </div>
	        </div>
	        <div class="container" id="resultContainer" hidden="hidden">
	           <div class="section-gap" style="padding-top: 50px;">
                    <h3 class="mb-30 title_color">分析結果: 推薦順位</h3>
                    <p>사용자와 가장 유사한 업종을 순위별로 표시하였습니다. 해당 업종의 기업명 순위를 조회하려면 상세 버튼을 눌러주세요.
                    </p>
                    <hr>
                    <table class="table table-bordered table-hover">
                        <thead>
                        
                        
	                       <tr>
	                           <th style="width: 10%; text-align: center;">順位</th>
	                           <th style="text-align: center;">職種</th>
	                           <th style="width: 10%; text-align: center;">詳細順位</th>
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
                            <h5 class="modal-title" id="myModalLabel">職種：詳細順位</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th style="width: 5%;">順位</th>
                                        <th style="width: 20%;">会社名</th>
                                        <th style="width: 5%;">地域</th>
                                        <th style="width: 30%;">連絡先</th>
                                        <th style="width: 10%;">気に入り</th>
                                    </tr>
                                </thead>
                                <tbody id="modalTbody">
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="genric-btn danger e-large" data-dismiss="modal">閉じる</button>
                        </div>
                    </div>
                </div>
            </div>
	   </div>
    </section>
    <!--================ End Blog Area =================-->
<jsp:include page="../include/footer.jsp"></jsp:include>