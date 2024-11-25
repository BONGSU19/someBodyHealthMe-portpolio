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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 음식 검색 및 팝업창 동작
        function searchFood() {
            var keyword = $("#foodKeyword").val(); // 입력한 키워드 값
            if (keyword.trim() === "") {
                alert("검색어를 입력해 주세요.");
                return;
            }

            // AJAX 요청을 통해 서버로 검색어를 보냄
            $.ajax({
                url: "${pageContext.request.contextPath}/searchFood", // 검색 처리 URL
                type: "GET",
                data: { keyword: keyword },
                success: function(response) {
                    // 검색된 음식 목록을 #foodSelect에 업데이트
                    $("#foodList").html(''); // 기존 옵션 삭제
                    if (response.length > 0) {
                        $.each(response, function(index, food) {
                            $("#foodList").append('<li class="food-item" data-id="' + food.id + '">' + food.name + '</li>');
                        });
                    } else {
                        $("#foodList").append('<li>검색 결과 없음</li>');
                    }
                    // 팝업창 열기
                    openFoodPopup();
                },
                error: function() {
                    alert("검색 중 오류가 발생했습니다.");
                }
            });
        }

        // 팝업창 열기
        function openFoodPopup() {
            $('#foodPopup').fadeIn();
        }

        // 팝업창 닫기
        function closeFoodPopup() {
            $('#foodPopup').fadeOut();
        }

        // 음식 선택
        $(document).on('click', '.food-item', function() {
            var foodName = $(this).text();
            var foodId = $(this).data('id');
            $('#foodSelect').val(foodName);
            $('#foodId').val(foodId);
            closeFoodPopup(); // 팝업 닫기
        });

        // 팝업창 드래그 기능
        $(function() {
            var $dragging = null;
            var $dragged = null;
            $('#foodPopupHeader').on('mousedown', function(e) {
                $dragging = $(this);
                $dragged = $('#foodPopup');
                var offset = $dragged.offset();
                var diffX = e.pageX - offset.left;
                var diffY = e.pageY - offset.top;

                $(document).on('mousemove', function(e) {
                    $dragged.offset({
                        top: e.pageY - diffY,
                        left: e.pageX - diffX
                    });
                });

                $(document).on('mouseup', function() {
                    $dragging = null;
                    $dragged = null;
                    $(document).off('mousemove');
                    $(document).off('mouseup');
                });
            });
        });
    </script>
    <style>
        /* 팝업창 스타일 */
        #foodPopup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 80%;
            max-width: 600px;
            background-color: white;
            border: 2px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            padding: 20px;
        }

        #foodPopupHeader {
            cursor: move;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            font-size: 16px;
            border-radius: 8px 8px 0 0;
            text-align: center;
        }

        #foodPopup .food-item {
            padding: 8px;
            cursor: pointer;
            border-bottom: 1px solid #f0f0f0;
        }

        #foodPopup .food-item:hover {
            background-color: #f0f0f0;
        }

        #foodPopup .food-item.selected {
            background-color: #4CAF50;
            color: white;
        }

        #foodPopupClose {
            background-color: #ff4444;
            color: white;
            border: none;
            padding: 5px;
            border-radius: 4px;
            cursor: pointer;
            float: right;
            margin-top: -15px;
        }

        #foodPopupClose:hover {
            background-color: #cc0000;
        }
    </style>
</head>
<body>
    <div class="page-main">
        <!-- Header 영역 (기존 include) -->
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
        
        <!-- Aside 영역 (기존 include) -->
        <jsp:include page="/WEB-INF/views/common/aside_mybody.jsp"/>

        <!-- 사용자 입력 폼 -->
        <div class="meal-entry-form">
            <h2>오늘의 끼니 입력</h2>
            <form action="${pageContext.request.contextPath}/submitMeal" method="post">
                <!-- 끼니 유형 선택 -->
                <div class="form-group">
                    <label for="mealType">끼니 유형:</label>
                    <select id="mealType" name="mealType">
                        <option value="breakfast">아침</option>
                        <option value="lunch">점심</option>
                        <option value="dinner">저녁</option>
                    </select>
                </div>
                
                <!-- 음식 검색 -->
                <div class="form-group">
                    <label for="foodKeyword">음식 검색:</label>
                    <input type="text" id="foodKeyword" name="foodKeyword" placeholder="음식 이름을 입력하세요" />
                    <button type="button" onclick="searchFood()">검색</button>
                </div>
                
                <!-- 음식 선택 (ID 값으로 처리) -->
                <div class="form-group">
                    <label for="food">음식 선택:</label>
                    <input type="text" id="foodSelect" name="food" readonly />
                    <input type="hidden" id="foodId" name="foodId" />
                </div>
                
                <!-- 음식 양 입력 -->
                <div class="form-group">
                    <label for="quantity">얼마나 먹었나요?</label>
                    <input type="number" id="quantity" name="quantity" min="1" required>
                </div>
                
                <!-- 제출 버튼 -->
                <div class="form-group">
                    <button type="submit">제출</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 음식 선택 팝업 -->
    <div id="foodPopup">
        <div id="foodPopupHeader">
            음식 선택
            <button id="foodPopupClose" onclick="closeFoodPopup()">닫기</button>
        </div>
        <ul id="foodList">
            <!-- 음식 목록이 동적으로 표시될 곳 -->
        </ul>
    </div>
</body>
</html>
