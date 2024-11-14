package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class MemberDAO {
    private static MemberDAO instance = new MemberDAO();

    public static MemberDAO getInstance() {
        return instance;
    }

    private MemberDAO() {}

    // 회원 가입
    public void insertMember(MemberVO member) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        ResultSet rs = null;
        String sql = null;
        long userNum = 0;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // 회원번호(user_num) 생성
            sql = "SELECT user_seq.NEXTVAL FROM dual";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                userNum = rs.getLong(1);
            }
            System.out.println("Generated userNum: " + userNum);

            // 관리자 코드에 따라 STATUS 설정
            int status = 1;  // 기본값 1 (일반 사용자)
            int adminCode = member.getAdmin_code();  // admin_code는 int 타입이므로 바로 처리

            // 관리자 코드가 4인 경우만 마스터 관리자 처리
            if (adminCode == 4) {  
                status = 4;  // 마스터 관리자
            }

            // SUSER 테이블에 데이터 삽입
            sql = "INSERT INTO SUSER (user_num, login_id, status) VALUES (?, ?, ?)";
            pstmt2 = conn.prepareStatement(sql);
            pstmt2.setLong(1, userNum);
            pstmt2.setString(2, member.getLogin_id());
            pstmt2.setInt(3, member.getStatus()); // 설정된 status 값 사용
            int result1 = pstmt2.executeUpdate();
            System.out.println("SUSER insert result: " + result1 + ", status: " + member.getStatus()); // 확인용 로그

            // SUSER_DETAIL 테이블에 데이터 삽입
            sql = "INSERT INTO SUSER_DETAIL (user_num, nick_name, name, email, password, phone, registration_date, birth_date, center_num) "
                + "VALUES (?, ?, ?, ?, ?, ?, SYSDATE, ?, ?)";
            pstmt3 = conn.prepareStatement(sql);
            pstmt3.setLong(1, userNum);
            pstmt3.setString(2, member.getNick_name());
            pstmt3.setString(3, member.getName());
            pstmt3.setString(4, member.getEmail());
            pstmt3.setString(5, member.getPassword());
            pstmt3.setString(6, member.getPhone());
            pstmt3.setString(7, member.getBirth_date());

            // 센터 코드 유효성 체크: 센터 코드가 반드시 선택되어야 함
            int centerCode = member.getCenter_num();
            if (centerCode == 0) {  // centerCode가 0이면 예외 발생
                throw new Exception("센터를 선택하세요.");
            }
            pstmt3.setInt(8, centerCode);

            pstmt3.executeUpdate();
            System.out.println("Inserted into SUSER_DETAIL with nick_name: " + member.getNick_name());

            conn.commit();
            System.out.println("Transaction committed successfully.");

        } catch (Exception e) {
            if (conn != null) conn.rollback();
            System.out.println("Transaction rolled back due to an error.");
            e.printStackTrace();
            throw new Exception("회원가입 중 오류 발생: " + e.getMessage());
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
            DBUtil.executeClose(null, pstmt2, null);
            DBUtil.executeClose(null, pstmt3, null);
        }
    }
    // 아이디 중복 체크
    public boolean isDuplicateId(String loginId) throws Exception {
        return checkDuplicate("SUSER", "login_id", loginId);
    }

    // 닉네임 중복 체크
    public boolean isDuplicateNickname(String nickName) throws Exception {
        return checkDuplicate("SUSER_DETAIL", "nick_name", nickName);
    }

    // 이메일 중복 체크
    public boolean isDuplicateEmail(String email) throws Exception {
        return checkDuplicate("SUSER_DETAIL", "email", email);
    }

    // 휴대전화 중복 체크
    public boolean isDuplicatePhone(String phone) throws Exception {
        return checkDuplicate("SUSER_DETAIL", "phone", phone);
    }

    // 중복 체크 공통 메서드
    private boolean checkDuplicate(String tableName, String columnName, String value) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isDuplicate = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM " + tableName + " WHERE " + columnName + " = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, value);  // 입력값을 파라미터로 바인딩
            System.out.println("Executing query: " + sql);  // 실행되는 쿼리 로그 출력
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Count result: " + count);  // 중복 카운트 출력
                isDuplicate = count > 0;  // 카운트가 0보다 크면 중복
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(columnName + " 중복 체크 중 오류 발생: " + e.getMessage());
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        System.out.println("Is Duplicate: " + isDuplicate);  // 최종 중복 여부 출력
        return isDuplicate;
    }
		// 로그인 메서드
    public MemberVO checkLogin(String loginId, String password) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberVO member = null;
        String sql = "SELECT u.user_num, u.login_id, u.status, d.nick_name, d.name " +
                     "FROM SUSER u LEFT JOIN SUSER_DETAIL d ON u.user_num = d.user_num " +
                     "WHERE u.login_id = ? AND u.password = ?"; // password 컬럼이 실제 테이블의 컬럼명과 일치해야 함

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, loginId);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                member = new MemberVO();
                member.setUser_num(rs.getLong("user_num"));
                member.setLogin_id(rs.getString("login_id"));
                member.setStatus(rs.getInt("status"));
                member.setNick_name(rs.getString("nick_name"));
                member.setName(rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("로그인 중 오류 발생: " + e.getMessage());
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }
        return member;
    }
}