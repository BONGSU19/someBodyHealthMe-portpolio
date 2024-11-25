package kr.mydiet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

import kr.controller.Action;
import kr.mydiet.dao.DietPlanDAO;
import kr.mydiet.vo.DietPlanVO;

public class NoteDietSearchAction implements Action {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 클라이언트에서 보낸 검색어(keyword) 파라미터를 받음
        String keyword = request.getParameter("keyword");

        // 검색어가 존재하는지 확인
        if (keyword != null && !keyword.trim().isEmpty()) {
            // DietPlanDAO 객체 생성하여 데이터베이스에서 검색
            DietPlanDAO dao = new DietPlanDAO();
            List<DietPlanVO> foodList = dao.searchFood(keyword);

            // 검색 결과를 HTML로 생성
            StringBuilder htmlResponse = new StringBuilder();
            if (foodList.isEmpty()) {
                htmlResponse.append("<li>검색 결과 없음</li>");
            } else {
                for (DietPlanVO food : foodList) {
                    htmlResponse.append("<li class='food-item' data-id='")
                                .append(food.getDietId())
                                .append("'>")
                                .append(food.getFoodName())
                                .append("</li>");
                }
            }

            // 응답으로 HTML 전송
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write(htmlResponse.toString());
            out.flush();
        } else {
            // 검색어가 없을 경우 빈 결과 반환
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write("<li>검색 결과 없음</li>");
            out.flush();
        }

        // JSP로 포워딩하지 않음. AJAX 요청은 HTML 응답을 받으므로 반환값 없음
        return null; 
    }
}
