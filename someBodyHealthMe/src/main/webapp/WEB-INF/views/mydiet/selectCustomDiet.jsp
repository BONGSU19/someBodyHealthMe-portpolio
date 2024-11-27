<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 지정 식단 보기</title>
    <!-- 기존 CSS 파일 재사용 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
    <style>
        /* 테이블 스타일 */
        table {
            width: 70%;  /* 테이블 너비를 70%로 설정 */
            margin: 20px auto;  /* 화면 가운데 정렬 */
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px 12px;  /* 셀 내부 여백을 줄여서 크기 조정 */
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #5E8BC6;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e9e9e9;
        }

        /* 버튼 박스 스타일 */
        .button-box {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin-top: 30px;
        }

        .button {
            background-color: #F29595;
            padding: 10px 20px;
            border-radius: 5px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
            color: white;
        }

        .button:hover {
            background-color: #D27777;
        }
    </style>
</head>
<body>
    <div class="page-main">
        <!-- 헤더 포함 -->
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
        
        <!-- 사이드 메뉴 포함 -->
        <jsp:include page="/WEB-INF/views/common/aside_mybody.jsp" />

        <!-- 사용자 지정 식단 보기 -->
        <div class="main-content">
            <h2 style="text-align: center; margin-top: 20px;">사용자 지정 식단 보기</h2>

            <!-- 식단 리스트 테이블 -->
            <table>
                <thead>
                    <tr>
                        <th>식단 ID</th>
                        <th>식품 이름</th>
                        <th>칼로리</th>
                        <th>단백질</th>
                        <th>탄수화물</th>
                        <th>지방</th>
                        <th>미네랄</th>
                        <th>식단 댓글</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- DIET_SHOW = 0인 데이터 반복 출력 -->
                    <c:forEach var="diet" items="${dietList}">
                        <tr>
                            <td>${diet.dietId}</td>
                            <td>${diet.foodName}</td>
                            <td>${diet.calories}</td>
                            <td>${diet.protein}</td>
                            <td>${diet.carbohydrate}</td>
                            <td>${diet.fat}</td>
                            <td>${diet.minerals}</td>
                            <td>${diet.dietComment}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 버튼 박스 -->
            <div class="button-box">
                <c:if test="${not empty dietList}">
                    <!-- 식단 리스트가 존재하면 '식단 수정' 버튼 보이기 -->
                    <div id="modify-button" class="button">
                        <a href="${pageContext.request.contextPath}/mydiet/editDietForm.do">수정</a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
