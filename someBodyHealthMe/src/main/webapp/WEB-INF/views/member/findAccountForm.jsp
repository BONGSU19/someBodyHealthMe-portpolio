<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/findaccountForm.css" type="text/css">
</head>
<body>
    <div class="page-main">
        <div class="content-main">
            <h2>아이디 찾기</h2>
            <form id="account_find_form" action="findAccount.do" method="post">
                <ul>
                    <li>
                        <label for="name">이름</label>
                        <input type="text" name="name" id="name" required>
                    </li>
                    <li>
                        <label for="email">이메일</label>
                        <input type="email" name="email" id="email" required>
                    </li>
                </ul>
                <div class="align-center">
                    <input type="submit" value="아이디 찾기">
                </div>
                <div class="align-center">
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">회원가입</button>
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/loginForm.do'">로그인</button>
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/findPasswordForm.do'">비밀번호 찾기</button>
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">홈으로</button>
                </div>
                <% if (request.getAttribute("foundAccount") != null) { %>
                    <div class="found-message">찾으신 아이디는 <strong><%= request.getAttribute("foundAccount") %></strong> 입니다.</div>
                <% } else if (request.getAttribute("errorMessage") != null) { %>
                    <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
                <% } %>
            </form>
        </div>
    </div>
</body>
</html>