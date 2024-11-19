package kr.appl.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.appl.dao.ApplDAO;
import kr.appl.vo.ApplVO;
import kr.controller.Action;
import kr.util.PagingUtil;

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
		
		//페이지 처리
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null)pageNum = "1";
		
		
		String name = request.getParameter("name");
		int appl_status=0;
		int field = 2;
		int career = 1;
		int appl_center =1;
				
		
		
		
		ApplDAO dao = ApplDAO.getInstance();
		int count = dao.getApplicationCount(name, appl_status, field, career, appl_center);
		
		//페이지 처리(페이지번호, 갯수, 한페이지, 다음 나오는 페이지, url)
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum), count, 1,1,"listByAdmin.do");
		//목록 담기
		List<ApplVO> list = null;
		if(count > 0) {
			list = dao.getListByAdmin(page.getStartRow(),page.getEndRow(),name, appl_status, field, career, appl_center);
		}
		System.out.println(1);
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());		
		
		//JSP 경로 반환/
		return "appl/listByAdmin.jsp";
	}
}






















