<!-- /WEB-INF/views/mydiet/makeDietForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>건강지킴이 - 식사 기록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
    <style>
        .meal-box {
            margin-left: 20px;
        }

        /* 기존 스타일 유지 또는 필요한 추가 스타일 적용 */
        .meal-records .meal-box {
            display: flex;
            flex-direction: column; /* 수직 정렬로 변경 */
            align-items: flex-start; /* 왼쪽 정렬 */
            margin-bottom: 20px;
        }

        .meal-records .meal-box h3 {
            margin: 0 0 10px 0; /* 아래쪽 마진 추가 */
        }

        .meal-records .meal-box .meal-info {
            flex-grow: 1;
            margin-bottom: 10px;
        }

        .meal-records .meal-box .add-button {
            align-self: flex-end; /* 오른쪽 정렬 */
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        /* 영양소 정보 섹션 숨김 */
        .nutrition-info {
            display: none; /* 필요 시 조정 */
        }

        /* 추가적인 스타일은 필요에 따라 조정 */
    </style>
</head>
<body>
    <div class="page-main">
        <!-- Header 영역 (기존 include) -->
        <jsp:include page="/WEB-INF/views/common/header.jsp" />

        <!-- Aside 영역 (기존 include) -->
        <jsp:include page="/WEB-INF/views/common/aside_mybody.jsp" />

        <!-- Main Content 영역 -->
        <div class="main-content-nutrition">
            <!-- 아침, 점심, 저녁, 간식 기록하는 메모지 -->
            <div class="meal-records">
                <!-- 아침 -->
                <div class="meal-box" id="breakfast">
                    <h3>아침</h3>
                    <div class="meal-info">
                        <c:choose>
                            <c:when test="${not empty breakfastLogs}">
                                <c:forEach var="meal" items="${breakfastLogs}">
                                    <span>${meal.foodName} (${fn:substring(meal.createdAt, 0, 10)})</span><br/>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <span>아침에 먹은 음식을 기록하세요</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button class="add-button"
                        onclick="location.href='${pageContext.request.contextPath}/mydiet/noteDietForm.do'">+</button>
                </div>

                <!-- 점심 -->
                <div class="meal-box" id="lunch">
                    <h3>점심</h3>
                    <div class="meal-info">
                        <c:choose>
                            <c:when test="${not empty lunchLogs}">
                                <c:forEach var="meal" items="${lunchLogs}">
                                    <span>${meal.foodName} (${fn:substring(meal.createdAt, 0, 10)})</span><br/>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <span>점심에 먹은 음식을 기록하세요</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button class="add-button"
                        onclick="location.href='${pageContext.request.contextPath}/mydiet/noteDietForm.do'">+</button>
                </div>

                <!-- 저녁 -->
                <div class="meal-box" id="dinner">
                    <h3>저녁</h3>
                    <div class="meal-info">
                        <c:choose>
                            <c:when test="${not empty dinnerLogs}">
                                <c:forEach var="meal" items="${dinnerLogs}">
                                    <span>${meal.foodName} (${fn:substring(meal.createdAt, 0, 10)})</span><br/>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <span>저녁에 먹은 음식을 기록하세요</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button class="add-button"
                        onclick="location.href='${pageContext.request.contextPath}/mydiet/noteDietForm.do'">+</button>
                </div>

                <!-- 간식 -->
                <div class="meal-box" id="snack">
                    <h3>간식</h3>
                    <div class="meal-info">
                        <c:choose>
                            <c:when test="${not empty snackLogs}">
                                <c:forEach var="meal" items="${snackLogs}">
                                    <span>${meal.foodName} (${fn:substring(meal.createdAt, 0, 10)})</span><br/>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <span>간식에 먹은 음식을 기록하세요</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button class="add-button"
                        onclick="location.href='${pageContext.request.contextPath}/mydiet/noteDietForm.do'">+</button>
                </div>
            </div>

            <!-- 영양소 정보 섹션 숨김 -->
            <div class="nutrition-info">
                <!-- 기존 영양소 정보는 숨김 처리 -->
            </div>
        </div>
    </div>

    <!-- JavaScript 수정: 필요 시 추가 기능 구현 -->
    <script>
        // 영양소 정보 섹션이 숨겨져 있으므로 관련 스크립트 제거 또는 조정
    </script>
</body>
</html>
