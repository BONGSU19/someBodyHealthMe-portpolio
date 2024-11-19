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





	// 친구 요청 추가 (보내는 사람과 받는 사람) 요청 보내기
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


	public String sendFriendRequest2(Long user_num, Long receiver) throws Exception {
		String isRequestSent = "";
		ResultSet rs=null;
		conn=  DBUtil.getConnection();
		
		String sql2= "delete from friend  where user_num=? and receiver_num=? ";
				
		PreparedStatement pstmt2=null;
		try {


			pstmt2= conn.prepareStatement(sql2);
			pstmt2.setLong(1, user_num);
			pstmt2.setLong(2, receiver);

			pstmt2.executeQuery();
	
			isRequestSent ="success";
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
	public int getMemberCountByAdmin(String keyfield,
			String keyword)
					throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;

		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();

			if (keyword != null && !"".equals(keyword)) {
			    //검색 처리
			    if (keyfield.equals("1")) sub_sql += "WHERE name LIKE '%' || ? || '%'";
			    else if (keyfield.equals("2")) sub_sql += "WHERE nick_name LIKE '%' || ? || '%'";
			 
			}

			//SQL문 작성
			sql = "SELECT COUNT(*) FROM suser LEFT OUTER JOIN "
					+ "suser_detail USING(user_num) " + sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, keyword);
			}
			//SQL문 실행
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



	public  List<FriendVO> getMember(int start,
		    int end,String keyfield,String keyword,Long user_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sub_sql="";
		String sql = null;
		List<FriendVO> friends = new ArrayList<>();
		int cnt=0;
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성




			if (keyword != null && !"".equals(keyword)) {
			    //검색 처리
			    if (keyfield.equals("1")) sub_sql += "WHERE name LIKE '%' || ? || '%'";
			    else if (keyfield.equals("2")) sub_sql += "WHERE nick_name LIKE '%' || ? || '%'";
			 
			}

			// Add the user number condition
			

			// SQL 문 작성
			sql = """
					SELECT user_num, nick_name, center_num, status, rnum,name
					FROM (
					    SELECT a.user_num, a.nick_name,a.name, a.center_num, a.status, rownum AS rnum  -- rownum을 별칭으로 지정
					    FROM (
					        SELECT s.user_num AS user_num,
					               s.nick_name AS nick_name,
					               s.center_num AS center_num,
					               s.name,
					               NVL(f.status, 'None') AS status
					        FROM suser_detail s
					        LEFT JOIN friend f 
					            ON (s.user_num = f.receiver_num AND f.user_num = ?)  -- 로그인한 사용자가 친구 요청을 보낸 경우
					       -- 로그인한 사용자가 친구 요청을 받은 경우
					        """ + sub_sql + """ 
					        ORDER BY s.user_num DESC NULLS LAST
					    ) a
					)
					WHERE rnum >= ? AND rnum <= ?
""";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(++cnt, user_num);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			


			//PreparedStatement 객체 생성
			
			//?에 데이터 바인딩

			//SQL문 실행
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FriendVO friend = new FriendVO();
				friend = new FriendVO();
				friend.setUser_Num(rs.getLong("user_Num"));
				friend.setNick_Name(rs.getString("nick_name"));
				friend.setName(rs.getString("name"));
				friend.setCenter_Num(rs.getInt("center_num"));
				friend.setStatus(rs.getString("status"));
				friends.add(friend);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}		
		return friends;
	}


	public  List<FriendVO> centerGetMember(int start,
		    int end,String keyfield,String keyword,int center_num ,Long user_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sub_sql="";
		String sql = null;
		List<FriendVO> friends = new ArrayList<>();
		int cnt=0;
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성




			if(keyword != null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE login_id LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE name LIKE '%' || ? || '%'";
				else if(keyfield.equals("3")) sub_sql += "WHERE nick_name LIKE '%' || ? || '%'";
			}	
			sub_sql += (sub_sql.contains("WHERE") ? " AND" : " WHERE") + " center_num = ?";
			//SQL문 작성
			sql = """
					SELECT user_num, nick_name, center_num, status, rnum,name
					FROM (
					    SELECT a.user_num, a.nick_name,a.name, a.center_num, a.status, rownum AS rnum  -- rownum을 별칭으로 지정
					    FROM (
					        SELECT s.user_num AS user_num,
					               s.nick_name AS nick_name,
					               s.center_num AS center_num,
					               s.name,
					               NVL(f.status, 'None') AS status
					        FROM suser_detail s
					        LEFT JOIN friend f 
					            ON (s.user_num = f.receiver_num AND f.user_num = ?)  -- 로그인한 사용자가 친구 요청을 보낸 경우
					       -- 로그인한 사용자가 친구 요청을 받은 경우
					        """ + sub_sql + """ 
					        ORDER BY s.user_num DESC NULLS LAST
					    ) a
					)
					WHERE rnum >= ? AND rnum <= ?
""";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(++cnt, user_num);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, center_num);
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);


			//PreparedStatement 객체 생성
			
			//?에 데이터 바인딩

			//SQL문 실행
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FriendVO friend = new FriendVO();
				friend = new FriendVO();
				friend.setUser_Num(rs.getLong("user_Num"));
				friend.setNick_Name(rs.getString("nick_name"));
				friend.setName(rs.getString("name"));
				friend.setCenter_Num(rs.getInt("center_num"));
				friend.setStatus(rs.getString("status"));
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
