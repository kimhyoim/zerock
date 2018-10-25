<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="../include/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form[role='form']");
	
	console.log(formObj);
	
	$(".modifyBtn").on("click", function(){
		formObj.attr("action", "/sboard/modifyPage");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$(".removeBtn").on("click", function(){
		formObj.attr("action", "/sboard/removePage");
		formObj.submit();
	});
	
	$(".goListBtn").on("click", function(){
		formObj.attr("method", "get");
		formObj.attr("action", "/sboard/list");
		formObj.submit();
	});
	
});

</script>

<script>
var bno = ${boardVO.bno};
var replyPage = 1;

function getPage(pageInfo) {
	$.getJSON(pageInfo, function(data) {
		printData(data.list, $("#repliesDiv"), $("#template"));
		printPaging(data.pageMaker, $(".pagination"));
		
		$("#modifyModal").modal('hide');
		$("#replycntSmall").html("[ "+data.pageMaker.totalCount+" ]");
	});
}

var printPaging = function(pageMaker, target) {
	var str = "";
	
	if(pageMaker.prev) {
		str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
	}
	for(var i=pageMaker.startPage, len=pageMaker.endPage; i<=len; i++) {
		var strClass = pageMaker.cri.page == i?'class=active' : '';
		str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
	}
	if(pageMaker.next) {
		str += "<li><a href='"+(pageMaker.endPage+1)+"'> >> </a></li>";
	}
	
	target.html(str);
}

</script>

<title>Insert title here</title>

<style type="text/css">
.popup{position:absolute;}
.back{background-color:gray; opacity:0.5; width:100%; height:300%; overflow:hidden; z-index:1101;}
.front{
	z-index:1110; opacity:1; boarder:1px; margin:auto;
}
.show{
	position:relative;
	max-width:1200px;
	max-height:800px;
	overflow:auto;
}
</style>
</head>
<body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/resources/js/upload.js"></script>

<form role="form" action="modifyPage" method="post">
	<input type="hidden" name="bno" value="${boardVO.bno }">
	<input type="hidden" name="page" value="${cri.page }">
	<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
	<input type="hidden" name="searchType" value="${cri.searchType }">
	<input type="hidden" name="keyword" value="${cri.keyword }">
</form>

	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label>
			<input type="text" name="title" class="form-control" value="${boardVO.title}" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Content</label>
			<textarea class="form-control" name="content" rows="3" readonly="readonly">${boardVO.content}</textarea>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Writer</label>
			<input type="text" name="writer" class="form-control" value="${boardVO.writer}" readonly="readonly">
		</div>
	</div>
	
	<ul class="mailbox-attachments clearfix uploadedList"></ul>
	
	<div class="popup back" style="display:none;"></div>
	<div id="popup_front" class="popup front" style="display:none;">
		<img id="popup_img">
	</div>
	
	<!-- /.box body -->
	<div class="box-footer">
		<button type="submit" class="btn btn-warning modifyBtn">Modify</button>
		<button type="submit" class="btn btn-danger removeBtn">Remove</button>
		<button type="submit" class="btn btn-primary goListBtn">Go List</button>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">Add New Reply</h3>
				</div>
				<div class="box-body">
					<label for="newReplyWriter">Writer</label>
					<input class="form-control" type="text" placeholder="User ID" id="newReplyWriter">
					<label for="newReplyText">ReplyText</label>
					<input class="form-control" type="text" placeholder="Reply Text" id="newReplyText">
				</div>
				<!-- /.box-body -->
				<div class="box-footer">
					<button type="submit" class="btn btn-primary" id="replyAddBtn">Add Reply</button>
				</div>
			</div>
		</div>
	</div>

	<!-- The time line -->
	<ul class="timeline">
		<!-- timeline time label -->
		<li class="time-label" id="repliesDiv">
			<span class="bg-green">Replies List
				<small id="replycntSmall">[ ${boardVO.replycnt } ]</small>
			</span>
		</li>
	</ul>
	
	<div class="text-center">
		<ul id="pagination" class="pagination pagination-sm no-margin">
		
		</ul>
	</div>
	
	<!-- Modal -->
	<div id="modifyModal" class="modal modal-primary fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content -->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body" data-rno>
					<p><input type="text" id="replytext" class="form-control"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">Delete</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

<script id="templateAttach" type="text/x-handlebars-template">
<li data-src='{{fullName}}'>
	<span class="mailbox-attachment-icon has-img">
		<img src="{{imgsrc}}" alt="Attachment">
	</span>
	<div class="mailbox-attachment-info>
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</span>
	</div>
</li>
</script>

<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rno}}>
<i class="fa fa-comments bg-blue"></i>
	<div class="timeline-item">
		<span class="time">
			<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
		</span>
		<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
		<div class="timeline-body">{{replytext}}</div>
		<div class="timeline-footer">
			<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
		</div>
	</div>
</li>
{{/each}}
</script>

<script>
Handlebars.registerHelper("prettifyDate", function(timeValue) {
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth()+1;
	var date = dateObj.getDate();
	return year+"/"+month+"/"+date;
});

var printData = function(replyArr, target, templateObject) {
	var template = Handlebars.compile(templateObject.html());
	
	var html = template(replyArr);
	$(".replyLi").remove();
	target.after(html);
}
</script>

<script>
$("#repliesDiv").on("click", function() {
	if($(".timeline li").size()>1) {
		return;
	}
	getPage("/replies/"+bno+"/1");
});

$(".pagination").on("click", "li a", function(event) {
	event.preventDefault();
	replyPage = $(this).attr("href");
	getPage("/replies/"+bno+"/"+replyPage);
});

$("#replyAddBtn").on("click", function() {
	var replyerObj = $("#newReplyWriter");
	var replytextObj = $("#newReplyText");
	var replyer = replyerObj.val();
	var replytext = replytextObj.val();
	
	$.ajax({
		type:'post',
		url:'/replies/',
		headers:{
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dateType:'text',
		data:JSON.stringify({bno:bno, replyer:replyer, replytext:replytext}),
		success:function(result) {
			console.log("result: "+result);
			if(result=='success') {
				alert("등록 되었습니다.");
				replyPage = 1;
				getPage("/replies/"+bno+"/"+replyPage);
				replyerObj.val("");
				replytextObj.val("");
			}
		}
	});
});

$(".timeline").on("click", ".replyLi", function(event) {
	var reply = $(this);
	
	$("#replytext").val(reply.find('.timeline-body').text());
	$(".modal-title").html(reply.attr("data-rno"));
});

//수정처리
$("#replyModBtn").on("click", function() {
	var rno = $(".modal-title").html();
	var replytext = $("#replytext").val();
	
	$.ajax({
		type:'put',
		url:'/replies/'+rno,
		headers:{
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		data:JSON.stringify({replytext:replytext}),
		dataType:'text',
		success:function(result) {
			console.log("result : "+result);
			if(result=="success") {
				alert("수정 되었습니다.");
				getPage("/replies/"+bno+"/"+replyPage);
			}
		}
	});
});

//삭제처리
$("#replyDelBtn").on("click", function() {
	var rno = $(".modal-title").html();
	var replytext = $("#replytext").val();
	
	$.ajax({
		type:'delete',
		url:'/replies/'+rno,
		headers:{
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "DELETE"
		},
		dataType:'text',
		success:function(result) {
			console.log("result : "+result);
			if(result=='success') {
				alert("삭제 되었습니다.");
				getPage("/replies/"+bno+"/"+replyPage);
			}
		}
	});
});

var bno = ${boardVO.bno};
var template = Handlebars.compile($("#templateAttach").html());

$.getJSON("/sboard/getAttach/"+bno, function(list) {
	$(list).each(function(){
		var fileInfo = getFileInfo(this);
		
		var html = template(fileInfo);
		
		$(".uploadedList").append(html);
	});
});

$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event) {
	var fileLink = $(this).attr("href");
	
	if(checkImageType(fileLink)) {
		event.preventDefault();
		
		var imgTag = $("#popup_img");
		imgTag.attr("src", fileLink);
		
		console.log(imgTag.attr("src"));
		
		$(".popup").show("slow");
		imgTag.addClass("show");
	}
});

$("#popup_img").on("click", function(){
	$(".popup").hide("slow");
});
</script>

</body>

</html>

<%@ include file="../include/footer.jsp" %>