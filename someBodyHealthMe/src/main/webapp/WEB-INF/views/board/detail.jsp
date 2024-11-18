<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통공간</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<style type="text/css">
    body {            
        min-height: 100vh;
        margin: 0;
        font-family: Arial, sans-serif;
    }

    body h2 {
        background-color: #D9D9D9;
        width: 150px;
        margin-bottom: 20px; 
    }

    .container {
        width: 60%;
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
    .detail-comment {
        display: flex;
        justify-content: center;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        width: 95%; /* container의 width에 맞추기 */
        margin: 0 auto;
    }

    .comment-form {
        display: flex;
        align-items: flex-start;
        width: 100%;
    }

    /* 왼쪽: 프로필 이미지와 닉네임 */
    .profile-section {
        margin-right: 15px;
        text-align: center;
    }

    .profile-img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        object-fit: cover;
    }

    .comment-nickname {
        display: block;
        margin-top: 10px;
        font-weight: bold;
        font-size: 15px;
    }

    /* 오른쪽: 댓글 내용 입력과 제출 버튼 */
    .comment-section {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: flex-start;
    }

    /* 댓글 입력란과 버튼을 한 줄에 배치 */
    .comment-input-container {
        display: flex;
        align-items: center;
        width: 100%;
    }

    textarea {
        flex-grow: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        resize: none;
        font-size: 14px;
        margin-right: 10px;
    }

    .submit-btn {
        padding: 10px 20px;
        background-color: #D9D9D9;
        color: black;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        flex-shrink: 0; /* 버튼이 축소되지 않도록 설정 */
    }

    .submit-btn:hover {
        background-color: #45a049;
    }

    /* 글자수 표시 */
    .char-count {
        font-size: 12px;
        color: #555;
        text-align: right;
        width: 100%;
        margin-top: 5px;
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
        <hr width="100%" size="3" noshade="noshade">
        <!-- 첨부파일 목록 -->
        <div class="board-attachment">
            <div class="attachment-item">
                <span>${board.board_attachment}</span>
                <button onclick="window.location.href='path/to/file1.txt'">다운로드</button>
            </div>
        </div>
        <hr width="100%" size="3" noshade="noshade">
    </div>

    <!-- 댓글 입력 폼 -->
    <section class="detail-comment">
        <form action="/submit-comment" method="post" class="comment-form">
            <!-- 왼쪽: 프로필 사진과 닉네임 -->
            <div class="profile-section">
                <img src="profile.jpg" alt="프로필 사진" class="profile-img">
                <span class="comment-nickname">닉네임</span>
            </div>
            
            <!-- 오른쪽: 댓글 내용 입력과 제출 버튼 -->
            <div class="comment-section">
                <div class="comment-input-container">
                    <textarea id="comment" name="comment" rows="3" placeholder="댓글을 입력하세요" maxlength="300" required></textarea>
                    <button type="submit" class="submit-btn">등록</button>
                </div>
                <div class="char-count">
                    <span id="char-count">0</span>/300
                </div>
            </div>
        </form>
    </section>
</div>

</body>
</html>
