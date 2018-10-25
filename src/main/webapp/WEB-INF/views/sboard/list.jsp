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

<script>

$(document).ready(
		function() {
			$('#searchBtn').on(
					"click",
					function(event) {
						
						self.location = "list"
						+ '${pageMaker.makeQuery(1)}'
						+ "&searchType="
						+ $("select option:selected").val()
						+ "&keyword="+encodeURIComponent($('#keywordInput').val());
					});
			
			$('#newBtn').on("click", function(evt) {
				self.location = "register";
			});

		});
</script>

<div class="box-body">

	<select name="searchType">
		<option value="n"
			<c:out value="${cri.searchType==null?'selected':'' }"/>>
		---</option>
		<option value="t"
			<c:out value="${cri.searchType eq 't'?'selected':'' }"/>>
		Title</option>
		<option value="c"
			<c:out value="${cri.searchType eq 'c'?'selected':'' }"/>>
		Content</option>
		<option value="w"
			<c:out value="${cri.searchType eq 'w'?'selected':'' }"/>>
		Writer</option>
		<option value="tc"
			<c:out value="${cri.searchType eq 'tc'?'selected':'' }"/>>
		Title or Content</option>
		<option value="cw"
			<c:out value="${cri.searchType eq 'cw'?'selected':'' }"/>>
		Content or Writer</option>
		<option value="tcw"
			<c:out value="${cri.searchType eq 'tcw'?'selected':'' }"/>>
		Title or Content or Writer</option>
	</select>

	<input type="text" name="keyword" id="keywordInput" value="${cri.keyword }">
	<button id="searchBtn">Search</button>
	<button id="newBtn">New Board</button>
	
</div>

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
					<td><a href='/sboard/readPage${pageMaker.makeQuery(pageMaker.cri.page)
					}&bno=${boardVO.bno}'>${boardVO.title }<strong>[ ${boardVO.replycnt} ]</strong></a></td>
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
	
<div class="text-center">
	<ul class="pagination">
		<c:if test="${pageMaker.prev }">
			<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">&laquo;</a></li>
		</c:if>
		
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			<li
				<c:out value="${pageMaker.cri.page == idx ? 'class =active' : '' }"/>
			>
				<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
			</li>
		</c:forEach>
		
		<c:if test="${pageMaker.next && pageMaker.endPage>0 }">
			<li>
				<a href="list${pageMaker.makeSearch(pageMaker.endPage+1)}">&raquo;</a>
			</li>
		</c:if>
	</ul>
</div>

</body>
</html>

<%@ include file="../include/footer.jsp" %>
