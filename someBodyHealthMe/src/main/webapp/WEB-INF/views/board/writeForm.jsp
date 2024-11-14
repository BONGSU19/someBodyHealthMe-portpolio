<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통공간 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<style type="text/css">
    body {            
        min-height: 150vh;
        margin: 0;
    }

    .container {
        width: 60%;
        height: 100%;
        flex-grow: 1;
        overflow-y: auto;
        text-align: center;
        margin:0 auto;
        margin-top: 43px;
 
        padding: 20px;
        background-color: #ffffff;
        border: 1px solid #ddd;
        
    }

    .write-form {
        text-align: left;
        width: 100%;
        margin-top: 20px;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    .form-group input, .form-group select, .form-group textarea {
        width: 100%;
        padding: 8px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .form-group textarea {
        height: 200px;
        resize: vertical;
    }

    .form-group input[type="file"] {
        padding: 3px;
    }
    
    .form-group textarea {
   		 width: 100%;      /* 너비를 100%로 설정하여 컨테이너 너비에 맞추기 */
   		 height: 600px;    /* 높이를 늘려서 내용이 더 많이 보이도록 설정 */
   		 resize: none; /* 수직으로 크기 조정 가능하도록 설정 (수평은 조정 안되게) */
	}

    .submit-btn-container {
        text-align: right;
        margin-top: 20px;
    }

    .submit-btn-container input[type="submit"] {
        background-color: #D9D9D9;
        color: black;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        font-size: 1rem;
        border-radius: 5px;
    }

    .submit-btn-container input[type="submit"]:hover {
        background-color: #8f9399;
    }
</style>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<div class="container">
    <h2>글등록</h2>
    <div class="write-form">
        <form action="write.do" method="POST" enctype="multipart/form-data">
            <!-- 게시판 선택 -->
            <div class="form-group">
                <label for="board_category">게시판 선택</label>
                <select id="board_category" name="board_category" required>
                	<c:if test="${user_auth >=9}"><option value="1">공지사항</option></c:if>                    
                    <option value="2">자유게시판</option>
                    <option value="3">오늘운동완료</option>
                </select>
            </div>

            <!-- 제목 입력 -->
            <div class="form-group">
                <label for="board_title">제목</label>
                <input type="text" id="board_title" name="board_title" required placeholder="제목을 입력하세요">
            </div>

            <!-- 첨부파일 -->
            <div class="form-group">
                <label for="board_attachment">첨부파일</label>
                <input type="file" id="board_attachment" name="board_attachment">
            </div>

            <!-- 내용 입력 -->
            <div class="form-group">
                <label for="board_content">내용</label>
                <textarea id="board_content" name="board_content" required placeholder="내용을 입력하세요" rows="300"></textarea>
            </div>

            <!-- 제출 버튼 -->
            <div class="submit-btn-container">
                <input type="submit" value="등록">
            </div>
        </form>
    </div>
</div>

</body>
</html>