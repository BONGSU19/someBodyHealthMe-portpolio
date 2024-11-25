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
<script>
 $(document).ready(function() {
            $('.sendFriendRequestButton').click(function() {
                const receiverNum = $(this).data('receiver-num'); // 버튼에서 receiverNum 값 가져오기

                // AJAX 요청 보내기
                $.ajax({
                    type: 'POST',
                    url: 'sendFriendRequest.do', 
                    dataType:'json',// 서버에서 요청을 처리할 URL
                    data: { receiverNum: receiverNum },  // 보내는 데이터
                    success: function(response) {
                        // 서버에서 보내는 응답 처리
                        if (response.isRequestSent=='success') {
                            alert("친구 요청이 성공적으로 전송되었습니다!");
                        } else if(response.isRequestSent=='duple'){
                            alert("이미 친구입니다");
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
 
 $(document).ready(function() {
     $('.sendFriendRequestButton2').click(function() {
         const receiverNum = $(this).data('receiver-num'); // 버튼에서 receiverNum 값 가져오기

         // AJAX 요청 보내기
         $.ajax({
             type: 'POST',
             url: 'sendFriendRequest2.do', 
             dataType:'json',// 서버에서 요청을 처리할 URL
             data: { receiverNum: receiverNum },  // 보내는 데이터
             success: function(response) {
                 // 서버에서 보내는 응답 처리
                 if (response.isRequestSent=='success') {
                     alert("친구 요청 취소가 완료되었습니다!");
                 } else if(response.isRequestSent=='duple'){
                     alert("이미 친구 입니다");
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
			<div class="all1">
				<a
					href="${pageContext.request.contextPath}/friendSearch/friendList.do">전체
					보기</a>
			</div>
			<div class="all1">
				<a
					href="${pageContext.request.contextPath}/friendSearch/friendList2.do?center_num=1">지점으로
					보기</a>
			</div>
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
					<c:if test="${friend.center_Num=='1'}">
						<td>강남점</td>
					</c:if>


					<c:if test="${friend.center_Num=='2'}">
						<td>강북점</td>
					</c:if>

					<c:if test="${friend.status=='None'}">
						<td style="padding-left:250px;"><a href="javascript:void(0);"
							class="sendFriendRequestButton"
							data-receiver-num="${friend.user_Num}" onclick="refreshPage()">
								친구 요청 </a></td>
					</c:if>


					<c:if test="${friend.status=='1'}">
						<td  style="padding-left:250px;"><a href="javascript:void(0);"
							class="sendFriendRequestButton2"
							data-receiver-num="${friend.user_Num}" onclick="refreshPage()">
								친구 요청 취소 </a></td>
					</c:if>
					
					<c:if test="${friend.status=='2'}">
						<td  style="padding-left:250px;"><a href="javascript:void(0);"
							class="sendFriendRequestButton2"
							data-receiver-num="${friend.user_Num}" onclick="refreshPage()">
								친구입니다! </a></td>
					</c:if>

				</tr>
			</c:forEach>
		</table>
	</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
