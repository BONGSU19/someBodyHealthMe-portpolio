package kr.friend.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.friend.vo.FriendVO;

import kr.util.DBUtil;

public class FriendDAO {

	//싱글턴 패턴
	private static FriendDAO instance = new FriendDAO();

	public static FriendDAO getInstance() {
		return instance;
	}
	private FriendDAO() {}
	private Connection conn;
	private PreparedStatement pstmt;


	//받은 요청 확인하는 dao
	public List<Integer> getReceivedFriendRequests(int receiverNum) {
		List<Integer> friendRequests = new ArrayList<>();
		String sql = "SELECT sender_num FROM friend WHERE receiver_num = ? AND status = '1'";  // 상태가 '요청'인 친구 목록

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, receiverNum);  // 받은 사람 번호

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				// 보낸 사람 번호 (친구 요청을 보낸 사람)
				friendRequests.add(rs.getInt("sender_num"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return friendRequests;
	}





	// 친구 요청 추가 (보내는 사람과 받는 사람)
	public String sendFriendRequest(Long user_num, Long receiver) throws Exception {
		String isRequestSent = "";
		ResultSet rs=null;
		conn=  DBUtil.getConnection();
		String sql = "INSERT INTO friend (friend_num, created_at,user_num , receiver_num, status) " +
				"VALUES (seq_friend.nextval,SYSDATE, ?, ?,'1')";  // '1'은 친구 요청 상태
		String sql2="select * from friend where user_num=? and receiver_num=? ";
		PreparedStatement pstmt2=null;
		try {
			
			
			pstmt2= conn.prepareStatement(sql2);
			pstmt2.setLong(1, user_num);
			pstmt2.setLong(2, receiver);

			rs= pstmt2.executeQuery();
			if(!rs.next()) {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, user_num);
			pstmt.setLong(2, receiver);
			pstmt.executeUpdate();
			isRequestSent ="success";
			}else {
				isRequestSent = "duple";
			

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return isRequestSent;
	}




	// 친구 추가 메서드



	public FriendDAO(Connection conn) {
		this.conn = conn;
	}


	public boolean addFriend(int senderNum, int receiverNum, String status) {
		boolean isAdded = false;

		String sql = "INSERT INTO friend (friend_num,created_at,user_num, status) " +
				"VALUES (seq_friend.nextval, ?, ?, SYSDATE)";

		try {
			pstmt = conn.prepareStatement(sql);

			// 보낸 사람 (sender_num)
			pstmt.setInt(1, senderNum);

			// 친구 상태 (status: 1=요청, 2=수락, 3=거절)
			pstmt.setString(2, status);

			// 쿼리 실행
			int result = pstmt.executeUpdate();

			if (result > 0) {
				// 친구 추가 성공
				isAdded = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return isAdded;
	}

	//사용 유저들 나열시키기

	public  List<FriendVO> getMember()throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		List<FriendVO> friends = new ArrayList<>();
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM SUSER_DETAIL";


			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩

			//SQL문 실행
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FriendVO friend = new FriendVO();
				friend = new FriendVO();
				friend.setUser_Num(rs.getInt("user_Num"));
				friend.setNick_Name(rs.getString("nick_name"));
				friend.setName(rs.getString("name"));
				friend.setEmail(rs.getString("email"));
				friend.setPassword(rs.getString("password"));
				friend.setPhone(rs.getString("phone"));
				friend.setRegistration_Date(rs.getDate("registration_date"));
				friend.setBirth_Date(rs.getString("birth_date"));
				friend.setModify_Date(rs.getDate("MODIFY_DATE"));
				friend.setCenter_Num(rs.getInt("center_num"));
				friends.add(friend);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}		
		return friends;
	}





}
