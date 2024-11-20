package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class UpdateProfileAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Long userNum = (Long) session.getAttribute("user_num");

        if (userNum == null) {
            return "redirect:/member/loginForm.do";
        }

        // 사용자 입력값 가져오기
        String nickName = request.getParameter("nick_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String birthDate = request.getParameter("birth_date");

        // MemberVO에 필요한 데이터만 설정
        MemberVO member = new MemberVO();
        member.setUser_num(userNum);

        if (nickName != null && !nickName.trim().isEmpty()) {
            member.setNick_name(nickName);
        }
        if (email != null && !email.trim().isEmpty()) {
            member.setEmail(email);
        }
        if (phone != null && !phone.trim().isEmpty()) {
            member.setPhone(phone);
        }
        if (birthDate != null && !birthDate.trim().isEmpty()) {
            member.setBirth_date(birthDate);
        }

        // DAO를 통한 동적 업데이트 처리
        MemberDAO dao = MemberDAO.getInstance();
        dao.updateUserProfileDynamic(member);

        return "redirect:/member/myPage.do";
    }
}