<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>건강지킴이</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<style>
.meal-box {
	margin-left: 20px;
}

/* 추가된 스타일 */
.meal-records .meal-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.meal-records .meal-box h3 {
	margin: 0;
}

.meal-records .meal-box .meal-info {
	flex-grow: 1;
}

.meal-records .meal-box .add-button {
	cursor: pointer;
	background-color: #4CAF50;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	font-size: 16px;
}

.nutrition-info {
	margin-top: 20px; /* 위쪽 마진을 줄여서 공간 절약 */
	padding: 15px; /* 내부 여백을 줄여서 크기 축소 */
	background-color: #f9f9f9; /* 배경색 */
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	width: 70%; /* 기본 너비 100% */
	max-width: 900px; /* 최대 너비 900px로 제한 (필요에 따라 조정 가능) */
	margin-left: 20%; /* 수평 중앙 정렬 */
	margin-right: auto; /* 수평 중앙 정렬 */
}

.nutrition-info h2 {
	font-size: 22px; /* 제목 크기 축소 */
	font-weight: bold;
	margin-bottom: 10px;
}

/* nutrition-box 스타일 추가 */
.nutrition-box {
	margin-bottom: 15px;
	font-size: 18px;
}

.nutrition-box p {
	margin: 0;
	font-weight: bold;
	color: #333;
}

.nutrition-box .gauge {
	margin-top: 10px;
	position: relative;
	height: 20px;
	background-color: #ddd;
	border-radius: 10px;
}

.nutrition-box .gauge-bar {
	height: 100%;
	background-color: #4CAF50; /* 섭취한 칼로리, 단백질, 지방, 탄수화물에 맞춰 색상 조정 */
	border-radius: 10px;
}

/* 사람 몸 이미지 스타일 */
.body-image img {
	width: 100%;
	max-width: 300px;
}
</style>
</head>
<body>
	<div class="page-main">
		<!-- Header 영역 (기존 include) -->
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<!-- Aside 영역 (기존 include) -->
		<jsp:include page="/WEB-INF/views/common/aside_mybody.jsp" />

		<!-- Main Content 영역 추가 -->
		<div class="main-content-nutrition">
			<!-- 아침, 점심, 저녁, 간식 기록하는 메모지 -->
			<div class="meal-records">
				<div class="meal-box" id="breakfast">
					<h3>아침</h3>
					<div class="meal-info">
						<span id="breakfast-info">아침에 먹은 음식을 기록하세요</span>
					</div>
					<button class="add-button"
						onclick="location.href='${pageContext.request.contextPath}/mydiet/noteDietForm.do'">+</button>
				</div>
				<div class="meal-box" id="lunch">
					<h3>점심</h3>
					<div class="meal-info">
						<span id="lunch-info">점심에 먹은 음식을 기록하세요</span>
					</div>
					<button class="add-button"
						onclick="location.href='${pageContext.request.contextPath}/mydiet/noteDietForm.do'">+</button>
				</div>
				<div class="meal-box" id="dinner">
					<h3>저녁</h3>
					<div class="meal-info">
						<span id="dinner-info">저녁에 먹은 음식을 기록하세요</span>
					</div>
					<button class="add-button"
						onclick="location.href='${pageContext.request.contextPath}/mydiet/noteDietForm.do'">+</button>
				</div>
				<div class="meal-box" id="snack">
					<h3>간식</h3>
					<div class="meal-info">
						<span id="snack-info">간식에 먹은 음식을 기록하세요</span>
					</div>
					<button class="add-button"
						onclick="location.href='${pageContext.request.contextPath}/mydiet/noteDietForm.do'">+</button>
				</div>
			</div>

			<!-- 사람 몸 모양 이미지 -->
			<div class="body-image">
				<img src="${pageContext.request.contextPath}/images/body-shape.png"
					alt="몸 모양" />
			</div>

			<!-- 섭취해야 할 칼로리, 단백질, 지방, 탄수화물 정보 -->
			<div class="nutrition-info">
				<h2>오늘 섭취해야 하는 영양소</h2>
				<div class="nutrition-box">
					<p>
						칼로리: <span id="total-calories">2000 kcal</span>
					</p>
					<div class="gauge">
						<div class="gauge-bar" id="calorie-gauge" style="width: 0%"></div>
					</div>
				</div>
				<div class="nutrition-box">
					<p>
						단백질: <span>150g</span>
					</p>
					<div class="gauge">
						<div class="gauge-bar" style="width: 70%"></div>
					</div>
				</div>
				<div class="nutrition-box">
					<p>
						지방: <span>70g</span>
					</p>
					<div class="gauge">
						<div class="gauge-bar" style="width: 35%"></div>
					</div>
				</div>
				<div class="nutrition-box">
					<p>
						탄수화물: <span>300g</span>
					</p>
					<div class="gauge">
						<div class="gauge-bar" style="width: 80%"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
        // 예시: 식사에 대한 칼로리 데이터 업데이트
        const mealData = {
            breakfast: { food: '계란 2개', calories: 150 },
            lunch: { food: '샐러드', calories: 300 },
            dinner: { food: '닭가슴살', calories: 400 },
            snack: { food: '바나나', calories: 100 }
        };

        // 식단 정보 갱신
        document.getElementById("breakfast-info").innerText = `${mealData.breakfast.food} (${mealData.breakfast.calories} kcal)`;
        document.getElementById("lunch-info").innerText = `${mealData.lunch.food} (${mealData.lunch.calories} kcal)`;
        document.getElementById("dinner-info").innerText = `${mealData.dinner.food} (${mealData.dinner.calories} kcal)`;
        document.getElementById("snack-info").innerText = `${mealData.snack.food} (${mealData.snack.calories} kcal)`;

        // 칼로리 게이지 업데이트
        const totalCalories = 2000;  // 예시: 섭취 목표 칼로리
        const consumedCalories = mealData.breakfast.calories + mealData.lunch.calories + mealData.dinner.calories + mealData.snack.calories;
        const caloriePercentage = (consumedCalories / totalCalories) * 100;
        document.getElementById("calorie-gauge").style.width = `${caloriePercentage}%`;
    </script>
</body>
</html>
