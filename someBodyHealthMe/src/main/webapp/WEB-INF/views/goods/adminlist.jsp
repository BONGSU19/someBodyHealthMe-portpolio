<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/IJ.css" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	window.onload = function() {
		const myForm = document.getElementById('search-bar');
		//이벤트 연결
		myForm.onsubmit = function() {
			const keyword = document.getElementById('keyword');
			if (keyword.value.trim() == '') {
				alert('검색어를 입력하세요');
				keyword.value = '';
				keyword.focus();
				return false;
			}
		};
	};
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/common/aside.jsp" />
		<div class="content-main">
			<form action="adminlist.do" method="get" class="search-bar">
				<div id="search-bar">
					<select name="keyfield">
						<option value="1"
							<c:if test="${param.keyfield==1}">selected</c:if>>상품명</option>
					</select> <input type="search-input" placeholder="상품명을 입력하세요." id="search-input"
						name="keyword"> <input type="submit" value="검색">
				</div>
			</form>
			<div class="list-space align-right">
				<c:if test="${status == 4}">
					<input type="button" value="상품 등록"
						onclick="location.href='writeForm.do'">
				</c:if>
				<input type="button" value="목록" onclick="location.href='adminlist.do'">
				<input type="button" value="홈으로"
					onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				<input type="button" value="찜 목록"
					onclick="location.href='likePage.do'">
				<input type="button" value="장바구니"
					onclick="location.href='${pageContext.request.contextPath}/cart/list.do'">
				<input type="button" value="주문목록"
					onclick="location.href='${pageContext.request.contextPath}/order/adminList.do'">
			</div>
			<c:if test="${count ==0}">
				<div class="result-display">표시할 상품이 없습니다.</div>
			</c:if>
			<c:if test="${count > 0}">
			<div class="product-list">
				<c:forEach var="goods" items="${list}">
						<div class="product-card">
							<a href="detail.do?goods_num=${goods.goods_num}"
								class="product-link">
								<div class="product-image">
									<img src="${pageContext.request.contextPath}/upload/${goods.goods_img1}" width="100">
								</div>
								<div class="product-info">
									<h3 class="product-name">${goods.goods_name}</h3>
									<div class="product-rating">
										<span>${goodsreview.re_rating}</span>
									</div>
									<c:if test="${goods.goods_status == 1}">
									<div class="product-price">
										<span class="price">판매가 중지된 상품</span>
									</div>
									</c:if>
									<c:if test="${goods.goods_status != 1}">
									<div class="product-price">
										<span class="price">${goods.goods_price}원</span>
									</div>
									</c:if>
								</div>
							</a>
						</div>
				</c:forEach>
				</div>
				<div class="align-center" id="page-selector">${page}</div>
			</c:if>
		</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>