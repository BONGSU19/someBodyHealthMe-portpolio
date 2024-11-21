package kr.appl.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.appl.dao.ApplDAO;
import kr.appl.vo.ApplVO;
import kr.controller.Action;

public class DeleteAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Long user_num = (Long)session.getAttribute("user_num");
		if(user_num == null) {//비로그인
			return "redirect:/member/loginForm.do";
		}
		long appl_num = Long.parseLong(request.getParameter("appl_num"));
		ApplDAO dao = ApplDAO.getInstance();
		ApplVO db_appl = dao.getAppl(appl_num);
		if(db_appl.getUser_num() != user_num) {//작성자 삭제자 다른 경우
			return "common/notice.jsp";
		}
		if(db_appl.getAppl_status() != 0) {//관리자가 확인한 경우 삭제하는 척 하면서 appl_status 값만 4로 바꿈
			request.setAttribute("", "관리자가 확인한 지원 정보는 삭제할 수 없습니다.");			
			return "common/alert_view.jsp";
		}
		
		
		
		return null;
	}
}

























