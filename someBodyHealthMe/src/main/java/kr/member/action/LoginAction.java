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

        // 입력받은 로그인 ID와 비밀번호를 가져옴
        String loginId = request.getParameter("login_id");
        String password = request.getParameter("password");

        MemberDAO dao = MemberDAO.getInstance();
        MemberVO member = dao.checkLogin(loginId, password);

        if (member != null) { // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("user", member); // 세션에 사용자 정보 저장
            return "redirect:/main/main.do"; // 메인 페이지로 리디렉션
        } else { // 로그인 실패
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "member/loginForm.jsp"; // 로그인 페이지로 다시 이동
        }
    }
}