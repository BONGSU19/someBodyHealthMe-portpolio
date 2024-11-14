package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class LoginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        String loginId = request.getParameter("login_id");
        String password = request.getParameter("password");

        MemberDAO dao = MemberDAO.getInstance();
        MemberVO member = dao.checkLogin(loginId, password);

        if (member != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user_num", member.getUser_num());
            session.setAttribute("user_name", member.getName());
            session.setAttribute("status", member.getStatus());

            // JavaScript를 직접 출력하여 alert와 페이지 이동을 처리
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>");
            response.getWriter().write("alert('" + member.getName() + "님, 환영합니다!');");
            response.getWriter().write("location.href='" + request.getContextPath() + "/main/main.do';");
            response.getWriter().write("</script>");
            return null;
        } else {
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "/member/loginForm.jsp";
        }
    }
}