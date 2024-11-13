<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>건강지킴이</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
</head>
<body>
    <div class="page-main">
        <!-- Header 영역 (기존 include) -->
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
        
        <!-- Aside 영역 (기존 include) -->
        <jsp:include page="/WEB-INF/views/common/aside_mybody.jsp"/>

        <!-- Main Content 영역 추가 -->
        <div class="main-content">

        </div>
    </div>
</body>
</html>
