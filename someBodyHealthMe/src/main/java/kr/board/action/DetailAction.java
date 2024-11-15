package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;

public class DetailAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//상세페이지 글 번호
		Long board_num = Long.parseLong(request.getParameter("board_num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		
		dao.updateReadCount(board_num);//조회수 증가
		BoardVO board = dao.getBoard(board_num);//데이터 가져오기
	
		
		request.setAttribute("board", board);
		
		//할 작업 : 조회수 증가 ,제목, 내용 -> html 불허, 수정했으면 수정일로 변경(jsp)
		
		
		
		return "/board/detail.jsp";
	}
}
