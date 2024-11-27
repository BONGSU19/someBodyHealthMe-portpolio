package kr.mydiet.action;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.mydiet.dao.DietPlanDAO;
import kr.mydiet.vo.DietPlanVO;

public class SelectCustomDietAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // DIET_SHOW가 0인 식단 목록 조회
        DietPlanDAO dao = DietPlanDAO.getInstance();
        List<DietPlanVO> dietList = dao.selectDietPlansWithDietShowZero();  // 해당 메서드 호출

        // 조회된 식단 목록을 request에 저장
        request.setAttribute("dietList", dietList);

        // selectCustomDiet.jsp로 포워딩
        return "mydiet/selectCustomDiet.jsp";  // JSP 페이지로 포워딩
    }
}
