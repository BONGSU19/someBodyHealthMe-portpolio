<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통공간 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board_writeForm.css" type="text/css">
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
<jsp:include page="/WEB-INF/views/common/AsideBoard.jsp"/>
<div class="container">
        <h2><span>소통공간 글쓰기</span></h2>
        <hr size="3" noshade="noshade">
        <form action="write.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="board_category">게시판 선택</label>
                <select name="board_category" id="board_category" class="form-attr">
                    <c:if test="${status >= 4}"><option value="1">공지사항</option></c:if>
                    <option value="2">자유게시판</option>
                    <option value="3">오늘 운동 완료</option>
                </select>
            </div>
            <div class="form-group">
                <label for="board_title">제목</label>
                <input type="text" name="board_title" id="board_title" placeholder="제목을 입력해 주세요" class="form-attr" required>
            </div>
            <div class="form-group">
                <label for="board_attachment">첨부파일(이미지)</label>
                <input type="file" id="board_attachment" name="board_attachment" class="form-attr" accept="jpg, .jpeg, .png, .gif"> 
            </div>
            <div class="form-group">
                <label for="board_content">내용</label>
                <textarea name="board_content" id="board_content" placeholder="내용을 입력하세요" class="form-attr" required></textarea>
            </div>
            <div class="align-end">
                <input type="button" value="등록취소" onclick="history.go(-1)">            
                <input type="submit" value="등록하기">            
            </div>
        </form>
    </div>
</div>    
</body>
</html>