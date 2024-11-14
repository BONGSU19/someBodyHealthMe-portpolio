<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginForm.css" type="text/css">
</head>
<body>  
    <div class="page-main">
        <div class="content-main">
            <h2>로그인</h2>
            <form id="login_form" action="login.do" method="post">
                <ul>
                    <li>
                        <label for="login_id">아이디</label>
                        <input type="text" name="login_id" id="login_id" maxlength="30" required>
                    </li>
                    <li>
                        <label for="password">비밀번호</label>
                        <input type="password" name="password" id="password" maxlength="50" required>
                    </li>
                </ul>
                <div class="align-center">
                    <input type="submit" value="로그인">
                    <input type="button" value="회원가입" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">
                </div>
                <div class="align-center">
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/findAccountForm.do'">계정 찾기</button>
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/findPasswordForm.do'">비밀번호 초기화</button>
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">홈으로</button>
                </div>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
                <% } %>
            </form>
        </div>
    </div>
</body>
</html>