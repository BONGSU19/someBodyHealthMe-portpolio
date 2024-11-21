$(function(){
	let rowCount = 10;
	let currentPage;
	let count;
	/*================
	 * 댓글 목록
	 *================*/
	//댓글 목록 
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩 이미지 노출
		$('#loading').show();
		//서버와 통신
		
	}
	
	/*=======================
	 * 댓글 등록
	 *=======================*/
	//댓글 등록 이벤트 연결
	$('#re_form').submit(function(event){
		if($('#re_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#re_content').val('').focus();
			return false;
		}
		//form 이하의 태그에 입력한 값 모두 읽어 쿼리 스트링으로 반환
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'writeReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//댓글 작성 성공 시 등록글 포함 목록을 보여줌
					//selectList(1);
				}else{
					alert('댓글 등록 오류 발생');
				}
			},error:function(){
				alert('네트워크 오류 발생');
			}			
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	
	//작성 폼 초기화 함수
	function initForm(){
		$('textarea').val('');
		$('#re_count').text('300/300');
	}
	
	/*==================
  	 댓글 등록 & 수정 공통	
	*===================*/
	$(document).on('keyup','textarea',function(){
		//글자수 구하기
		let inputLegnth = $(this).val().length;
		
		if(inputLegnth>300){//300자 초과 뒷자리 잘라버림
			$(this).val($(this).val().substring(0,300));						
		}else{//초과 전
			let remain = 300 - inputLegnth;
			remain += '/300';
			if($(this).attr('id') == 're_content'){
				//등록폼 글자수
				$('#re_count').text(remain);
			}else{
				$('#mre_count').text(remain);
			}
		}		
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});















