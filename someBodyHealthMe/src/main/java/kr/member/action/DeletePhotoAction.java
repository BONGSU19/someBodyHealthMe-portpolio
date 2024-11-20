package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;

public class DeletePhotoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Long userNum = (Long) session.getAttribute("user_num");

        if (userNum == null) {
            return "redirect:/member/loginForm.do";
        }

        MemberDAO dao = MemberDAO.getInstance();
        dao.deleteUserPhoto(userNum);

        return "redirect:/member/myPage.do";
    }
}