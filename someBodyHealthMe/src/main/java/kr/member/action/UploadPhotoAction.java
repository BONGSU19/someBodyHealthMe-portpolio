package kr.member.action;

import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;

public class UploadPhotoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Long userNum = (Long) session.getAttribute("user_num");

        if (userNum == null) {
            return "redirect:/member/loginForm.do";
        }

        String uploadPath = request.getServletContext().getRealPath("/upload");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String photo = request.getPart("photo").getSubmittedFileName();
        if (photo != null && !photo.isEmpty()) {
            request.getPart("photo").write(uploadPath + "/" + photo);
            MemberDAO dao = MemberDAO.getInstance();
            dao.updateUserPhoto(userNum, photo);
        }

        return "redirect:/member/myPage.do";
    }
}