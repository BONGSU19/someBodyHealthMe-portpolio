package kr.mydiet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;

public class NoteDietFormAction implements Action{
	
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		return "mydiet/noteDietForm.jsp";
	}
}
