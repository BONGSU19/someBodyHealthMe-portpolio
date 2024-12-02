package kr.mydiet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
