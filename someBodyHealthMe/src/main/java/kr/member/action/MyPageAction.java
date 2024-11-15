	package kr.member.action;
	
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import javax.servlet.http.HttpSession;
	
	import kr.controller.Action;
	import kr.member.dao.MemberDAO;
	import kr.member.vo.MemberVO;
	
	public class MyPageAction implements Action {
	
	    @Override
	    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        HttpSession session = request.getSession();
	        Long user_num = (Long) session.getAttribute("user_num");
	
	        // 로그인 여부 및 권한 체크
	        if (user_num == null) {
	            return "redirect:/member/loginForm.do";
	        }
	      
	        MemberDAO dao = MemberDAO.getInstance();
	        MemberVO member = dao.getUserProfile(user_num);
	        
	        if (member == null || member.getStatus() != 1) {
	            request.setAttribute("notice_msg", "잘못된 접근입니다.");
	            request.setAttribute("notice_url", request.getContextPath() + "/main/main.do");
	            return "common/alert_view.jsp";
	        }
	        //if(user_num != null && member.getStatus() != 1) { 코드 보류
	        	//return "common/notice.jsp";
	
	        // 사용자 정보를 JSP에 전달
	        request.setAttribute("member", member);
	
	        // JSP 경로 반환 (myPage.jsp로 변경)
	        return "member/myPage.jsp";
	    }
	}