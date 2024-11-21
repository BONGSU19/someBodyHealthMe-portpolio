<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통공간</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board.reply.js"></script>
<style type="text/css">
    body {            
        min-height: 150vh;
        margin: 0;
        font-family: Arial, sans-serif;
    }

    body h2 {
        background-color: #D9D9D9;
        width: 150px;
        margin-bottom: 20px; 
    }

    .container {
        width: 1080px;
        min-height: 100%;
        flex-grow: 1;
        overflow-y: auto;
        text-align: center;
        margin-top: 43px;
        margin-left: 43px;
        padding: 20px;
        background-color: #ffffff;
        border: 1px solid #ddd;
        float: left;
        overflow-x: hidden; /* 수평 스크롤 제거 */
    }

    .board-detail {
        text-align: left;
        padding: 20px;
    }

    .board-title {
        margin-bottom: 10px;
    }

    /* 작성자, 작성일, 조회수 정보 스타일 */
    .info {
        font-size: 14px;
        color: black;
        display: flex;
        justify-content: space-between; /* 왼쪽과 오른쪽으로 나누기 */
        align-items: center;
        margin: 10px 0 ;
    }

    .info .nickname {
        text-align: left;  /* 작성자 왼쪽 정렬 */
        flex-grow: 1;
    }

    .info .date,
    .info .views {
        text-align: right; /* 작성일, 조회수 오른쪽 정렬 */
        margin: 0 15px;
    }

    /* 글 내용 스타일 */
    .content {
        font-size: 16px;
        line-height: 1.6;
        margin: 20px auto;
        min-height: 50vh;
    }

    /* 구분선 스타일 */
    .board-detail hr {
        size: 3;
        width: 100%;        
    }

    /* 첨부파일 목록 스타일 */
    .board-attachment {
        margin: 10px 0;
    }

    .attachment-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
        padding: 5px 10px;
        border: 1px solid black;
        font-weight: bold;
    }  

    .attachment-item button {
        padding: 5px 10px;
        background-color: #D9D9D9;
        color: black;
        border: none;
        cursor: pointer;
        font-size: 14px;
        border-radius: 3px;
    }

    .attachment-item button:hover {
        background-color: #5a5757;
    }
    
    /*댓글*/
    h5{
    	margin-top : 20px;
    	align-text : left;
    }
    /* 댓글 입력 폼 스타일 */
    #re_form {
        display: flex;
        flex-direction: row; /* 한 줄로 배치 */
        align-items: flex-start; /* 세로로 상단 정렬 */
        margin-top: 10px; /* 위쪽 여백 */
        padding-top: 10px;
        width: 100%;
    }

    #profile {
        display: flex;
        flex-direction: column; /* 세로로 배치 */
        margin : 0 30px; /* 프로필과 텍스트 영역 간 간격 */
    }

    #profile img {
        width: 50px;
        height: 50px;
        border-radius: 50%; /* 원형 프로필 이미지 */
        margin: 5px 0;
        border: 2px solid black;
    }

    #profile span {
        font-size: 14px;
        color: #333;
    }

    #re_content {
        width: 80%; /* 텍스트 영역 너비 */
        height: 80px; /* 텍스트 영역 높이 */
        resize: none;
        padding: 5px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        margin-right: 30px; /* 간격 추가 */
        line-height: 20px;
    }
	
	/* 버튼 및 글자수 세기*/
    #re_info {
        display: flex;
        flex-direction: column; /* 세로로 배치 */
        justify-content: space-between;
        align-items: flex-end; /* 오른쪽 정렬 */
        margin: 10px 0;
    }

    #re_first {
        padding: 8px 15px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        margin-bottom: 10px; /* 버튼과 나머지 요소 간 간격 */
    }

    #re_first:hover {
        background-color: #45a049; /* 버튼 hover 효과 */
    }

    #re_second {
        font-size: 15px;
        color: #777;
    }
   
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/aside.jsp"/>
<div class="container">
    <h2>글상세</h2>
    <hr width="100%" size="3" noshade="noshade">
    <div class="board-detail">
        <!-- 글 제목 -->
        <div class="board-title">제목 <span>${board.board_title}</span></div>        
        
        <c:if test="${board.user_num == user_num || status > 3}">
        <hr> <!-- 구분선 -->
        <input type="button" value="수정" onclick="location.href='updateForm.do?board_num=${board.board_num}'">
        <input type="button" value="삭제" onclick="location.href='delete.do?board_num=${board.board_num}'">
        </c:if>        
        <hr> <!-- 구분선 --> 

        <!-- 작성자, 작성일, 조회수 -->
        <div class="info">
            <span class="nickname">작성자: ${board.nick_name}</span> 
            <span class="date">작성일: ${board.board_regdate}</span> 
            <span class="views">조회수: ${board.board_count}</span>
        </div>
        <hr> <!-- 구분선 -->

        <!-- 글 내용 -->
        <div class="content">
            ${board.board_content}
        </div>
        <hr>
    </div>
	<hr width="100%" size="3" noshade="noshade">
    <!-- 댓글 입력 폼 -->
    <section id="detail_reply">
    	<h5>댓글 등록</h5>
        <form id="re_form">
        	<input type="hidden" name="board_num" value="${board.board_num}" id="board_num">
            <div id="profile">
                <img src="#" >
                <span><c:if test="${empty user_num}">닉네임</c:if>${user.nick_name}</span>
            </div>
            <textarea name="re_content" id="re_content"></textarea>
            <div id="re_info">
                <input type="submit" value="등록" id="re_btn">
                <span id="re_count">0/300</span>
            </div>
        </form>
    </section>
    <!-- 댓글 폼 끝 -->
    
    <!-- 댓글 목록 -->
    <div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="다음글 보기">
	</div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
	</div>
    
</div>
</body>
</html>
