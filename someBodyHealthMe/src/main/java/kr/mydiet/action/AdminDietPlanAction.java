package kr.mydiet.action;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.mydiet.dao.DietPlanDAO;
import kr.mydiet.vo.DietPlanVO;

public class AdminDietPlanAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DietPlanDAO dao = DietPlanDAO.getInstance();

        // 모든 DietPlan 데이터 가져오기
        List<DietPlanVO> dietPlans = dao.getAllDietPlans();
        request.setAttribute("dietPlans", dietPlans);

        return "mydiet/adminDietPlan.jsp";
    }
}
