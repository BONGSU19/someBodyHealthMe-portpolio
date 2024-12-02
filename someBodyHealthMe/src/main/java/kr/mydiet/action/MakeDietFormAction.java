// src/main/java/kr/mydiet/action/MakeDietFormAction.java
package kr.mydiet.action;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.mydiet.dao.MealLogDAO;
import kr.mydiet.vo.MealLogVO;

public class MakeDietFormAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 요청 인코딩 설정
        request.setCharacterEncoding("UTF-8");

        // 로그인한 사용자의 USER_NUM을 세션에서 가져옴
        Integer userNum = (Integer) request.getSession().getAttribute("USER_NUM");
        if (userNum == null) {
            // 로그인되지 않은 사용자라면 로그인 페이지로 리다이렉트
            return "redirect:/login.do";
        }

        // DAO 인스턴스 생성
        MealLogDAO dao = MealLogDAO.getInstance();

        // 사용자 식사 기록 조회
        List<MealLogVO> mealLogs = dao.getMealLogsByUser(userNum);

        // 식사 타입별로 그룹화
        List<MealLogVO> breakfastLogs = new ArrayList<>();
        List<MealLogVO> lunchLogs = new ArrayList<>();
        List<MealLogVO> dinnerLogs = new ArrayList<>();
        List<MealLogVO> snackLogs = new ArrayList<>();

        for (MealLogVO meal : mealLogs) {
            switch (meal.getMealType()) {
                case "아침":
                    breakfastLogs.add(meal);
                    break;
                case "점심":
                    lunchLogs.add(meal);
                    break;
                case "저녁":
                    dinnerLogs.add(meal);
                    break;
                case "간식":
                    snackLogs.add(meal);
                    break;
                default:
                    // 기타 식사 타입 처리 (필요 시 추가)
                    break;
            }
        }

        // JSP에 전달하기 위해 request에 저장
        request.setAttribute("breakfastLogs", breakfastLogs);
        request.setAttribute("lunchLogs", lunchLogs);
        request.setAttribute("dinnerLogs", dinnerLogs);
        request.setAttribute("snackLogs", snackLogs);

        // JSP 페이지 경로 반환
        return "mydiet/makeDietForm.jsp";
    }
}
