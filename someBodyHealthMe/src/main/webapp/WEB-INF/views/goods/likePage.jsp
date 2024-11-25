<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/IJ.css" type="text/css"> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="page-main">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="content-main">
	<div class="mypage-div">
 			<h3>찜 목록</h3>
 			<table>
					<tr>
						<th>상품 이미지</th>
						<th>상품명</th>
						<th>가격</th>
					</tr> 			
					<c:forEach var="goods" items="${goodsList}">
					<tr>
						<td><img src="${pageContext.request.contextPath}/upload/${goods.goods_img1}" width="200"></td>
						<td><a href="${pageContext.request.contextPath}/goods/detail.do?goods_num=${goods.goods_num}"
						target="_blank">${fn:substring(goods.goods_name,0,26)}</a></td>
						<td>${goods.goods_price}</td>
					</tr>
					</c:forEach>
 			</table>
 	</div>
 </div>
</div> 	
</body>
</html>