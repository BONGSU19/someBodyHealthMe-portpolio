package kr.mydiet.action;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.mydiet.dao.DietPlanDAO;
import kr.mydiet.vo.DietPlanVO;
import kr.util.PagingUtil;

public class NoteDietSearchAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 요청 파라미터에서 검색어(keyword) 가져오기
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";  // 기본값 설정
        }

        // 페이지 관련 파라미터
        String pageNum = request.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";  // 기본 페이지 번호
        }

        // DAO 인스턴스 생성
        DietPlanDAO dao = DietPlanDAO.getInstance();

        // 총 검색된 음식 개수
        int count = dao.getDietCountByKeyword(keyword);

        // 페이징 처리
        PagingUtil page = new PagingUtil(Integer.parseInt(pageNum), count, 10);  // 한 페이지에 10개씩 표시
        request.setAttribute("page", page.getPage());  // 페이지 네비게이션

        // 음식 목록 가져오기
        List<DietPlanVO> foodList = dao.searchDietByKeyword(keyword, page.getStartRow(), page.getEndRow());

        // 결과를 request에 저장
        request.setAttribute("foodList", foodList);
        request.setAttribute("count", count);
        request.setAttribute("keyword", keyword);

        // JSP 페이지로 이동
        return "mydiet/noteDietForm.jsp"; // 경로 변경
    }
}
