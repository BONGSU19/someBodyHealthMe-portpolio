package kr.appl.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.appl.dao.ApplDAO;
import kr.controller.Action;

public class UpdateStatusAction implements Action{//관리자로 전환하기
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Long user_num = (Long)session.getAttribute("user_num");
		Integer status = (Integer)session.getAttribute("status");
		
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:member/loginForm.jsp";
		}
		if(status < 3) {
			return "/common/notice.jsp";
		}
		//전송된 데이터 인코딩처리
		request.setCharacterEncoding("utf-8");
		Integer appl_status =  Integer.parseInt(request.getParameter("appl_num"));
		String name = request.getParameter("name");
		
		ApplDAO dao = ApplDAO.getInstance();
		dao.updateStatus(user_num, appl_status);
		
		request.setAttribute("notice_msg", name + "님이 관리자로 전환되었습니다.");
		request.setAttribute("notice_url", 
				 request.getContextPath()+"/appl/list.do");		
		
		return "common/alert_view.jsp";
		
	}
}





















