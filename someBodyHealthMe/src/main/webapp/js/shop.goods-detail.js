$(function(){
	/* ======================
	 * 주문수량 변경
	 * ====================== */
	$('#cart_quantity').on('input',function(){
		if($('#cart_quantity').val()==''){
			$('#item_total_txt').text('총주문 금액 : 0원');
			return;
		}
		if($('#cart_quantity').val() <= 0){
			$('#cart_quantity').val('');
			$('#item_total_txt').text('총주문 금액 : 0원');
			return;
		}
		if(Number($('#goods_quantity').val()) < $('#cart_quantity').val()){
			alert('수량이 부족합니다.');
			$('#cart_quantity').val('');
			$('#item_total_txt').text('총주문 금액 : 0원');
			return;
		}
		let total = $('#goods_price').val() * $('#cart_quantity').val();
		$('#item_total_txt').text('총주문 금액 : ' + total.toLocaleString()+'원');
	});
});