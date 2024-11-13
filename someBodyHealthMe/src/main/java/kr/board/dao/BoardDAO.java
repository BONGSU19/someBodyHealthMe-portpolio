package kr.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.board.vo.BoardVO;
import kr.util.DBUtil;

public class BoardDAO {
	//싱글턴 패턴
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	private BoardDAO() {}

	//글등록
	public void insertBoard(BoardVO board) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "INSERT INTO board(board_num,board_category,board_title,board_content,board_attachment,user_num) "
					+ "VALUES(board_seq.nextval,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getBoard_category());
			pstmt.setString(2, board.getBoard_title());
			pstmt.setString(3, board.getBoard_content());
			pstmt.setString(4, board.getBoard_attachment());
			pstmt.setLong(5, board.getUser_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}

	}
	

}





























