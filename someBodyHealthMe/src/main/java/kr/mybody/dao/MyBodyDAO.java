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
			sql = "SELECT * FROM healthInfo WHERE user_num=?";
			
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
	
	public void insertMyBodyStatus(MyBodyStatusVO myBodyStatus)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			
			sql = "INSERT INTO HealthInfo (user_num, height, weight, age, bmi, goal, gender, createdat, modifydate) "
			           + "VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATE, NULL)";
			
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setLong(1, myBodyStatus.getUserNum()); // user_num
            pstmt.setDouble(2, myBodyStatus.getHeight());   // height
            pstmt.setDouble(3, myBodyStatus.getWeight());   // weight
            pstmt.setInt(4, myBodyStatus.getAge());      // age
            pstmt.setDouble(5, myBodyStatus.getBmi());   // bmi
            pstmt.setString(6, myBodyStatus.getGoal());  // goal
            pstmt.setString(7, myBodyStatus.getGender()); // gender
			
			//SQL문 실행시 모두 성공하면 commit
			conn.commit();			
			
		}catch(Exception e) {
			//SQL문이 하나라도 실패하면 rollback
			conn.rollback();
			throw new Exception(e);
		}finally {

			DBUtil.executeClose(null, pstmt, conn);
		}		
	}
	
	
}
