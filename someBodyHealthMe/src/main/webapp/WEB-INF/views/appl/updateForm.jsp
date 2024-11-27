<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통공간</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/applForm.css" type="text/css">
<script type="text/javascript">
	window.onload = function(){
		const field = document.getElementsByName('field');
		for (let i = 0; i < field.length; i++) {
	        if (field[i].value == Number(${appl.field})) {
	            field[i].checked = true;  // 일치하는 라디오 버튼을 체크
	            break;  // 일치하는 값을 찾으면 반복문 종료
	        }
	    }
		const career = document.getElementsByName('career');
		for (let i = 0; i < career.length; i++) {
	        if (career[i].value == Number(${appl.career})) {
	        	career[i].checked = true;  // 일치하는 라디오 버튼을 체크
	            break;  // 일치하는 값을 찾으면 반복문 종료
	        }
	    }
		const appl_center = document.getElementsByName('appl_center');
		for (let i = 0; i < appl_center.length; i++) {
	        if (appl_center[i].value == Number(${appl.appl_center})) {
	        	appl_center[i].selected = true;  // 일치하는 라디오 버튼을 체크
	            break;  // 일치하는 값을 찾으면 반복문 종료
	        }
	    }		
	};
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/aside.jsp"/>
    <div class="container">
        <h2 style="width:147px;">내용 수정</h2>
        <hr size="3" noshade="noshade"><br>
        
        <form action="update.do" method="post" enctype="multipart/form-data">
        	<input type="hidden" name="appl_num" value="${appl.appl_num}">
            <div class="appl-radio">
                <div>
                    <label for="">지원분야</label><p>
                    <div class="radios">
                        <input type="radio" name="field" value="2" <c:if test="${appl.field ==2}">checked</c:if>>트레이너
                        <input type="radio" name="field" value="3" <c:if test="${appl.field ==3}">checked</c:if>>사무직원
                    </div>
                </div>
                <div>                    
                    <label for="">경력유무</label><p>
                    <div class="radios-2">
                        <input type="radio" name="career" value="1" <c:if test="${appl.career ==1}">checked</c:if>>경력
                        <input type="radio" name="career" value="2" <c:if test="${appl.career ==2}">checked</c:if>>신입
                    </div>
                </div>
            </div>

            <label for="source">지원경로</label><br>
            <textarea name="source" id="source" style="resize: none;">${appl.source}</textarea>
            
            <label for="">지원지점</label><br>
            <select name="appl_center" id="appl_center">
                <option value="1" <c:if test="${appl.appl_center ==1}">selected</c:if>>강남점</option>
                <option value="2" <c:if test="${appl.appl_center ==2}">selected</c:if>>강북점</option>
            </select>
            <br>
             
            <label for="appl_attachment">첨부파일</label><br>
            <input type="file" name="appl_attachment"><br>
            <div class="attachmentList">
            <c:if test="${!empty appl.appl_attachment}"><span>${appl.appl_attachment}가 등록되어있습니다.</span></c:if>
            <c:if test="${empty appl.appl_attachment}"><span>첨부된 파일이 없습니다.</span></c:if>
          	</div>
          	
            <label for="">자기소개</label><br>
            <textarea name="content" id="content" placeholder="간단한 자기소개와 이력을 입력해 주세요.">${appl.content}</textarea>            
           
            
            <div class="appl-btn">
                <input type="button" value="수정취소" onclick="location.href='detail.do?appl_num=${appl.appl_num}'">
                <c:if test="${appl.appl_status ==0}">
                <input type="submit" value="수정완료">
                </c:if>
            </div>
        </form>   
    </div>
</body>


</html>