package kr.mybody.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.mybody.dao.MyBodyDAO;
import kr.mybody.vo.InbodyStatusVO;
import kr.mybody.vo.MyBodyStatusVO;

public class MyStatusModifyFormAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		Long user_num = (Long)session.getAttribute("user_num");
		if(user_num == null) {
			//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		MyBodyDAO dao = MyBodyDAO.getInstance();
		List<InbodyStatusVO> inbodyStatusList = dao.getAllInbodyData(user_num);
		
		request.setAttribute("inbodyStatusList", inbodyStatusList);
		//JSP 경로 반환;
		
		return "mybody/myStatusModifyForm.jsp";
	}
	
}
