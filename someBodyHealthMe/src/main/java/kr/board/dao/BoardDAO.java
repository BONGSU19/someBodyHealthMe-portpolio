package kr.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

			pstmt.setInt(1, board.getBoard_category());
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

	//글의 총 개수/ 검색글 개수
	public int getBoardCount(String keyfield,String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String sub_sql = "";
		int count = 0;


		try {
			conn = DBUtil.getConnection();
			
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql = " WHERE board_title LIKE '%' || ? || '%'";//제목으로 검색
				if(keyfield.equals("2")) sub_sql = " WHERE board_content LIKE '%' || ? || '%'";//내용으로 검색
				if(keyfield.equals("3")) sub_sql = " WHERE nick_name LIKE '%' || ? || '%'";//닉네임으로 검색
			}
			
			sql = "SELECT count(*) FROM board JOIN (SELECT * FROM suser LEFT OUTER JOIN suser_detail USING(user_num)" +  sub_sql + ") USING(user_num);";
			
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)){
				pstmt.setString(1, keyword);
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt(1);
			


		}catch(Exception e ) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}



		return count;
	}
	//글 목록
	public List<BoardVO> getListBoard(int start, int end, String keyfield,String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVO> list = new ArrayList<BoardVO>();
		int cnt = 0;
		String sql;
		String sub_sql = "";
		


		try {
			conn = DBUtil.getConnection();
			
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql = " WHERE board_title LIKE '%' || ? || '%'";//제목으로 검색
				if(keyfield.equals("2")) sub_sql = " WHERE board_content LIKE '%' || ? || '%'";//내용으로 검색
				if(keyfield.equals("3")) sub_sql = " WHERE board_content LIKE '%' || ? || '%'";//닉네임으로 검색
			}
			
			
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "SELECT COUNT(*) FROM board JOIN (SELECT * FROM suser LEFT OUTER JOIN suser_detail USING(user_num)) USING(user_num)" + sub_sql + " ORDER BY board_num DESCa) "
					+ "WHERE rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardVO board = new BoardVO();
				board.setBoard_num(rs.getLong("board_num"));
				board.setBoard_title(rs.getString("board_title"));
				board.setBoard_regdate(rs.getString("board_regdate"));
				board.setBoard_modifydate(rs.getString("board_modifydate"));
				board.setBoard_count(rs.getLong("board_count"));		
				
				list.add(board);
			}
			
		}catch(Exception e ) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}



		return list;
	}

	

}





























