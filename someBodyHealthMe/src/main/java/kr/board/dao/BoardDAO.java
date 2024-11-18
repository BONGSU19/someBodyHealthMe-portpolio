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

			sql = "SELECT COUNT(*) FROM board JOIN (SELECT * FROM suser LEFT OUTER JOIN suser_detail USING(user_num)) USING(user_num) " +  sub_sql;

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
				if(keyfield.equals("3")) sub_sql = " WHERE nick_name LIKE '%' || ? || '%'";//닉네임으로 검색
			}		

			//SQL맞음 고치지 말아
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM board JOIN (SELECT * FROM suser LEFT OUTER JOIN suser_detail USING(user_num)) USING (user_num) "  + sub_sql + " ) a) WHERE rnum >= ? AND rnum <= ?";

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
				board.setNick_name(rs.getString("nick_name"));
				board.setLogin_id(rs.getString("login_id"));

				list.add(board);
			}

		}catch(Exception e ) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}

	//글 상세 페이지
	public BoardVO getBoard(long board_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		BoardVO board = new BoardVO();

		try {
			conn = DBUtil.getConnection();

			sql = "SELECT * FROM board LEFT OUTER JOIN (SELECT * FROM suser LEFT OUTER JOIN suser_detail USING(user_num))USING(user_num) WHERE board_num =?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, board_num);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				board.setBoard_title(rs.getString("board_title"));
				board.setBoard_category(rs.getInt("board_category"));
				board.setBoard_content(rs.getString("board_content"));
				board.setBoard_num(rs.getLong("board_num"));
				board.setBoard_title(rs.getString("board_title"));
				board.setBoard_regdate(rs.getString("board_regdate"));
				board.setBoard_modifydate(rs.getString("board_modifydate"));
				board.setBoard_count(rs.getLong("board_count"));
				board.setNick_name(rs.getString("nick_name"));
				board.setLogin_id(rs.getString("login_id"));
				board.setUser_num(rs.getLong("user_num"));
			}			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {

		}

		return board;
	}

	//조회수 증가 
	public void updateReadCount(long board_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;

		try {
			conn = DBUtil.getConnection();

			sql = "UPDATE board SET board_count = board_count+1 WHERE board_num = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, board_num);

			pstmt.executeUpdate();

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		} 

	}
	//파일 삭제

	//글수정
	public void updateBoard(BoardVO board)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();

			sql = "UPDATE board SET board_title=?, board_content=?, board_attachment=?, board_modifydate=SYSDATE WHERE board_num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, board.getBoard_title());
			pstmt.setString(2, board.getBoard_content());
			pstmt.setString(3, board.getBoard_attachment());
			pstmt.setLong(4, board.getBoard_num());

			pstmt.executeUpdate();

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}		
	}	

	//글 삭제
	public void deleteBoard(long board_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();

			sql = "DELETE board WHERE board_num = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, board_num);

			pstmt.executeUpdate();

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}		
	}

}





























