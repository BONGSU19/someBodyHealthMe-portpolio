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
                        	alert("실패.");
                        }
                    },
                    error: function() {
                        alert("서버와의 통신 오류가 발생했습니다.");
                    }
                });
            });
        });
    </script>

      
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <jsp:include page="/WEB-INF/views/common/asideFriend.jsp"/>
    <div class="main-wrap">
        <table>
            <c:forEach var="friend" items="${list}">
                <tr>
                    <td>${friend.name}</td>
                    <td>${friend.email}</td>
                    <td>${friend.phone}</td>
                    <td>${friend.user_Num}</td>
                    <td>
     <form action="sendFriendRequest.do" method="post" class="sendFriendRequestForm">
    <input type="hidden" name="receiverNum" value="${friend.user_Num}">
    <button type="submit" class="sendFriendRequestButton">친구 요청</button>
    
    
    
</form>
                     <a href="javascript:void(0);" class="sendFriendRequestButton" data-receiver-num="${friend.user_Num}">
                            친구 요청
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
