<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>소통공간</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board_list.css" type="text/css">
    <link rel="stylesheet" href="board_list.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/aside.jsp"/>
    <div class="container">
        <h2>소통공간</h2>
        <div class="content-main">   
            <table>
                <tr style="background-color: #d9d9d9; border-bottom: 2px solid black;">
                    <th width="60">글번호</th>
                    <th width="700">제목</th>
                    <th width="100">작성자</th>
                    <th width="80">작성일</th>
                    <th width="60">조회수</th>
                </tr>    
                
                <c:forEach var="board" items="${list}">
                <tr>
                    <td>${board.board_num}</td>
                    <td><a href="detail.do?board_num=${board.board_num}">${board.board_title}</a></td>
                    <td>${board.nick_name}</td>
                    <td>${board.board_regdate}</td>
                    <td>${board.board_count}</td>
                </tr>
                </c:forEach>
            </table>  
            <c:if test="${count==0}">
            	<div class="count-0">표시할 게시물이 없습니다.</div> 		
            </c:if>          
            
            <hr size="3" noshade="noshade" width="94%">
            <div style="text-align:center;">
            	${page}
            </div>
            
            
            <!-- 글 등록 버튼 -->
            <div class="write-btn-container">
                <input type="button" value="글쓰기" id="write_btn" onclick="location.href='writeForm.do'">
            </div>
            <!-- 검색바 -->
            <form action="list.do" method="get" class="search-bar">
            	<div id="search-bar">
              	  <select name="keyfield">
               	     <option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
               	     <option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
                     <option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>닉네임</option>
             	   </select>
              	   <input type="search" placeholder="검색어 입력" id="search-input" name="keyword">
             	   <input type="submit" value="검색">
            	</div>
            </form>
        </div>           
           
    </div>
</body>
</html>