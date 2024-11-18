package kr.appl.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.appl.dao.ApplDAO;
import kr.appl.vo.ApplVO;
import kr.controller.Action;

public class ListAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		Long user_num = (Long)session.getAttribute("user_num");
		Integer status = (Integer)session.getAttribute("status");
		
		if(user_num == null) {
			return "redirect:member/loginForm.do";
		}
		if(status < 3) {//사무직, 최종관리자가 아닌 경우
			return "common/notice.jsp";
		}
		
		String name = request.getParameter("name");
		int appl_status = Integer.parseInt(request.getParameter("appl_status"));
		int field = Integer.parseInt(request.getParameter("field"));
		int career = Integer.parseInt(request.getParameter("career"));
		int appl_center = Integer.parseInt("appl_center");
		
		
		
		ApplDAO dao = ApplDAO.getInstance();
		int count = dao.getApplicationCount(name, appl_status, field, career, appl_center);
		
		List<ApplVO> list = null;
		if(count > 0) {
			list = dao.getListByAdmin(name, appl_status, field, career, appl_center);
		}
		
		
 		
		return null;
	}
}









