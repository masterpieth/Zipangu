<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- form enctype="multipart/form-data"를 적어줘야 한다. -->
	<form method="post" action="<c:url value='/regFile'/>" enctype="multipart/form-data">
	    <!-- input type="file" 이라고 꼭 저어줘야 함 -->
	    <input type="file" class="form-control" id="uploadFile"          
	    name="uploadFile" />
	    <button type="submit" class="btn btn-default">저장</button>
	    <button type="list" class="btn btn-default">목록</button>
	</form>

</body>
</html>