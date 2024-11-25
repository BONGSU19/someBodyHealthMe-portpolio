<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/MS.css" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
	
	<script type="text/javascript">
	 $(document).ready(function() {
	     $('.sulag').click(function() {
	         const receiverNum = $(this).data('receiver-num'); // 버튼에서 receiverNum 값 가져오기

	         // AJAX 요청 보내기
	         $.ajax({
	             type: 'POST',
	             url: 'sulag.do', 
	             dataType:'json',// 서버에서 요청을 처리할 URL
	             data: { receiverNum: receiverNum },  // 보내는 데이터
	             success: function(response) {
	                 // 서버에서 보내는 응답 처리
	                 if (response.isRequestSent=='success') {
	                     alert("친구다 되었습니다 대화를 해보세요!");
	                 } else if(response.isRequestSent=='fail'){
	                     alert("실패");
	                 }else{
	                 	alert("실패.!ns");
	                 }
	             },
	             error: function() {
	                 alert("서버와의 통신 오류가 발생했습니다.");
	             }
	         });
	     });
	 });
	 
	 function refreshPage() {
	     location.reload(); // 페이지 새로고침
	 }
	
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/asideFriend.jsp" />
	
	
	<div class="main-wrap">
		<div class="all2">
			
			<p>친구 요청한 친구 리스트</p>

		
		</div>
		<div style="clear: both;"></div>
		<form id="search_form" action="friendList.do" method="get">
			<ul class="search">
				<li><select name="keyfield" class="sel">
						<option value="1"
							<c:if test="${param.keyfield==1}">selected</c:if>>이름</option>
						<option value="2"
							<c:if test="${param.keyfield==2}">selected</c:if>>닉네임</option>
						
							
				</select></li>
				<li><input type="search" size="16" name="keyword" id="keyword"
					value="${param.keyword}"></li>
				<li><input type="submit" value="찾기"
					style="width: 300px; border: 1px solid black;"></li>
			</ul>
		</form>

		<div class="list-space align-right">
			<input type="button" value="목록"
				onclick="location.href='friendList.do'" style="width: 150px;">
			<input type="button" value="홈으로" style="width: 150px;"
				onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>

		<table class="friend">

			<tr>
				<th>이름</th>
				<th>닉네임</th>
				<th>번호</th>

			</tr>
			<c:forEach var="friend" items="${list}">
				<tr>
					<td>${friend.name}</td>
					<td>${friend.nick_name}</td>
				
					<c:if test="${friend.status=='1'}">
						<td><a href="javascript:void(0);"
							class="sulag"
							data-receiver-num="${friend.user_Num}" onclick="refreshPage()">
								친구 수락 </a></td>
								${friend.user_Num}${friend.receiver_num}
					</c:if>


					<c:if test="${friend.status=='2'}">
						이미 친구
					</c:if>

				</tr>
			</c:forEach>
		</table>
	</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>