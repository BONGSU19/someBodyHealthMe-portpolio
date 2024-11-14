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

        #search-bar select, #search-bar input[type="text"], #search-bar button {
            padding: 10px;
            margin-right: 10px;
            font-size: 1rem;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        #search-bar button {
            background-color: #D9D9D9;
            color: black;
            cursor: pointer;
        }

        #search-bar button:hover {
            background-color: #8f9399;
        }
        

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/aside.jsp"/>
    <div class="container">
        <h2>소통공간</h2>
        <div class="content-main">
            <table>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td><a href="detail.do">제목입니다.</a></td>
                    <td>닉네임</td>
                    <td>2024/11/02</td>
                    <td>16</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>두 번째 게시글</td>
                    <td>홍길동</td>
                    <td>2024/11/01</td>
                    <td>25</td>
                </tr>
            </table>

            <!-- 글등록 버튼 -->
            <div class="write-btn-container">
                <input type="button" value="글등록" onclick="location.href='writeForm.do'">
            </div>

            <!-- 검색바 -->
            <div id="search-bar">
                <select id="search-condition">
                    <option value="board_title">제목</option>
                    <option value="board_content">내용</option>
                    <option value="nick_name">닉네임</option>
                </select>
                <input type="text" placeholder="검색어 입력" id="search-input">
                <button onclick="location.href='#'">검색</button>
            </div>
        </div>
    </div>
</body>


</html>