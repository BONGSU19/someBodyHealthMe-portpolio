package kr.appl.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class ListByAdminAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Long user_num = (Long)session.getAttribute("user_num");
		Integer status = (Integer)session.getAttribute("status");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		if(status < 3) {
			return "/common/notice.jsp";
		}
		
		
		
		
		return null;
	}
}






















