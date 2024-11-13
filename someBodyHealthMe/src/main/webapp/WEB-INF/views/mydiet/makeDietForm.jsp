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
        <div class="main-content-nutrition">
            <!-- 아침, 점심, 저녁, 간식 기록하는 메모지 -->
            <div class="meal-records">
                <div class="meal-box" id="breakfast">
                    <h3>아침</h3>
                    <textarea placeholder="아침에 먹은 음식을 기록하세요"></textarea>
                </div>
                <div class="meal-box" id="lunch">
                    <h3>점심</h3>
                    <textarea placeholder="점심에 먹은 음식을 기록하세요"></textarea>
                </div>
                <div class="meal-box" id="dinner">
                    <h3>저녁</h3>
                    <textarea placeholder="저녁에 먹은 음식을 기록하세요"></textarea>
                </div>
                <div class="meal-box" id="snack">
                    <h3>간식</h3>
                    <textarea placeholder="간식에 먹은 음식을 기록하세요"></textarea>
                </div>
            </div>

            <!-- 사람 몸 모양 이미지 -->
            <div class="body-image">
                <img src="${pageContext.request.contextPath}/images/body-shape.png" alt="몸 모양" />
            </div>

            <!-- 섭취해야 할 칼로리, 단백질, 지방, 탄수화물 정보 -->
            <div class="nutrition-info">
                <h2>오늘 섭취해야 하는 영양소</h2>
                <div class="nutrition-box">
                    <p>칼로리: <span>2000 kcal</span></p>
                    <div class="gauge">
                        <div class="gauge-bar" style="width: 50%"></div>
                    </div>
                </div>
                <div class="nutrition-box">
                    <p>단백질: <span>150g</span></p>
                    <div class="gauge">
                        <div class="gauge-bar" style="width: 70%"></div>
                    </div>
                </div>
                <div class="nutrition-box">
                    <p>지방: <span>70g</span></p>
                    <div class="gauge">
                        <div class="gauge-bar" style="width: 35%"></div>
                    </div>
                </div>
                <div class="nutrition-box">
                    <p>탄수화물: <span>300g</span></p>
                    <div class="gauge">
                        <div class="gauge-bar" style="width: 80%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
