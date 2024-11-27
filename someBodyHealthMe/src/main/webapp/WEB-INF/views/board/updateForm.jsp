<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통공간 글수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board_writeForm.css" type="text/css">
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


 <div class="container">
        <h2><span>글수정</span></h2>
        <hr size="3" noshade="noshade">
        <form action="update.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="board_num" value="${board.board_num}">
            <div class="form-group">
                <label for="board_category">카테고리</label>
                <select name="board_category" id="board_category" class="form-attr" disabled>
                    <c:if test="${status >= 4}"><option value="1" <c:if test="${board.board_category == 1}">checked</c:if>>공지사항</option></c:if>
                    <option value="2" <c:if test="${board.board_category == 2}">checked</c:if>>자유게시판</option>
                    <option value="3" <c:if test="${board.board_category == 3}">checked</c:if>>오늘 운동 완료</option>
                </select>
            </div>
            <div class="form-group">
                <label for="board_title">제목</label>
                <input type="text" id="board_title" name="board_title" required placeholder="제목을 입력하세요" value="${board.board_title}">
            </div>
            <div class="form-group">
                <label for="board_attachment">첨부파일(이미지)</label>
                <input type="file" id="board_attachment" class="form-attr" name="board_attachment" accept="jpg, .jpeg, .png, .gif"> 
            </div>
            <c:if test="${!empty board.board_attachment}">
            <div class="db_attachment">
            	<span>현재 등록된 이미지</span>
                <img src="${pageContext.request.contextPath}/upload/${board.board_attachment}"  width="600" height="450" border="1">                
            </div>
            </c:if>
            <div class="form-group">
                <label for="board_content">내용</label>
                <textarea name="board_content" id="board_content" placeholder="내용을 입력하세요" class="form-attr" required>${board.board_content}</textarea>
            </div>
            <div class="align-end">
            	<input type="button" value="취소" onclick="history.go(-1)">            
                <input type="submit" value="수정완료">            
            </div>
        </form>
    </div>
    
</body>
</html>