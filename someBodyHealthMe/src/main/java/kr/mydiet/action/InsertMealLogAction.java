package kr.mydiet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.mydiet.dao.DietPlanDAO;
import kr.mydiet.dao.MealLogDAO;
import kr.mydiet.vo.DietPlanVO;
import kr.mydiet.vo.MealLogVO;

public class InsertMealLogAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 세션에서 user_num을 가져오기
        HttpSession session = request.getSession();
        Long user_num = (Long) session.getAttribute("user_num");

        if (user_num == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/member/loginForm.do";
        }

        // 요청 인코딩 설정
        request.setCharacterEncoding("utf-8");

        // 사용자 입력 값 받아오기
        String dietIdStr = request.getParameter("dietId");
        String mealType = request.getParameter("mealType");

        if (dietIdStr == null || mealType == null || dietIdStr.isEmpty() || mealType.isEmpty()) {
            request.setAttribute("notice_msg", "필수 정보를 모두 입력해주세요.");
            request.setAttribute("notice_url", request.getContextPath() + "/mydiet/selectCustomDiet.do");
            return "common/alert_view.jsp";
        }

        long dietId;
        try {
            dietId = Long.parseLong(dietIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("notice_msg", "유효하지 않은 식단 ID입니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/mydiet/selectCustomDiet.do");
            return "common/alert_view.jsp";
        }

        // DietPlanDAO를 통해 dietId에 해당하는 DietPlanVO 가져오기
        DietPlanDAO dietPlanDAO = DietPlanDAO.getInstance();
        DietPlanVO dietPlan = dietPlanDAO.getDietPlanById(dietId);

        if (dietPlan == null) {
            // 유효하지 않은 dietId인 경우
            request.setAttribute("notice_msg", "유효하지 않은 식단 ID입니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/mydiet/selectCustomDiet.do");
            return "common/alert_view.jsp";
        }

        String foodName = dietPlan.getFoodName();

        // MealLogVO 객체 생성
        MealLogVO mealLog = new MealLogVO();
        mealLog.setFoodName(foodName);
        mealLog.setMealType(mealType);
        mealLog.setUserNum(user_num);

        // MealLogDAO를 통해 데이터베이스에 저장
        MealLogDAO mealLogDAO = MealLogDAO.getInstance();
        try {
            mealLogDAO.insertMealLog(mealLog);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notice_msg", "식단 추가 중 오류가 발생했습니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/mydiet/makeDietForm.do");
            return "common/alert_view.jsp";
        }

        // 완료 메시지 설정
        request.setAttribute("notice_msg", "식단이 성공적으로 추가되었습니다!");
        request.setAttribute("notice_url", request.getContextPath() + "/mydiet/makeDietForm.do");

        return "common/alert_view.jsp";
    }
}
