package kr.appl.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.appl.dao.ApplDAO;
import kr.appl.vo.ApplVO;
import kr.controller.Action;

public class DetailAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		Long user_num = (Long)request.getAttribute("user_num");
		if(user_num == null) {//로그인 x
			return "redirect:/member/loginForm.do";
		}
		Integer status = (Integer)request.getAttribute("status");
		
		//히든에 지원번호를 넘긴다.
		long appl_num = Long.parseLong(request.getParameter("appl_num"));		
		
		ApplDAO dao = ApplDAO.getInstance();
		
		//지원번호를 통해 vo 가져오기
		ApplVO db_appl = new ApplVO();
		db_appl = dao.getAppl(appl_num);
		
		if(db_appl.getUser_num() != user_num || status<2 ) {//지원자와 열람자가 다르거나 , 관리자가 아니면(접근 권한이 없는 경우)
			return "common/notice.jsp";
		}		
		//관리자가 본 경우 && 관리자이지만 자신의 지원정보가 아닌 경우
		if(status > 2 && user_num != db_appl.getUser_num()) {
			dao.updateAppl_status(appl_num);
		}
		ApplVO appl = dao.getAppl(appl_num);
		request.setAttribute("appl", appl);		
		return "appl/detail.jsp";
	}
}
