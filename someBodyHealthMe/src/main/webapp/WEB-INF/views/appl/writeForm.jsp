<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원하기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/applForm.css" type="text/css">

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/aside.jsp"/>
  <div class="container">
        <h2>지원하기</h2>
        <hr size="3" noshade="noshade">
        <form action="write.do" id="appl_form" method="post" enctype="multipart/form-data">
            <div class="appl-radio">
                <div>
                    <label for="">지원분야</label><p>
                    <div class="radios">
                        <input type="radio" name="field" value="2">트레이너
                        <input type="radio" name="field" value="3">사무직원
                    </div>
                </div>
                <div>                    
                    <label for="">경력유무</label><p>
                    <div class="radios-2">
                        <input type="radio" name="career" value="1">경력
                        <input type="radio" name="career" value="2">신입
                    </div>
                </div>
            </div>

            <label for="source">지원경로</label><br>
            <textarea name="source" id="source" style="resize: none;" placeholder="지원경로를 입력해 주세요. EX) SNS / 지인소개 기타..."></textarea>
            
            <label for="">지원지점</label><br>
            <select name="appl_center" id="appl_center">
                <option value="1">강남점</option>
                <option value="2">강북점</option>
            </select>
            <br>
             
            <label for="appl_attachment">첨부파일</label><br>
            <input type="file" name="appl_attachment"><br>
          
            <label for="">자기소개</label><br>
            <textarea name="content" id="content" placeholder="간단한 자기소개와 이력을 입력해 주세요."></textarea>            
           
            
            <div class="appl-btn">
            <c:if test="${status != 4 }">
                <input type="button" value="지원취소" onclick="location.href='${pageContext.request.contextPath}/board/list.do'">
                <input type="submit" name="" value="지원하기">
            </c:if>
            <c:if test="${status == 4 }">
                <input type="button" value="지원목록">
                <input type="submit" name="" value="관리자전환">
            </c:if>
            </div>
        </form>        
    </div>  
</body>


</html>