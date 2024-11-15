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
	
	//내 건강 정보 등록
	
	public void insertMyBodyStatus(MyBodyStatusVO myBodyStatus) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    String sql = null;

	    try {
	        // 커넥션풀로부터 커넥션을 할당
	        conn = DBUtil.getConnection();
	        
	        // 자동 커밋 비활성화
	        conn.setAutoCommit(false);

	        // BMI 계산 (height는 cm로 입력되었을 것으로 가정)
	        double heightInMeters = myBodyStatus.getHeight() / 100.0;  // height를 m 단위로 변환
	        double bmi = myBodyStatus.getWeight() / (heightInMeters * heightInMeters);  // BMI 계산
	        
	        sql = "INSERT INTO HealthInfo (healthinfoid, user_num, height, weight, age, bmi, goal, gender, createdat, modifydate) "
	                + "VALUES (healthinfo_seq.nextval, ?, ?, ?, ?, ?, ?, ?, SYSDATE, NULL)";
	        
	        pstmt = conn.prepareStatement(sql);
	        
	        pstmt.setLong(1, myBodyStatus.getUserNum()); // user_num
	        pstmt.setInt(2, myBodyStatus.getHeight());  // height
	        pstmt.setInt(3, myBodyStatus.getWeight());  // weight
	        pstmt.setInt(4, myBodyStatus.getAge());     // age
	        pstmt.setDouble(5, bmi);                    // bmi (계산된 값)
	        pstmt.setString(6, myBodyStatus.getGoal()); // goal
	        pstmt.setString(7, myBodyStatus.getGender()); // gender
	        
	        pstmt.executeUpdate();

	        // SQL문 실행 시 모두 성공하면 commit
	        conn.commit();            
	        
	    } catch (Exception e) {
	        // 예외가 발생하면 롤백
	        if (conn != null) {
	            conn.rollback();
	        }
	        throw new Exception(e);
	    } finally {
	        // 커넥션이 null이 아닐 경우 자동 커밋을 다시 원래 상태로 복구
	        if (conn != null) {
	            try {
	                conn.setAutoCommit(true); // 자동 커밋을 다시 true로 설정
	            } catch (SQLException se) {
	                se.printStackTrace();
	            }
	        }
	        // DB 자원 해제
	        DBUtil.executeClose(null, pstmt, conn);
	    }        
	}
	
	//내 건강 정보 수정
	
	public void updateMyBodyStatus(MyBodyStatusVO myBodyStatus) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    String sql = null;

	    try {
	        // 커넥션풀로부터 커넥션을 할당
	        conn = DBUtil.getConnection();
	        
	        // 자동 커밋 비활성화
	        conn.setAutoCommit(false);

	        // BMI 계산 (height는 cm로 입력되었을 것으로 가정)
	        double heightInMeters = myBodyStatus.getHeight() / 100.0;  // height를 m 단위로 변환
	        double bmi = myBodyStatus.getWeight() / (heightInMeters * heightInMeters);  // BMI 계산
	        
	        // UPDATE 쿼리 작성
	        sql = "UPDATE HealthInfo "
	            + "SET height = ?, weight = ?, age = ?, bmi = ?, goal = ?, gender = ?, modifydate = SYSDATE "
	            + "WHERE user_num = ?"; // user_num을 기준으로 업데이트
	        
	        pstmt = conn.prepareStatement(sql);
	        
	        pstmt.setInt(1, myBodyStatus.getHeight());  // height
	        pstmt.setInt(2, myBodyStatus.getWeight());  // weight
	        pstmt.setInt(3, myBodyStatus.getAge());     // age
	        pstmt.setDouble(4, bmi);                    // bmi (계산된 값)
	        pstmt.setString(5, myBodyStatus.getGoal()); // goal
	        pstmt.setString(6, myBodyStatus.getGender()); // gender
	        pstmt.setLong(7, myBodyStatus.getUserNum());  // user_num (WHERE 조건)

	        // SQL 실행
	        pstmt.executeUpdate();

	        // SQL문 실행 시 모두 성공하면 commit
	        conn.commit();
	        
	    } catch (Exception e) {
	        // 예외가 발생하면 롤백
	        if (conn != null) {
	            conn.rollback();
	        }
	        throw new Exception(e);
	    } finally {
	        // 커넥션이 null이 아닐 경우 자동 커밋을 다시 원래 상태로 복구
	        if (conn != null) {
	            try {
	                conn.setAutoCommit(true); // 자동 커밋을 다시 true로 설정
	            } catch (SQLException se) {
	                se.printStackTrace();
	            }
	        }
	        // DB 자원 해제
	        DBUtil.executeClose(null, pstmt, conn);
	    }
	}


	
}
