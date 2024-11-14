package kr.mybody.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.member.vo.MemberVO;
import kr.mybody.vo.MyBodyStatusVO;
import kr.util.DBUtil;

public class MyBodyDAO{
	
	
	private static MyBodyDAO instance = new MyBodyDAO();
	
	
	public static MyBodyDAO getInstance() {
		return instance;
	}
	
	
	private MyBodyDAO() {}
	
	
	public MyBodyStatusVO getMyBodyStatus(long user_num)throws Exception{
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MyBodyStatusVO mybodystatus = null;
		String sql = null;
		
		try {
			//커넥션 풀로 부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "SELECT * FROM healthInfo JOIN suser_detail "
					+ "USING(user_num) WHERE user_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			//?에 데이터 바인딩
			pstmt.setLong(1, user_num);
			
			//sql문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mybodystatus = new MyBodyStatusVO();
				mybodystatus.setHealthInfoID(rs.getInt("healthinfoid"));
				mybodystatus.setHeight(rs.getInt("height"));
				mybodystatus.setWeight(rs.getInt("weight"));
				mybodystatus.setAge(rs.getInt("age"));
				mybodystatus.setBmi(rs.getInt("bmi"));
				mybodystatus.setGoal(rs.getString("goal"));
				mybodystatus.setGender(rs.getString("gender"));
				mybodystatus.setCreatedAt(rs.getDate("createdat"));
				mybodystatus.setModifyDate(rs.getDate("modifydate"));
			}
			
		} catch (SQLException e) {
		    // 로그를 남길 수도 있습니다.
		    throw new Exception("Database error: " + e.getMessage(), e);
		} catch (Exception e) {
		    throw new Exception("An unexpected error occurred: " + e.getMessage(), e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return mybodystatus;
		
	}
	
}
