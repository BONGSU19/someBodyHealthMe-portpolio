package kr.mydiet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.mydiet.dao.DietPlanDAO;

public class AdminUpdateDietPlanAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 요청 파라미터 가져오기
        long dietId = Long.parseLong(request.getParameter("dietId"));
        int dietShow = Integer.parseInt(request.getParameter("dietShow"));
        int dietComment = Integer.parseInt(request.getParameter("dietComment"));

        // DAO 인스턴스를 통해 업데이트 수행
        DietPlanDAO dao = DietPlanDAO.getInstance();
        dao.updateDietPlan(dietId, dietShow, dietComment);

        // 관리자 페이지로 리다이렉트
        return "mydiet/dietPlanAdmin.do";
    }
}
