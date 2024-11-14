package kr.friend.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.friend.dao.FriendDAO;
import kr.friend.vo.FriendVO;


public class FriendListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Long user_num = (Long)session.getAttribute("user_num");
		List<FriendVO> list = null;
		if(user_num == null) {//로그인이 되지 않은 경우
			
			FriendDAO dao = FriendDAO.getInstance();
			list=dao.getMember();
			request.setAttribute("list", list);
			return "friendSearch/friendList.jsp";
		
		}
		
		FriendDAO dao = FriendDAO.getInstance();
		list=dao.getMember();
		request.setAttribute("list", list);
		return "friendSearch/friendList.jsp";
	}

}
