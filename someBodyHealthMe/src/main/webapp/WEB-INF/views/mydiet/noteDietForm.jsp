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
    <script>
        // 팝업 창 열기
        function openSearchPopup() {
            document.getElementById("search-popup").style.display = "block";
        }

        // 팝업 창 닫기
        function closeSearchPopup() {
            document.getElementById("search-popup").style.display = "none";
        }
    </script>
</head>
<body>
    <div class="page-main">
        <!-- Header 영역 (기존 include) -->
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
        
        <!-- Aside 영역 (기존 include) -->
        <jsp:include page="/WEB-INF/views/common/aside_mybody.jsp"/>


            <!-- Main Content 영역 추가 -->
            <div class="main-content-diet">
                <section class="userdiet-info">
                    <div class="title">
                        <h2>끼니 등록 하기</h2>
                    </div>

                    <!-- 식사 유형 선택 버튼 (하나만 선택 가능) -->
                    <div class="meal-selection">
                        <h3>식사 유형 선택</h3>
                        <div class="meal-buttons">
                            <button type="button" id="breakfast" onclick="selectMeal('breakfast')">아침</button>
                            <button type="button" id="lunch" onclick="selectMeal('lunch')">점심</button>
                            <button type="button" id="dinner" onclick="selectMeal('dinner')">저녁</button>
                            <button type="button" id="snack" onclick="selectMeal('snack')">간식</button>
                        </div>
                    </div>

                    <!-- 음식 검색 기능 -->
                    <div class="food-search">
                        <h3>음식 검색</h3>
                        <div class="search-box">
                            <input type="text" id="food-search" placeholder="음식을 검색하세요">
                            <button type="button" onclick="openSearchPopup()">🔍</button>
                        </div>
                    </div>

                    <!-- 음식 검색 팝업 -->
                    <div id="search-popup" class="search-popup">
                        <div class="popup-content">
                            <span class="close" onclick="closeSearchPopup()">×</span>
                            <h4>음식 검색</h4>
                            <input type="text" id="popup-search" placeholder="음식 검색">
                            <div id="popup-results">
                                <!-- 검색 결과가 여기에 표시됩니다 -->
                            </div>
                        </div>
                    </div>

					<div id="submit-button" class="button">
    					<form action="${pageContext.request.contextPath}/mybody/myStatusSubmit.do" method="post" id="status-form">
        					<input type="submit" value="제출" id="submit-btn" />
    					</form>
					</div>
					
                </section>
            </div>
        </div>

</body>
</html>
