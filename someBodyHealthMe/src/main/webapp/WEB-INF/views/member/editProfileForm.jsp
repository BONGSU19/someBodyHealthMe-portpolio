<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css">
<script>
    function validateForm() {
        const nickname = document.querySelector('[name="nick_name"]').value.trim();
        const email = document.querySelector('[name="email"]').value.trim();
        const phone = document.querySelector('[name="phone"]').value.trim();

        if (!nickname && !email && !phone) {
            alert('적어도 하나의 정보를 입력해야 수정 가능합니다.');
            return false;
        }
        return true;
    }
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/mypageheader.jsp"/>
<h2>회원정보 수정</h2>
<form action="${pageContext.request.contextPath}/member/updateProfile.do" method="post" onsubmit="return validateForm();">
    <label for="nick_name">닉네임</label>
    <input type="text" id="nick_name" name="nick_name" value="${member.nick_name}"><br>

    <label for="email">이메일</label>
    <input type="email" id="email" name="email" value="${member.email}"><br>

    <label for="phone">전화번호</label>
    <input type="text" id="phone" name="phone" value="${member.phone}"><br>

    <label for="birth_date">생년월일</label>
    <input type="text" id="birth_date" name="birth_date" value="${member.birth_date}"><br>

    <button type="submit">수정</button>
    <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">취소</button>
</form>
</body>
</html>