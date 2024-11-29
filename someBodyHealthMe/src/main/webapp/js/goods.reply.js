$(function(){
	let rowCount =10;
	let currentPage;
	let count;
	/*===========================
		 댓글 목록
	================================*/
	//댓글목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩 이미지 노출
		$('#loading').show();
		//서버와 통신
		$.ajax({
			url:'listReply.do',
			type : 'post',
			data:{pageNum:pageNum, rowCount:rowCount, goods_num:$('#goods_num').val(), status:$('#status').val()},
			dataType :'json',
			success:function(param){
				//로딩 이미지 감추기
				$('#loading').hide();
				count = param.count;
				
				if(pageNum==1){
					//처음 호출시는 해당 id 의 div 내부 내용물을 제거
					$('#output').empty();
				}
				$(param.list).each(function(index,item){
					let output ='<div class = "item">';
					output += '<h4>' + item.nick_name + '</h4>';
					output += '<div class ="sub-item">';
					output += '<p>' + item.re_content + '</p>';
					if(item.re_mdate){
						output += '<span class="modify-date">최근 수정일: ' + item.re_mdate + '</span>';
					}else{
						output += '<span class="modify-date">등록일: ' + item.re_date + '</span>';
					}
					
					//로그인한 회원번호와 작성자의 회원번호 일치 여부 체크
					if(param.user_num == item.user_num){
						output += ' <input type ="button" data-renum="'+item.re_num+'" value="수정" class="modify-btn">';						
						output += ' <input type ="button" data-renum="'+item.re_num+'" value="삭제" class="delete-btn">';
					}else if(param.user_num == 26){
						output += ' <input type ="button" data-renum="'+item.re_num+'" value="삭제" class="delete-btn">';
					}
					output += '<hr size="1" noshade width="100%">';
					output += '</div>';
					output += '</div>';
					
					//문서객체에 추가
					$('#output').append(output);

					});//end of each
					
					//page button 처리
					if(currentPage>=Math.ceil(count/rowCount)){
						//다음 페이지가 없음
						$('.paging-button').hide();
					}else{
						//다음 페이지가 존재
						$('.paging-button').show();
					}
					
					// isReviewed 값에 따라 댓글 작성 폼 비활성화
					if (param.isReviewed || !param.user_num || !param.checkBuy) {
					                $('#re_content').prop('disabled', true); // 댓글을 작성할 수 없는 경우
					                $('#re_content').attr('placeholder', '이미 리뷰를 작성하셨거나 구매 후 댓글을 작성할 수 있습니다.');
					            } else {
					                $('#re_content').prop('disabled', false); // 댓글을 작성할 수 있는 경우
					                $('#re_content').attr('placeholder', '리뷰를 입력하세요');
					            }
					
					
			},
			error:function(){
				$('#loading').hide();
				alert('네트워크 오류발생1');
			}
			
		});
	}
	//페이지 처리 이벤트 연결(다음 댓글 보기 버튼 클릭시 데이터 추가)
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	});
	
	/*===========================
	* 댓글 등록
	================================*/
	//댓글 등록 이벤트 연결
	
	$('#re_form').submit(function(event){
		if($('#re_content').val().trim()==''){
			alert('내용을 입력하세요!');
			$('#re_content').val('').focus();
			return false;
		}
		//form 이하의 태그에 입력한 데이터를 모두 읽어서 쿼리 스트링으로 반환
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'writeReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 작성할 수 있습니다.')
				}else if(param.result=='success'){
					//폼 초기화
					initForm();
					//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의 게시글 목록을 다시 호출함 
					selectList(1);
				}else{
					alert('댓글 등록 오류 발생');
				}
			},error:function(){
				alert('평점을 선택하세요');
			}
		});
		//기본이벤트 제거
		event.preventDefault();
	});
	//댓글 작성 폼 초기화 
	function initForm(){
		$('textarea').val('');
		$('#re_first.letter-count').text('300/300');
	}
	/*===========================
		* 댓글 수정
	================================*/
	// 댓글 수정 버튼 클릭시 수정폼 노출
	    $(document).on('click','.modify-btn',function(){
	        // 댓글 번호
	        let re_num = $(this).attr('data-renum');
	        // 댓글 내용
	        let content = $(this).parent().find('p').html().replace(/<br>/gi, '\n'); 
	                                                                // g:지정문자열 모두 , i: 대소문자 무시
			let rating = $(this).parent().find('.rating-value').data('rating'); // 예시로 평점을 value로 가져왔다고 가정
	        // 댓글 수정폼 UI
	        let modifyUI = '<form id="mre_form">';
	        modifyUI += '<input type ="hidden" name="re_num" id="mre_num" value="'+re_num+'">';
			modifyUI += '<div class="rating-value">';
			for(let i = 1; i <= 5; i++){
				modifyUI += '<label><input type="radio" name="re_rating" value="'+i+'" id="rating'+i+'"';	
				if (i == rating) {
				    modifyUI += ' checked'; // 기존 평점과 일치하는 라디오 버튼을 체크
				}
				modifyUI += '> '+i+'점 </label>';
			}
			modifyUI += '</div>'; 
			
	        modifyUI += '<textarea rows="3" cols="50" name="re_content" id="mre_content" class="rep-content">'+content+'</textarea>';
	        modifyUI += '<div id="mre_first"><span class="letter-count">300/300</span></div>';
	        modifyUI += '<div id="mre_second" class="align-right">';
	        modifyUI += ' <input type="submit" value="수정">';
	        modifyUI += ' <input type="button" value="취소" class="re-reset">';
	        modifyUI += "</div>";
	        modifyUI += '<hr size="1" noshade width="96%">';
	        modifyUI += '</form>';
	        
			//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면 숨김 sub-item 클래스로 지정한 dic를 환원시키고 수정폼을 제거
			initModifyForm();
			
	        // 지금 클릭해서 수정하고자하는 데이터는 감추기 수정버튼을 감싸고 있는 div
	        $(this).parent().hide();
	        
	        // 수정폼을 수정하고자 하는 데이터가 있는 div에 노출
	        $(this).parents('.item').append(modifyUI);
	        
			//입력한 글자수 셋팅
			let inputLength = $('#mre_content').val().length;
			let remain = 300 -inputLength;
			remain += '/300';
			//문서 객체에 반영
			$('#mre_first .letter-count').text(remain);
	        
	    });

	    // 댓글 수정폼 초기화
	    function initModifyForm(){
	        $('.sub-item').show();
	        $('#mre_form').remove();
	    }
	    
	    // 수정폼에서 취소 버튼 클릭시 수정폼 초기화
	    $(document).on('click','.re-reset',function(){
	        initModifyForm();
	    });
	    // 댓글수정
		$(document).on('submit', '#mre_form', function(event){
			if($('#mre_content').val().trim()==''){
				alert('내용을 입력하세요!');
				$('#mre_content').val('').focus();
				return false;
			}
			//폼에 입력한 데이터 반환
			let form_data = $(this).serialize();
			
			let selectedRating = $('input[name="re_rating"]:checked').val();
			if (selectedRating) {
			    form_data = form_data.replace(/re_rating=[^&]*/, 're_rating=' + selectedRating);  // 기존 re_rating을 새로운 값으로 교체
			} else {
			    alert("평점을 선택해주세요!");
			    return false;
			}
			
			//서버와 통신
			$.ajax({
				url:'updateReply.do',
				type:'post',
				data:form_data,
				dataType:'json',
				success:function(param){
					if(param.result =='logout'){
						alert('로그인해야 수정할 수 있습니다.');
					}else if(param.result == 'success'){
						$('#mre_form').parent().find('p').html(
							$('#mre_content').val().replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\n/g, '<br>'));
							$('#mre_form').parent().find('.modify-date').text('최근 수정일 : 5초미만');
							//수정폼 삭제 및 초기화
							initModifyForm();
					}else if(param.result == 'wrongAccess'){
						alert('타인의 글을 수정할 수 없습니다.');
					}else{
						alert('댓글 수정 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생3');
				}
			});
			//기본이벤트 제거
			event.preventDefault();
		});
	
	/*===========================
		* 댓글 등록 및 수정 공통(textarea에 내용 입력시 글자수 체크)
	================================*/	
	$(document).on('keyup', 'textarea', function(){
		//입력한 글자수 구함
		let inputLength = $(this).val().length;
		
		if(inputLength>300){//300자가 넘어선 경우
			$(this).val($(this).val().substring(0,300));
		}else{//300자 이하인경우
			let remain = 300 - inputLength;
			remain +='/300';
			if($(this).attr('id') == 
			're_content'){
				//등록폼 글자수
				$('#re_first .letter-count').text(remain);
			}else{
				//수정폼 글자수
				$('#mre_first .letter-count').text(remain);
			}
		}
	});
	/*===========================
			* 댓글 삭제
	================================*/
	$(document).on('click','.delete-btn',function(){
		//댓글번호
		let re_num = $(this).attr('data-renum');
		//서버와 통신
		$.ajax({
			url: 'deleteReply.do',
			type:'post',
			data:{re_num:re_num},
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('삭제완료!');
					selectList(1);
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{
					alert('댓글 삭제 오류 발생!');
				}
			},
			error:function(){
				alert('네트워크 오류 발생4');
			}
		});
	});
	
	$(document).ready(function(){
	    // 페이지가 로드될 때 서버에서 평균 rating 값을 가져와서 표시
	    $.ajax({
	        url: 'getAverageRating.do',  // 평균 점수를 가져오는 서버의 URL
	        type: 'post',
	        data: {goods_num: $('#goods_num').val()},
	        dataType: 'json',
	        success: function(param) {
	            if (param.result == 'success') {
	                $('#avg_rating_value').text(param.avg_rating.toFixed(1));  // 평균값 소수점 한 자리까지 표시
	            } else {
	                $('#avg_rating_value').text('없음');
	            }
	        },
	        error: function() {
	            alert('평균 점수 로딩 오류');
	        }
	    });
	});
	
	
		
	/*===========================
		* 초기 데이터(목록) 호출
	================================*/
	selectList(1);
	
	
	
});