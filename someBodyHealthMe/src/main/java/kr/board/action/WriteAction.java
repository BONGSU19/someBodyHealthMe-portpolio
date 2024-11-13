package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.vo.BoardVO;
import kr.controller.Action;

public class WriteAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		HttpSession session = request.getSession();
//		Long user_num = (Long)session.getAttribute("user_num");
//		if(user_num == null) {//로그인인 되지 않은 경우
//			return "redirect:/member/loginForm.do";		
//		}
		
		//로그인이 된 경우
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//VO생성
		BoardVO board = new BoardVO();
		board.setBoard_category(request.getParameter("board_category"));
		board.setBoard_title(request.getParameter("baord_title"));
		//board.setUser_num(user_num);
		
		
		
		return null;
	}
}






















