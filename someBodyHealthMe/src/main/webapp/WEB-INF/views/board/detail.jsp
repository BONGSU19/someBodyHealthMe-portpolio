<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        height: 100%;
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
    .board-title{
    	margin-bottom:10px;
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
        <div class="board-title">제목 <span>제목이 들어가는 곳입니다.</span></div>
        <hr> <!-- 구분선 -->

        <!-- 작성자, 작성일, 조회수 -->
        <div class="info">
            <span class="nickname">작성자: 홍길동</span> 
            <span class="date">작성일: 2024-11-13</span> 
            <span class="views">조회수: 123</span>
        </div>
        <hr> <!-- 구분선 -->

        <!-- 글 내용 -->
        <div class="content">
            이곳은 게시글 내용이 표시됩니다. <br><br>
            여러 줄의 내용도 자유롭게 작성할 수 있으며, HTML 태그를 이용해 다양한 형식의 내용을 넣을 수 있습니다. 예를 들어, <strong>굵은 글씨</strong>나 <em>기울임꼴 글씨</em>, <u>밑줄</u>을 사용할 수 있습니다.
        </div>
        <hr width="100%" size="3" noshade="noshade">
        <!-- 첨부파일 목록 -->
        <div class="board-attachment">
            <div class="attachment-item">
                <span>파일1.txt</span>
                <button onclick="window.location.href='path/to/file1.txt'">다운로드</button>
            </div>
        </div>
        <hr width="100%" size="3" noshade="noshade">
    </div>
</div>

</body>
</html>
   