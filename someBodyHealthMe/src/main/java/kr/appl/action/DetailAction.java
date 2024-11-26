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
		
		Long user_num = (Long)session.getAttribute("user_num");
		if(user_num == null) {//로그인 x
			return "redirect:/member/loginForm.do";
		}
		Integer status = (Integer)session.getAttribute("status");
		
		//지원번호 받기
		long appl_num = Long.parseLong(request.getParameter("appl_num"));		
		
		ApplDAO dao = ApplDAO.getInstance();
		
		//지원번호를 통해 vo 가져오기
		ApplVO appl = new ApplVO();
		appl = dao.getAppl(appl_num);
		
		//열람 조건 체크
		if(status <= 3 && (appl.getUser_num() != user_num)) {//지원자와 열람자가 다르거나 , 관리자가 아니면(접근 권한이 없는 경우)
			return "common/notice.jsp";
		}	
		if(status==4) {
			dao.updateAppl_status(appl_num);//미확인 -> 확인전환
		}
		
		request.setAttribute("appl", appl);		
		return "appl/detail.jsp";
	}
}






