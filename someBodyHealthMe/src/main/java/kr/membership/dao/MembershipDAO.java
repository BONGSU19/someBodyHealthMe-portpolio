package kr.membership.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.util.DBUtil;

public class MembershipDAO {
    // 싱글턴 패턴 구현
    private static MembershipDAO instance = new MembershipDAO();

    public static MembershipDAO getInstance() {
        return instance;
    }

    private MembershipDAO() {}

    // 회원권 구매 프로시저 호출
    public String buyMembershipByType(long user_num, int typeId) throws Exception {
        String sql = "{ call BUY_MEMBERSHIP_BY_TYPE(?, ?, sysdate) }";

        try (Connection conn = DBUtil.getConnection();
             CallableStatement cstmt = conn.prepareCall(sql)) {
        	conn.setAutoCommit(false); 
            // 프로시저 매개변수 설정
            cstmt.setLong(1, user_num);  // p_user_id
            cstmt.setInt(2, typeId);  // p_type_id

            // 프로시저 실행
            int rowsAffected =cstmt.executeUpdate();
           

            // 4. 실행 결과에 따른 응답
            String isRequestSent="";
			if (rowsAffected>0) {
                isRequestSent = "success";
            } else {
                isRequestSent = "duple";
            }
			conn.commit();
			return isRequestSent;
        } catch (Exception e) {
            // 에러 로깅
            e.printStackTrace(); 
            throw new Exception("회원권 구매 중 오류 발생", e);
        }
    }
    public void MembershipOrder(int typeId, long user_num, int Price,int payment,int receive_phone)throws Exception{
    	Connection conn=null;
    	String sql=null;
    	PreparedStatement pstmt=null;
    	try {
			conn=DBUtil.getConnection();
			sql="INSERT INTO membershipOrder (order_num, user_num, typeId, receive_phone, price, order_date, payment) VALUES (membershipOrder_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, user_num);
			pstmt.setInt(2, typeId);
			pstmt.setInt(3, receive_phone);
			pstmt.setInt(4, Price);
			pstmt.setInt(5, payment);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
    }
}
