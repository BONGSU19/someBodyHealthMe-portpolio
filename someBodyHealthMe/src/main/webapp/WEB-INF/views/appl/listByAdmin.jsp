<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소통공간</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HY.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/applList.css" type="text/css">

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/aside.jsp"/>
	<div class="container">
        <h2>지원 목록</h2>
        <div class="content-main"> 
            <!-- 관리자 검색 조건 -->
            <form action="listByAdmin.do" method="get" enctype="multipart/form-data">
            
                <!-- 확인 상태와 지원 분야를 한 줄로 배치 -->
                <div class="form-group">
                    <div>
                        <label for="appl_status">확인 상태</label>
                        <select id="appl_status" name="appl_status" required>
                            <option value="0">미확인</option>
                            <option value="1">확인</option>
                            <option value="9">전체</option>
                        </select>
                    </div>
                    <div>
                        <label for="field">지원 분야</label>
                        <select id="field" name="field" required>
                            <option value="2">트레이너</option>
                            <option value="3">사무직원</option>
                            <option value="9">전체</option>
                        </select>
                    </div>
                    <div>
                        <label for="career">경력 유무</label>
                        <select id="career" name="career" required>
                            <option value="1">경력</option>
                            <option value="2">신입</option>
                            <option value="9">전체</option>
                        </select>
                    </div>
                    <div>
                        <label for="appl_center">지원 지점</label>
                        <select id="appl_center" name="appl_center" required>
                            <option value="1">강남점</option>
                            <option value="2">강북점</option>
                            <option value="9">전지점</option>
                        </select>
                    </div>
                </div>

                <!-- 이름 검색과 제출 버튼을 한 줄에 배치 -->
                <div class="search-group">
                    <input type="search" name="name" placeholder="이름 검색">
                    <button type="submit">검색</button>
                </div>

            </form>
        </div>    

        <!-- 지원 목록 테이블 -->
        <table >
            <tr>
                <th width="100px" height="35px">지원번호</th>
                <th width="160px">이름</th> <!-- 추가된 부분 -->
                <th width="160px">경력</th> <!-- 추가된 부분 -->
                <th width="80px">지원 지점</th>
                <th width="160px">등록일</th> <!-- 추가된 부분 -->
                <th width="100px">확인 상태</th>
            </tr>                
            <c:forEach var="appl" items="${list}">
            <tr>
                <td><a href="detail.do?appl_num=${appl.appl_num}">${appl.appl_num}</a></td>
                <td>${appl.name}</td> <!-- 이름 -->
                <td>${appl.career == 1 ? '경력' : appl.career == 2 ? '신입' : '전체'}</td> <!-- 경력 -->
                <td>${appl.appl_center}</td>
                <c:if test="${!empty appl.appl_modifydate }">
                <td>${appl.appl_modifydate}</td>
                </c:if>
                <c:if test="${empty appl.appl_modifydate }">
               	<td>${appl.appl_regdate}</td>
                </c:if>
                <!-- <td>${appl.appl_status}</td> -->
            </tr>
            </c:forEach>
        </table>
        
        <c:if test="${empty list}">
        	<div class="no-data-message">표시할 게시물이 없습니다.</div>   		
        </c:if> 
        <div class="page">${page}</div> 
    </div>
</body>


</html>