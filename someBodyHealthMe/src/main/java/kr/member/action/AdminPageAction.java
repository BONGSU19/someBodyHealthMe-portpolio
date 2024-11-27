package kr.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.appl.vo.ApplVO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.member.dao.AdminDAO;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class AdminPageAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Long user_num = (Long) session.getAttribute("user_num");

        // 로그인 여부 체크
        if (user_num == null) {
            return "redirect:/member/loginForm.do";
        }

        MemberDAO memberDAO = MemberDAO.getInstance();
        MemberVO member = memberDAO.getUserProfile(user_num);

        // 관리자 권한 체크
        if (member == null || member.getStatus() != 4) {
            request.setAttribute("notice_msg", "잘못된 접근입니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/main/main.do");
            return "common/alert_view.jsp";
        }

        // DAO 호출
        AdminDAO adminDAO = AdminDAO.getInstance();
        List<BoardVO> recentPosts = adminDAO.getRecentPosts();
        List<ApplVO> recentApplications = adminDAO.getRecentApplications();

        // JSP로 데이터 전달
        request.setAttribute("recentPosts", recentPosts);
        request.setAttribute("recentApplications", recentApplications);
        request.setAttribute("member", member);

        return "member/adminPage.jsp";
    }
}
