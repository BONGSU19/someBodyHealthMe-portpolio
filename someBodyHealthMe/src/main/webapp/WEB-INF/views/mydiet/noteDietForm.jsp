<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>음식 검색</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style type="text/css">
	/* 기본 레이아웃 설정 */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

.page-main {
    display: flex;
    justify-content: space-between;
    padding: 20px;
}

.search-form {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 600px;
    margin-bottom: 30px;
}

.search-form h2 {
    font-size: 24px;
    margin-bottom: 10px;
}

.search-form input {
    width: calc(100% - 110px);
    padding: 10px;
    font-size: 16px;
    border-radius: 4px;
    border: 1px solid #ddd;
    margin-right: 10px;
}

.search-form button {
    padding: 10px 15px;
    font-size: 16px;
    border-radius: 4px;
    border: 1px solid #ddd;
    background-color: #28a745;
    color: #fff;
    cursor: pointer;
    transition: background-color 0.3s;
}

.search-form button:hover {
    background-color: #218838;
}

.search-results {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 800px;
}

.search-results h2 {
    font-size: 22px;
    margin-bottom: 20px;
}

.search-results ul {
    list-style-type: none;
    padding: 0;
}

.search-results li {
    padding: 10px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    margin-bottom: 10px;
    border-radius: 4px;
}

.search-results .pagination {
    margin-top: 20px;
    text-align: center;
}

.search-results .pagination span {
    display: inline-block;
    padding: 8px 16px;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    cursor: pointer;
    margin: 0 5px;
}

.search-results .pagination span:hover {
    background-color: #0056b3;
}

/* Aside 스타일 */
aside {
    width: 30%;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

footer {
    text-align: center;
    background-color: #333;
    color: #fff;
    padding: 20px;
    margin-top: 30px;
}
	
</style>
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="page-main">
        <!-- Aside Include -->
        <jsp:include page="/WEB-INF/views/common/aside_mybody.jsp" />
        
        <!-- 음식 검색 폼 -->
        <div class="search-form">
            <h2>음식 검색</h2>
            <form action="${pageContext.request.contextPath}/mydiet/noteDietSearch.do" method="get">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요" />
                <button type="submit">검색</button>
            </form>
        </div>

        <!-- 검색 결과 -->
        <div class="search-results">
            <h2>검색 결과</h2>

            <c:if test="${not empty keyword}">
                <p>검색어: ${keyword}</p>
            </c:if>

            <!-- 검색된 음식이 없을 경우 -->
            <c:if test="${count == 0}">
                <p>검색된 음식이 없습니다.</p>
            </c:if>

            <!-- 검색된 음식이 있을 경우 -->
            <c:if test="${count > 0}">
                <ul>
                    <c:forEach var="food" items="${foodList}">
                        <li>${food.foodName}</li>
                    </c:forEach>
                </ul>

                <!-- 페이지 네비게이션 -->
                <div class="pagination">
                    <c:if test="${page != null}">
                        <span>${page}</span>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Footer Include (필요한 경우) -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
