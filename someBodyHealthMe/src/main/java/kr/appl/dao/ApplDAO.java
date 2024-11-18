package kr.appl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.appl.vo.ApplVO;
import kr.util.DBUtil;

public class ApplDAO {
	//싱글턴 패턴
	private static ApplDAO instance = new ApplDAO();

	public static ApplDAO getInstance() {
		return instance;
	}
	private ApplDAO() {}

	//지원 하기
	public void insertAppl(ApplVO appl) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;

		try {
			conn = DBUtil.getConnection();

			sql = "INSERT INTO application"
					+ "(appl_num, field, career, source, appl_center, "
					+ " content, appl_attachment, user_num) "
					+ "VALUES(appl_seq.nextval,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, appl.getField());
			pstmt.setInt(2, appl.getCareer());
			pstmt.setString(3, appl.getSource());
			pstmt.setInt(4, appl.getAppl_center());
			pstmt.setString(5, appl.getContent());
			pstmt.setString(6, appl.getAppl_attachment());
			pstmt.setLong(7, appl.getUser_num());

			pstmt.executeUpdate();


		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}

	}
	
	//나의 지원 목록 보기
	public List<ApplVO> getMyApplList(long user_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ApplVO> list = new ArrayList<ApplVO>();
		String sql;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM application WHERE user_num = ? ORDER BY appl_num DESC";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, user_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ApplVO appl = new ApplVO();
				appl.setAppl_num(rs.getLong("appl_num"));//지원번호
				appl.setField(rs.getInt("field"));//지원분야
				appl.setAppl_center(rs.getInt("appl_center"));//지원지점
				appl.setAppl_regdate(rs.getDate("appl_regdate"));//등록일
				appl.setAppl_status(rs.getInt("appl_status"));//관리자 확인상태
				appl.setAppl_modifydate(rs.getDate("appl_modifydate"));//변경일		
				list.add(appl);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;		
	}
	

	//지원 취소
	public void deleteAppl(long appl_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;

		try {
			conn = DBUtil.getConnection();

			sql = "DELETE appl WHERE appl_num = ? AND appl_status =?";

			pstmt = conn.prepareCall(sql);

			pstmt.setLong(1, appl_num);			

		}catch(Exception e) {
			throw new Exception(e);			
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}

	//총 지원 개수 구하기 - 관리자
	public int getApplicationCount(String keyword,int appl_status,int field,int career,int appl_center) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String sub_sql = "";
		int cnt = 0;
		int count = 0;

		try {
			conn = DBUtil.getConnection();

			if(appl_status != 9) sub_sql = "WHERE 1=1 ";//전체(지원상태)
			else sub_sql = "WHERE appl_status = ? ";//field 1

			if(field != 9) sub_sql += " AND field = ?";//(분야)		

			if(career != 9) sub_sql += " AND career = ?"; //(경력)

			if(appl_center != 0) sub_sql += " AND appl_center=?"; //지점번호

			if(keyword != null && !"".equals(keyword)) {
				sub_sql += " AND name = '%' || ? || '%'";
			}

			sql = "SELECT COUNT(*) FROM application JOIN (SELECT * FROM suser LEFT OUTER JOIN suser_detail USING(user_num)) USING(user_num) " + sub_sql;

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(++cnt, appl_status);
			pstmt.setInt(++cnt, field);
			pstmt.setInt(++cnt, career);
			pstmt.setInt(++cnt, appl_center);

			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}

			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}				
		return count;
	}


	//지원 목록 보기 관리자
	public List<ApplVO> getListByAdmin(String keyword,int appl_status,int field,int career,int appl_center) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int cnt = 0;
		String sub_sql="";
		List<ApplVO> list = null;


		try {
			conn = DBUtil.getConnection();

			if(appl_status != 9) sub_sql = "WHERE 1=1 ";//전체(지원상태)
			else sub_sql = "WHERE appl_status = ? ";//field 1

			if(field != 9) sub_sql += " AND field = ?";//(분야)		

			if(career != 9) sub_sql += " AND career = ?"; //(경력)

			if(appl_center != 0) sub_sql += " AND appl_center=?"; //지점번호

			if(keyword != null && !"".equals(keyword)) {
				sub_sql += " AND name = '%' || ? || '%'";
			}

			sql = "SELECT * FROM application JOIN (SELECT * FROM suser LEFT OUTER JOIN suser_detail USING(user_num)) USING(user_num) " + sub_sql +" ORDER BY appl_status";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(++cnt, appl_status);
			pstmt.setInt(++cnt, field);
			pstmt.setInt(++cnt, career);
			pstmt.setInt(++cnt, appl_center);

			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}

			rs = pstmt.executeQuery();
			list = new ArrayList<ApplVO>();

			while(rs.next()) {
				ApplVO appl = new ApplVO();
				appl.setAppl_num(rs.getLong("aapl_num"));
				appl.setField(rs.getInt("field"));
				appl.setCareer(rs.getInt("career"));
				appl.setAppl_center(rs.getInt("appl_center"));
				appl.setAppl_regdate(rs.getDate("appl_regdate"));
				appl.setAppl_status(rs.getInt("appl_status"));
				list.add(appl);				
			}

		}catch(Exception e) {
			throw new Exception(e);
		}finally{
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}

	//상세 지원 보기
	public ApplVO getAppl(long appl_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ApplVO appl = null;
		String sql;

		try {
			conn = DBUtil.getConnection();

			sql = "SELECT * FROM application JOIN (SELECT * FROM suser LEFT OUTER JOIN suser_detail USING(user_num)) USING(user_num) WHERE appl_num = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, appl_num);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				appl = new ApplVO();
				appl.setAppl_attachment(rs.getString("appl_attachment"));
				appl.setAppl_center(rs.getInt("appl_center"));
				appl.setCareer(rs.getInt("career"));
				appl.setContent(rs.getString("content"));
				appl.setField(rs.getInt("field"));
				appl.setSource(rs.getString("source"));
				appl.setAppl_status(rs.getInt("appl_status"));
				appl.setAppl_num(rs.getLong("appl_num"));
				appl.setAppl_regdate(rs.getDate("appl_regdate"));
				appl.setAppl_modifydate(rs.getDate("appl_modifydate"));
				appl.setName(rs.getString("name"));
				appl.setUser_num(rs.getLong("user_num"));
			}			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}

		return appl;
	}


	//관리자 확인, 관리자 전환된 회원은 (appl_status 변경x )
	public void updateAppl_status(long appl_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;

		try {
			conn = DBUtil.getConnection();

			sql = "UPDATE application SET appl_status = 1  WHERE appl_num ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, appl_num);

			pstmt.executeUpdate();


		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}

	//관리자 전환
	public void updateStatus(long user_num, int appl_status) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;

		try {
			conn = DBUtil.getConnection();

			sql = "UPDATE suser SET status = ? WHERE user_num=? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, appl_status);
			pstmt.setLong(2, user_num);

			pstmt.executeUpdate();

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}



}
