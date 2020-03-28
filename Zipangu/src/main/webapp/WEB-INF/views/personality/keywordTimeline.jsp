<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/timeline.css'/>">
<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/datedropper.css'/>">

<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script> 
<script src="<c:url value='/resources/js/datedropper.pro.min.js '/>"></script> 

<script type="text/javascript">

$(function() {

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

<section class="intro">
  <div class="container">
    <h1>타임라인  &darr;</h1>
    <h3><a href="<c:url value="/"/>">메인으로 돌아가기</a></h3> 
  </div>
</section>


<section class="timeline">

    <!-- 검색 기능 -->
	  <form action="keywordTimeline" method="get">
	  <p align="center">
	  <select name="searchItem" id="searchItem">
	    <option value="byKeyword">키워드</option>
	  	<option value="byDate">날짜</option>
	  </select>
	 	
	   <input type="text" name="searchKeyword" id="searchKeyword" data-dd-format="Y/m/d">
	   <input type="submit" value="검색">
	   </p>
	   </form>

  	
  	
  <h2 align="right">
	<a href="<c:url value='/personality/timelineWriteForm'/>">
		<input type="button" value="글쓰기">
	</a>
  </h2>
  <ul>
  	<c:forEach items="${requestScope.timelineList}" var="TimelineVO">
  	    <li>
	      <div>
	        <p align="right">
	          <a href="<c:url value='/personality/timelineUpdateForm?timeline_Num=${TimelineVO.timeline_Num}'/>">
	      	    <img src="<c:url value="/resources/img/write.png"/>" alt="수정" width="35" height="35" align="right" >
	      	  </a>
	      	</p>
	      	<table>
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
		    <p align="right">
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

</body>
</html>