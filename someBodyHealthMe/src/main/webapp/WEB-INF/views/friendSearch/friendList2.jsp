<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MS.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
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
                            alert("중복");
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
                     alert("중복");
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
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <jsp:include page="/WEB-INF/views/common/asideFriend.jsp"/>
    <div class="main-wrap">
		<a href="${pageContext.request.contextPath}/friendSearch/friendList.do">전체 보기</a>
		<a href="${pageContext.request.contextPath}/friendSearch/friendList2.do?center_num=1">지점으로 보기</a>
		
		
		
		
		<p>
		
		<a href="${pageContext.request.contextPath}/friendSearch/friendList2.do?center_num=1"  id="center1" class="link">강남지점 회원 목록</a>
		<a href="${pageContext.request.contextPath}/friendSearch/friendList2.do?center_num=2" id="center2" class="link">강북지점 회원 목록</a>
		
		
    	<form id="search_form" action="friendList.do"
		                                    method="get">
			<ul class="search">
				<li>
					<select name="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>아이디</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>닉네임</option>
						<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>소개</option>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword"
					       id="keyword" value="${param.keyword}">
				</li>
				<li>
					<input type="submit" value="찾기">
				</li>
			</ul>                                    
		</form>
    
    	<div class="list-space align-right">
			<input type="button" value="목록"
			       onclick="location.href='friendList.do'">
			<input type="button" value="홈으로"
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
						<td><a href="javascript:void(0);"
							class="sendFriendRequestButton"
							data-receiver-num="${friend.user_Num}" onclick="refreshPage()">
								친구 요청 </a></td>
					</c:if>


					<c:if test="${friend.status=='1'}">
						<td><a href="javascript:void(0);"
							class="sendFriendRequestButton2"
							data-receiver-num="${friend.user_Num}" onclick="refreshPage()">
								친구 요청 취소 </a></td>
					</c:if>

				</tr>
			</c:forEach>
		</table>
    </div>
    
    <script>
  window.onload = function() {
    // 현재 URL의 쿼리 파라미터(center_num)를 추출
    const urlParams = new URLSearchParams(window.location.search);
    const centerNum = urlParams.get('center_num'); // '1' 또는 '2' 등의 값이 들어옴

    // 모든 링크에서 'active' 클래스를 제거
    const links = document.querySelectorAll('.link');
    links.forEach(link => {
      link.style.color = '';  // 원래 색상으로 되돌리기
    });

    // 현재 선택된 링크에만 색상을 변경
    if (centerNum === '1') {
      document.getElementById('center1').style.color = 'red'; // 강남지점
    } else if (centerNum === '2') {
      document.getElementById('center2').style.color = 'red'; // 강북지점
    }
  };
</script>
</body>
</html>
