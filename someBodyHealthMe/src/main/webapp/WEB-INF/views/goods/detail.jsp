<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/IJ.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop.item-detail.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods.like.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods.reply.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	<c:if test="${status == 4}">
		<input type="button" value="상품 수정" onclick="location.href='updateForm.do?goods_num=${goods.goods_num}'">
		<input type="button" value="상품 삭제" id="delete_btn">
		<script type="text/javascript">
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete.do?goods_num=${goods.goods_num}');
				}
			};
		</script>
	</c:if>
		<c:if test="${goods.goods_status == 1}">
			<div class="result-diplay" >
				<div class="align-center">
					본 상품은 판매 중지되었습니다.
					<p>
					<input type="button" value="판매상품 보기" onclick="location.href='List.do'">
				</div>
			</div>
		</c:if>
		<c:if test="${goods.goods_status == 2}">
			<h3 class="align-center">${goods.goods_name}</h3>
			<div class="item-image">
				<img src="${pageContext.request.contextPath}/upload/${goods.goods_img1}" width="400">
			</div>
			<div class="item-detail">
				<form id="goods_cart">
					<input type="hidden" name="goods_num" value="${goods.goods_num}" id="goods_num">
					<input type="hidden" name="goods_price" value="${goods.goods_price}" id="goods_price">
					<input type="hidden" name="goods_quantity" value="${goods.goods_quantity}" id="goods_quantity">
					<ul>
						<li>
							가격 : <b><fmt:formatNumber value="${goods.goods_price}"/></b>
						</li>
						<li>
							재고 : <span><fmt:formatNumber value="${goods.goods_quantity}"/></span>
						</li>
						<c:if test="${goods.goods_quantity > 0}">
						<li>
							<label for="cart_quantity">구매수량</label>
							<input type="number" name="cart_quantity" min="1" max="${goods.goods_quantity}"
								   autocomplete="off" id="cart_quantity" class="quantity-width">
						</li>
						<li>
							<span id="item_total_txt">총주문 금액 : 0원</span>
						</li>
						<li>
							<input type="submit" value="장바구니에 담기">
						</li>
						</c:if>
						<c:if test="${goods.goods_quantity == 0}">
						<li class="align-center">
							<span class="sold-out">품절</span>
						</li>
						</c:if>
					</ul>
				</form>
			</div>
			<hr size="1" noshade="noshade" width="100%">
			<p>
				${goods.goods_info}
			</p>
			
			<div class="content-main">
				<ul class="detail-sub">
				<li>
					<%-- 좋아요 --%>
					<img id="output_like" data-num="${goods.goods_num}"
					  src="${pageContext.request.contextPath}/images/fav01.gif" width="50">
					좋아요
					<span id="output_lcount"></span>                                         
				</li>
				</ul>
			</div>
			<!-- 댓글시작 -->
		<div id="reply_div">
			<span class="re-title">댓글 달기</span>
			<form id="re_form">
				<input type="hidden" name="goods_num" value="${goods.goods_num}" id="goods_num">
				<!--<div class="rating">
					<label><input type="radio" name="re_rating" value="1" id="rating1"> 1점	</label>
					<label><input type="radio" name="re_rating" value="2" id="rating2"> 2점	</label>
					<label><input type="radio" name="re_rating" value="3" id="rating3"> 3점	</label>
					<label><input type="radio" name="re_rating" value="4" id="rating4"> 4점	</label>
					<label><input type="radio" name="re_rating" value="5" id="rating5"> 5점	</label>
				</div>  -->
				<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content"
				<c:if test="${empty user_num}">disabled="disabled"</c:if>
				><c:if test="${empty user_num}">로그인해야 작성할 수 있습니다.</c:if></textarea>
				<c:if test="${!empty user_num}">
				<div id="re_first"> 
					<span class="letter-count">300/300</span>
				</div>
				<div id="re_second" class="align-right">
					<input type="submit" value="전송">
				</div>
				</c:if>
			</form>
		</div>
		<!-- 댓글 목록 출력 시작 -->
		<div id="output"></div>
		<div class="paging-button" style="display:none;">
			<input type="button" value="다음글 보기">
		</div>
		<div id="loading" style="display: none;">
			<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
		</div>		
		<!-- 댓글 목록 출력 끝 -->
		<!-- 댓글끝 -->
			
			
		</c:if>
	</div>
</div>
</body>
</html>