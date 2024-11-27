package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.appl.vo.ApplVO;
import kr.board.vo.BoardVO;
import kr.util.DBUtil;

public class AdminDAO {
    private static AdminDAO instance = new AdminDAO();

    public static AdminDAO getInstance() {
        return instance;
    }

    private AdminDAO() {}

    // 최신 게시글 5개 가져오기
    public List<BoardVO> getRecentPosts() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BoardVO> list = new ArrayList<>();

        String sql = "SELECT * FROM ( " +
                     "    SELECT b.*, ROWNUM rnum " +
                     "    FROM ( " +
                     "        SELECT * " +
                     "        FROM board " +
                     "        ORDER BY board_regdate DESC " +
                     "    ) b " +
                     "    WHERE ROWNUM <= 5 " +
                     ") WHERE rnum <= 5";

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardVO board = new BoardVO();
                board.setBoard_num(rs.getLong("board_num"));
                board.setBoard_title(rs.getString("board_title"));
                board.setBoard_regdate(rs.getString("board_regdate"));
                list.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("게시글 조회 중 오류 발생: " + e.getMessage());
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }
        return list;
    }

    // 최근 지원 신청 5개 가져오기
    public List<ApplVO> getRecentApplications() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ApplVO> list = new ArrayList<>();

        // application과 suser_detail 테이블을 조인하여 name 열을 가져옴
        String sql = "SELECT appl.appl_num, appl.field, appl.career, appl.appl_center, " +
                     "       appl.appl_regdate, appl.appl_status, detail.name " +
                     "FROM ( " +
                     "    SELECT a.*, ROWNUM rnum " +
                     "    FROM ( " +
                     "        SELECT * " +
                     "        FROM application a " +
                     "        ORDER BY a.appl_regdate DESC " +
                     "    ) a " +
                     "    WHERE ROWNUM <= 5 " +
                     ") appl " +
                     "JOIN suser_detail detail ON appl.user_num = detail.user_num";

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ApplVO appl = new ApplVO();
                appl.setAppl_num(rs.getLong("appl_num"));
                appl.setField(rs.getInt("field"));
                appl.setCareer(rs.getInt("career"));
                appl.setAppl_center(rs.getInt("appl_center"));
                appl.setAppl_regdate(rs.getDate("appl_regdate"));
                appl.setAppl_status(rs.getInt("appl_status"));
                appl.setName(rs.getString("name"));
                list.add(appl);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("지원 신청 조회 중 오류 발생: " + e.getMessage());
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }
        return list;
    }
}