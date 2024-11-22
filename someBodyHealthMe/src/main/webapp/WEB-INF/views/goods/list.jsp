<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/IJ.css" type="text/css"> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/goods.like.js"></script>
<script type="text/javascript">
	window.onload=function(){
		const myForm = document.getElementById('search_form');
		//이벤트 연결
		myForm.onsubmit = function(){
			const keyword = document.getElementById('keyword');
			if(keyword.value.trim()==''){
				alert('검색어를 입력하세요');
				keyword.value='';
				keyword.focus();
				return false;
			}
		};
	};
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/common/aside.jsp"/>
	<div class="content-main">
	<h2>상품관리</h2>
	<form id="search_form" action="list.do" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>상품명</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
				</select>
			</li>
			<li>
				<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색">
			</li>
		</ul>
	</form>
	<div class="list-space align-right">
		<c:if test="${status == 4}">
			<input type="button" value="상품 등록" onclick="location.href='writeForm.do'">
		</c:if>
		<input type="button" value="목록" onclick="location.href='list.do'">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		<input type="button" value="My 메뉴" onclick="location.href='likePage.do'">
	</div>
	<c:if test="${count ==0}">
	<div class="result-display">
	 	표시할 상품이 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0}">
	 	<!-- <table>
	 		<tr>
	 			<th>카테고리</th>
	 			<th>상품명</th>
	 			<th>가격</th>
	 			<th>미리보기</th>
	 		</tr>
	 		<c:forEach var="goods" items="${list}">
	 		<tr>
	 			<td>${goods.goods_category}</td>
	 			<td><a href="detail.do?goods_num=${goods.goods_num}">${goods.goods_name}</a></td>
	 			<td><fmt:formatNumber value="${goods.goods_price}"/>원</td>
	 			 
	 			<td><img src="${pageContext.request.contextPath}/upload/${goods.goods_img1}" width="100"></td>
	 		</tr>
	 		</c:forEach>
	 	</table> -->
	 	<c:forEach var="goods" items="${list}">
	 	<div class="product-card">
	 		<%-- 좋아요 --%>
	        	<div class="product-actions">
		        <span>
					<img id="output_like" data-num="${goods.goods_num}"
					src="${pageContext.request.contextPath}/images/fav01.gif" width="50">
		        </span>
		    	</div>
		    	<%-- 좋아요 --%>
    		<a href="detail.do?goods_num=${goods.goods_num}" class="product-link">
	        	<div class="product-image">
	            	<img src="${pageContext.request.contextPath}/upload/${goods.goods_img1}" width="100"/>
	       	 	</div>
	        	<div class="product-info">
		            	<h3 class="product-name">${goods.goods_name}</h3>
		            <div class="product-rating">
		                <span>${goodsreview.re_rating}</span>
		            </div>
		            <div class="product-price">
		                <span class="price">${goods.goods_price}원</span>
		            </div>
	        	</div>
    		</a>
    		
		</div>
	 	</c:forEach>
	 	<div class="align-center">${page}</div>
	</c:if>
	</div>
</div>
</body>
</html>