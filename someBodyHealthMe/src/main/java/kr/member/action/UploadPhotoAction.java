package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;

import java.io.File;

public class UploadPhotoAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Long user_num = (Long) session.getAttribute("user_num");
        Integer status = (Integer) session.getAttribute("status");

        // 로그인 여부 확인
        if (user_num == null || status == null) {
            return "redirect:/member/loginForm.do";
        }

        // 파일 업로드 처리
        String uploadPath = request.getServletContext().getRealPath("/upload");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // 디렉토리가 없으면 생성
        }

        // 업로드된 파일 가져오기
        String fileName = request.getPart("photo").getSubmittedFileName();
        File uploadFile = new File(uploadPath, fileName);

        request.getPart("photo").write(uploadFile.getAbsolutePath());

        // DB에 업로드된 파일 정보 저장
        MemberDAO dao = MemberDAO.getInstance();
        dao.updateUserPhoto(user_num, fileName);

        // 권한에 따른 리다이렉션
        if (status == 4) { // 마스터 관리자
            return "redirect:/member/adminPage.do";
        } else if (status == 2 || status == 3) { // 매니저(사무직, 트레이너)
            return "redirect:/member/managerPage.do";
        } else if (status == 1) { // 일반 사용자
            return "redirect:/member/myPage.do";
        } else {
            // 예기치 않은 접근
            request.setAttribute("notice_msg", "잘못된 요청입니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/main/main.do");
            return "common/alert_view.jsp";
        }
    }
}