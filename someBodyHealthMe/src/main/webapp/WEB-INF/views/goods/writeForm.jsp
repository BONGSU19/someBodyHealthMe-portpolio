<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/IJ.css" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		$(function(){
			//상품 등록 유효성 체크
			$('#write_form').submit(function(){
				const radio = document.querySelectorAll('input[type=radio]:checked');
				if(radio.length<1){
					alert('상품표시여부를 지정하세요!');
					return false;
				}
				
				
				const items = document.querySelectorAll('.input-check');
				for(let i=0; i<items.length;i++){
					if(items[i].value.trim()==''){
						const label = document.querySelector('label[for="'+items[i].id+'"]');
						alert(label.textContent + ' 필수입력');
						items[i].value='';
						$(items[i]).focus();
						return false;
					}
				}//end of for
			});
		});
	
	</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="content-main">
			<h2>상품 등록</h2>
			<form id="write_form" action="write.do" enctype="multipart/form-data" method="post">
				<ul>
					<li>
					<label>상품표시여부</label> 
					<input type="radio" name="goods_status" value="1" id="status1">미표시
					<input type="radio" name="goods_status" value="2" id="status2">표시
					<li>
					<label for="goods_name">상품명</label> 
					<input type="text" name="goods_name" id="goods_name" maxlength="10" class="input-check">
					</li>
					<li>
					<label for="goods_category">카테고리</label> 
					<input type="text" name="goods_category" id="goods_category" maxlength="30" class="input-check">
					</li>
					<li>
					<label for="goods_price">가격</label> 
					<input type="number" name="goods_price" id="goods_price" min="1" max="999999999" class="input-check">
					</li>
					<li>
					<label for="goods_quantity">수량</label> 
					<input type="number" name="goods_quantity" id="goods_quantity" min="0" max="9999999" class="input-check">
					</li>
					<li>
					<label for="goods_img1">상품사진1</label>
					<input type="file" name="goods_img1" id="goods_img1" accept="image/gif,image/png,image/jpeg" class="input-check">
					</li>
					<li>
					<label for="goods_img2">상품사진2</label>
					<input type="file" name="goods_img2" id="goods_img2" accept="image/gif,image/png,image/jpeg">
					<li>
					<label for="goods_info">상품설명</label> 
					<textarea rows="5" cols="30" name="goods_info" id="goods_info" class="input-check"></textarea>
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="등록"> 
					<input type="button" value="목록" onclick="location.href='list.do'">
				</div>
			</form>
		</div>
	</div>
</body>
</html>


