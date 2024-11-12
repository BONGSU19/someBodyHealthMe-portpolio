package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.controller.Action;

public class RegisterUserFormAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // JSP 페이지로 이동 경로 반환
        return "member/registerUserForm.jsp";
    }
}