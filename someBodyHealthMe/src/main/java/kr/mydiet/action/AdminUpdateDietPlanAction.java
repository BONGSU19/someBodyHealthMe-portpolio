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

        // 알림 메시지와 이동 URL 설정
        request.setAttribute("notice_url", request.getContextPath() + "/mydiet/adminDietPlan.do");
        request.setAttribute("notice_msg", "업데이트가 완료되었습니다.");
        

        // alert_view.jsp로 포워딩
        return "common/alert_view.jsp";
    }
}
