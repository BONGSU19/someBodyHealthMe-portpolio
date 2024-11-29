package kr.mydiet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.controller.Action;
import kr.mydiet.dao.DietPlanDAO;

public class RejectDietAction implements Action {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 관리자인지 확인하는 로직 필요

        // 요청 파라미터에서 dietId 가져오기
        long dietId = Long.parseLong(request.getParameter("dietId"));

        // DAO 인스턴스 생성
        DietPlanDAO dietPlanDAO = DietPlanDAO.getInstance();

        // DIET_COMMENT를 3으로 업데이트하여 등록 반려 처리
        try {
            dietPlanDAO.updateDietComment(dietId, 3);
            request.setAttribute("message", "식단이 반려되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "식단 반려 중 오류가 발생하였습니다.");
        }

        // 적절한 페이지로 포워드 또는 리다이렉트
        return "/WEB-INF/views/admin/rejectDietResult.jsp";
    }
}
