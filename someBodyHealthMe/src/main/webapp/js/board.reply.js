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
		$.ajax({
			url:'listReply.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,board_num:$('#board_num').val()},
			dataType:'json',
			success:function(param){
				//로딩 이미지 숨김
				$('#loading').hide();
				count = param.count;
				
				if(pageNum==1){
					//처음 호출 시 댓글 이전 목록 제거
					$('#output').empty();
				}
				
				if(param.count == 0){
									let output = "<div> 등록된 댓글이 없습니다.</div>";
									$('#output').append(output);
								}
								
				
				$(param.list).each(function(index,item){
					let output =  '<div class="item">';
					output += '<div class="re-profile">';
					output += '<img src="#" >';
					output += '<span>' + item.nick_name +'</span>';
					output += '</div>';
					output += '<p>' + item.re_content +'</p>' ;
				    output += '</div>';
					output += '<div class="re-date">';
			
				    if(item.re_modifydate){
						output += '<span class="modify-date">최근 수정일 : ' + item.re_modifydate + '</span>';
					}else{
						output += '<span class="modify-date">등록일 : ' + item.re_regdate + '</span>';
					}
											
					//로그인한 회원번호와 작성자의 회원번호 일치 여부 체크
					if(param.user_num == item.user_num){
						//로그인한 회원번호와 작성자 회원번호 일치
						output += ' <input type="button" data-renum="'+item.re_num+'" value="수정" class="modify-btn">';
						output += ' <input type="button" data-renum="'+item.re_num+'" value="삭제" class="delete-btn">';
					}																
					output += "</div>";
					output += "<hr>";
					
					//댓글 삽입
					$('#output').append(output);
				});
				//페이지 버튼 처리
				if(currentPage>=Math.ceil(count/rowCount)){
				//다음 페이지가 없음
					$('.paging-button').hide();
				}else{
				//다음 페이지가 존재
					$('.paging-button').show();
				}				
			},error:function(){
				$('#loading').hide();
				alert('네트워크 오류 발생');
			}			
		});		
	}
	//페이지 처리 이벤트 연결(다음 댓글 보기 버튼 클릭시 데이터 추가)
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	});
	
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/* ================================
	 * 초기 데이터(목록) 호출
	 * ================================ */	
	selectList(1);	
	
	
});















