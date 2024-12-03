package kr.mydiet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.mydiet.vo.MealLogVO;
import kr.util.DBUtil;

public class MealLogDAO {
    // 싱글톤 패턴 적용
    private static MealLogDAO instance = new MealLogDAO();

    public static MealLogDAO getInstance() {
        return instance;
    }

    private MealLogDAO() {}

    // MealLog 추가 메서드
    public void insertMealLog(MealLogVO mealLog) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;
        try {
            conn = DBUtil.getConnection();

            sql = "INSERT INTO MealLog (MealLogID, FoodName, MealType, CreatedAt, user_num) "
                + "VALUES (MealLogID_seq.NEXTVAL, ?, ?, SYSDATE, ?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mealLog.getFoodName());
            pstmt.setString(2, mealLog.getMealType());
            pstmt.setLong(3, mealLog.getUserNum());

            pstmt.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
            throw new SQLException(e);
        } finally {
            DBUtil.executeClose(null, pstmt, conn);
        }
    }
    
 // 특정 사용자(UserNum)의 식사 기록을 조회
    public List<MealLogVO> getMealLogsByUser(Long user_num) {
        List<MealLogVO> mealLogs = new ArrayList<>();
        String sql = "SELECT MEALLOGID, FOODNAME, MEALTYPE, CREATEDAT, USER_NUM FROM MEALLOG WHERE USER_NUM = ? ORDER BY CREATEDAT DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, user_num);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    MealLogVO log = new MealLogVO();
                    log.setMealLogId(rs.getInt("MEALLOGID"));
                    log.setFoodName(rs.getString("FOODNAME"));
                    log.setMealType(rs.getString("MEALTYPE"));
                    log.setCreatedAt(rs.getDate("CREATEDAT"));
                    log.setUserNum(rs.getInt("USER_NUM"));
                    mealLogs.add(log);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return mealLogs;
    }
}
