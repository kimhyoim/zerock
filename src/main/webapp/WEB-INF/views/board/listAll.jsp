<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../include/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var result = '${msg}';
	
	if(result == 'success') {
		alert("처리가 완료되었습니다.");
	}
</script>
</head>
<body>

	<div class="box">
		<div class="box-header with border">
			<h3 class="box-title">List All Page</h3>
		</div>
		<div class="box-body">
			<table class="table table-bordered">
				<tr>
					<th style="width:10px">BNO</th>
					<th>Title</th>
					<th>Content</th>
					<th>Writer</th>
					<th>Regdate</th>
					<th style="width:40px">Viewcnt</th>
				</tr>
				<c:forEach items="${list }" var="boardVO">
				<tr>
					<td>${boardVO.bno }</td>
					<td><a href='/board/read?bno=${boardVO.bno }'>${boardVO.title }</a></td>
					<td>${boardVO.writer }</td>
<%-- 					<td>${boardVO.regdate }</td> --%>
					<td>
					<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }"/></td>
					<td><span class="badge bg-red">${boardVO.viewcnt }</span></td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<!-- /.box-body -->
		<div class="box-footer">Footer</div>
		<!-- /.box-footer -->
	</div>



</body>
</html>

<%@ include file="../include/footer.jsp" %>
