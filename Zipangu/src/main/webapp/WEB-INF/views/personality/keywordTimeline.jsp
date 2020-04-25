<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../include/header.jsp"></jsp:include>

<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/timeline.css'/>">
<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/datedropper.css'/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script> 
<script src="<c:url value='/resources/js/datedropper.pro.min.js '/>"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>

<script type="text/javascript">

var personalityCount;
$(function() {
	$.ajax({
		type:"post",
		url:"makeChart",
		success: function(data){
			personalityCount = data;
			if(personalityCount.length==0) {
				$('#resultDiv').attr('hidden','hidden');
				$('#resultDivIfnoResult').removeAttr('hidden','hidden');
				return;
			}
		},error: function(request,status,error){
			console.log("실패");
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})	
	  'use strict';

	  var items = document.querySelectorAll(".timeline li");

	  function isElementInViewport(el) {
	    var rect = el.getBoundingClientRect();
	    return (
	      rect.top >= 0 &&
	      rect.left >= 0 &&
	      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
	      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
	    );
	  }

	  function callbackFunc() {
	    for (var i = 0; i < items.length; i++) {
	      if (isElementInViewport(items[i])) {
	        items[i].classList.add("in-view");
	      }
	    }
	  }

	  window.addEventListener("load", callbackFunc);
	  window.addEventListener("resize", callbackFunc);
	  window.addEventListener("scroll", callbackFunc);


	  $("#searchItem").change(function(){
		  var searchVal = $(this).val();
		  console.log(searchVal);
		  if(searchVal =="byKeyword") {
			  $('#searchKeyword').val("");
			  $('#searchKeyword').dateDropper('destroy');
			  console.log("aaaa");
		  } else if(searchVal =="byDate") {
			  $('#searchKeyword').val("");
			  $('#searchKeyword').dateDropper();
	    }
	  })

});

function deleteConfirm() {
	return confirm("삭제 하시겠습니까?");
}

//검색

</script>

<c:if test="${requestScope.timelineWriteResult==true}"><script>alert("등록 완료")</script></c:if>
<c:if test="${requestScope.timelineWriteResult==false}"><script>alert("등록 실패")</script></c:if>

<c:if test="${requestScope.timelineUpdateResult==true}"><script>alert("수정 완료")</script></c:if>
<c:if test="${requestScope.timelineUpdateResult==false}"><script>alert("수정 실패")</script></c:if>

<c:if test="${requestScope.timelineDeleteResult==true}"><script>alert("삭제 완료")</script></c:if>
<c:if test="${requestScope.timelineDeleteResult==false}"><script>alert("삭제 실패")</script></c:if>

</head>
<body>
				
<div class="row justify-content-center align-items-center" id="resultDivIfnoResult" hidden="hidden">
	<div class="container-fluid">
	<br>
	    <div class="row justify-content-center align-items-center">
	        <div class="card-body" align="center">
	            <h1>타임 라인 작성</h1>
	            <hr>
	            <p>성향분석을 통해 찾은 키워드로 타임라인을 작성합니다.</p>
	        </div>
	    </div>
	<br>
	</div>
	<div class="jumbotron" align="center">
		<div class="card-body col-md-9">
			<h2>등록된 성향분석이 없습니다.</h2>
			<hr>
		</div>
		<div class="row justify-content-center align-items-center">
			<p>먼저 성향분석을 진행해주세요.</p>
		</div>
		<a href="<c:url value="/personality/personalityInsight"/>" class="genric-btn danger e-large" style="width: 300px; font-size: 15px;">성향분석 페이지로 이동</a>
	</div>
</div>
<div id="resultDiv">
	<section class="banner_area ">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <div class="page_link">
                        <a href="<c:url value="/"/>">메인페이지
                        </a>
                        <a href="<c:url value="/personality/keywordTimeline"/>">성향키워드 타임라인</a>
                    </div>
                </div>
                <div class="banner_content text-center">
                    <h2>타임라인</h2>
                </div>
            </div>
        </div>
    </section>
    <section class="section_gap team-area" style="padding-bottom: 0px">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-7">
					<p style="color: #f13d80">
						타임라인
					</p>
					<div class="main_title">
						<h2>
							성향분석으로 얻은 키워드를 활용하여 타임라인 작성이 가능합니다!
						</h2>
						자기소개서에 쓸 다양한 에피소드들. 어떻게 정리해야 할지 고민이신가요?
						<br>성향분석을 통해 얻은 키워드로 에피소드를 분류하여 시간순으로 정리해보세요!
						<div id="timeline_ex" class="modal" style="height: auto; width: auto; padding: 50px; color: black;">
							<br>
							<p align="center">
								*예시*
							</p>
							<br>
							<img alt="타임라인예시" src="<c:url value='/resources/img/timelineExample.png'/>" width="100%" height="100%">
							<br><br>
							<p>
								1. 키워드로 검색이 가능합니다.
								<br>2. 날짜 검색시 해당 날짜에 한 활동들이 검색됩니다.
							</p>	
							<br><br>
							<p align="center">
								<a href="#" rel="modal:close">
									<button class="genric-btn danger e-large">
										닫기
									</button>
								</a>
							</p>
						</div>
						<p>
							<a href="#timeline_ex" rel="modal:open">
								*예시 및 작성방법*
							</a>
						</p>	
					</div>
				</div>
			</div>
		</div>
	</section>		
	<section class="timeline">
	<!-- 검색 기능 -->
		<div align="center">
			<form action="keywordTimeline" method="get">
				<div class="col-md-9">
            		<div class="row justify-content-center align-items-center">
	            		<div class="blog_right_sidebar" style="border: none; padding-right: 10px;">
	            			<select name="searchItem" id="searchItem" class="form-control">
								<option value="byKeyword">키워드</option>
								<option value="byDate">날짜</option>
							</select>
	            		</div>
                  		<div class="blog_right_sidebar" style="border: none; width: 40%; padding-left: 10px;">
                        	<aside class="single_sidebar_widget search_widget">
                        		<div class="input-group">
                                	<input type="text" class="form-control" name="searchKeyword" id="searchKeyword" data-dd-format="Y/m/d" placeholder="Search" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search'">
                               			<span class="input-group-btn">
                                    		<button class="btn btn-default" type="submit"><i class="lnr lnr-magnifier"></i></button>
                            			</span>
                        		</div>
                    		</aside>
            			</div>
            		</div>
        		</div>
			</form>
		</div>	
		<section class="service-area-2 section_gap" style="padding-top: 0px; padding-bottom: 0px">
		<div class="container">
			<div class="card-body" align="center" style="font-size: 120%;">
				<a href="<c:url value='/personality/timelineWriteForm'/>" style="color: black;"> 
					<button class="genric-btn danger e-large">
						에피소드 작성하기 <img src="<c:url value="/resources/img/write.png"/>" alt="글쓰기" width="35" height="35" align="middle">
					</button>
				</a>
			</div>
		</div>
		</section>
		<ul style="color: black;">
			<c:forEach items="${requestScope.timelineList}" var="TimelineVO">
		  		<li>
			    	<div style="background-color: white; border : pink; border-width : 1px; border-style : dashed; margin-bottom: 0px" >
			        <p align="right">
			        	<a href="<c:url value='/personality/timelineUpdateForm?timeline_Num=${TimelineVO.timeline_Num}'/>">
			      	    	<img src="<c:url value="/resources/img/fix.png"/>" alt="수정" width="35" height="35" align="right" >
			      		</a>
			      	</p>
			      	<table style="word-break:break-all;">
			      		<tr>
			      			<td>
		                  		<time>
				            		<fmt:parseDate value="${TimelineVO.start_Date}" var="dateFmt" pattern="yyyy-MM-dd"/>
				            		<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>
				            		~
				            		<fmt:parseDate value="${TimelineVO.finish_Date}" var="dateFmt" pattern="yyyy-MM-dd"/>
				            		<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>
				        		</time>
				      		</td>
				      	</tr> 
				      	<tr>
				        	<td>내가 고른 키워드 : ${TimelineVO.traits_Selected}</td>
				      	</tr>
				      	<tr>
				       		<td>제목 : ${TimelineVO.episode_Title}</td>
				      	</tr>
					    <tr>
					        <td>내용 : ${TimelineVO.episode_Content}</td>
					      </tr>
				    </table>
				    <p align="right" style="margin-bottom: 0px">
				      <a href="<c:url value='/personality/timelineDelete?timeline_Num=${TimelineVO.timeline_Num}'/>" onclick="return deleteConfirm()">
			      	    <img src="<c:url value="/resources/img/delete.png"/>" alt="삭제" width="35" height="35" align="right" >
			      	  </a>
			      	  <br><br>
					</p>
				</div>
			</li>   
		</c:forEach>
	</ul>
</section>
</div>
<jsp:include page="../include/footer.jsp"></jsp:include>
	