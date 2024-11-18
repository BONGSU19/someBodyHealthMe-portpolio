package kr.board.action;
//파일업로드 수정해야함
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;

public class UpdateAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Long user_num = (Long)session.getAttribute("user_num");
		
		if(user_num == null) {//비로그인
			return "redirect:member/loginForm.do";
		}
		//로그인시
		//전송된 데이터 인코딩
		request.setCharacterEncoding("utf-8"); 
		//글번호 반환
		long board_num = Long.parseLong(request.getParameter("board_num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardVO db_board = dao.getBoard(board_num);
		
		//등록자 수정자 동일인 체크
		if(db_board.getUser_num() != user_num) {
			return "common/notice.jsp";
		}
		//수정할 내용(vo) 세팅
		BoardVO board = new BoardVO();
		board.setBoard_title(request.getParameter("board_title"));
		board.setBoard_content(request.getParameter("board_content"));
		board.setBoard_attachment(request.getParameter("board_attachment"));
		board.setBoard_num(board_num);
		
		dao.updateBoard(board);
		
		return "redirect:/board/detail.do?board_num=" + board_num;
	}
}














