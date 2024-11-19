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
        }

        .container {
            width: 60%;
            height: 100%;
            flex-grow: 1; /* 남은 공간을 차지하도록 설정 */ 
            overflow-y: auto; /* 세로 스크롤 추가 */
            text-align: center;
 			margin-top:43px;
 			margin-left:43px;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #ddd; /* 외부 테두리 */
    		float:left;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            table-layout: fixed;  /* 고정된 테이블 레이아웃 */
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #D9D9D9;
            color: black;
        }

        /* 글등록 버튼 스타일 */
        .write-btn-container {
            text-align: right;
            margin-top: 20px;
        }

        .write-btn-container input[type="button"] {
            background-color: #D9D9D9;
            color: black;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            border-radius: 5px;
        }

        .write-btn-container input[type="button"]:hover {
            background-color: #8f9399;
        }

        /* 검색 바 스타일 */
        #search-bar {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        #search-bar select, #search-bar input[type="search"], #search-bar input[type="submit"]{
            padding: 10px;
            margin-right: 10px;
            font-size: 1rem;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        #search-bar input[type="submit"] {
            background-color: #D9D9D9;
            color: black;
            cursor: pointer;
        }

        #search-bar input[type="submit"]:hover {
            background-color: #8f9399;
        }
        

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/aside.jsp"/>
    <div class="container">
        <h2>나의 지원 목록</h2>
        <div class="content-main">                
            <table>
                <tr>
                    <th>지원번호</th>
                    <th>지원분야</th>
                    <th>지원지점</th>
                    <th>등록일(수정일)</th>
                    <th>확인 상태</th>
                </tr>                
                <c:forEach var="appl" items="${list}">
                <tr>
                    <td><a href="detail.do?appl_num=${appl.appl_num}">${appl.appl_num}</a></td>
                    <td>${appl.field}</td>
                    <td>${appl.appl_center}</td>
                    <c:if test="${!empty appl.appl_modifydate }">
                    <td>${appl.appl_modifydate}</td>
                    </c:if>
                    <c:if test="${empty appl.appl_modifydate }">
                   	<td>${appl.appl_regdate}</td>
                    </c:if>
                    <td>${appl.appl_status}</td>
                </tr>
                </c:forEach>
            </table>
            <c:if test="${empty list}">
            	<div>표시할 게시물이 없습니다.</div>   		
            </c:if> 
        </div>
    </div>
</body>


</html>