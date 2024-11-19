package kr.friend.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.friend.dao.FriendDAO;
import kr.util.StringUtil;

public class SendFriendRequest2Action implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  Map<String, Object> mapAjax = new HashMap<String, Object>();
		    HttpSession session = request.getSession();
		    Long user_num = (Long) session.getAttribute("user_num");

		    // 변경된 부분: request.getParameter()를 사용하여 값을 가져옴
		    Long receiver = Long.parseLong(request.getParameter("receiverNum"));

		    FriendDAO dao = FriendDAO.getInstance();
		    String isRequestSent = dao.sendFriendRequest2(user_num, receiver);

		    // 결과를 mapAjax에 저장
		    mapAjax.put("isRequestSent", isRequestSent);

		    // JSON 응답으로 반환
		    return StringUtil.parseJSON(request, mapAjax);

	}

}
