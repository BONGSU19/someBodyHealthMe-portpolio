package kr.mybody.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.mybody.dao.MyBodyDAO;
import kr.mybody.vo.MyBodyStatusVO;

public class MyStatusInsertAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Long user_num = (Long)session.getAttribute("user_num");
		if(user_num==null) {
			//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인이 된 경우
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//자바빈(VO) 생성
		MyBodyStatusVO mybodyStatus = new MyBodyStatusVO();
		mybodyStatus.setHeight(Integer.parseInt(request.getParameter("height")));
		mybodyStatus.setWeight(Integer.parseInt(request.getParameter("weight")));
		mybodyStatus.setAge(Integer.parseInt(request.getParameter("age")));
		mybodyStatus.setGoal(request.getParameter("height"));
		mybodyStatus.setGender(request.getParameter("gender"));
		
		
		MyBodyDAO dao = MyBodyDAO.getInstance();
		dao.insertMyBodyStatus(mybodyStatus);
		
		request.setAttribute("notice_msg", "등록 완료!");
		request.setAttribute("notice_url", request.getContextPath()+"/board/list.do");
		
		return null;
	}

}
