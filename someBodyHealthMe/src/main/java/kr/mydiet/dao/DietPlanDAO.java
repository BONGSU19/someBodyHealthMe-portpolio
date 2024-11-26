package kr.mydiet.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import kr.mydiet.vo.DietPlanVO;
import kr.util.DBUtil;

public class DietPlanDAO {

	  private static DietPlanDAO instance = new DietPlanDAO();

	    public static DietPlanDAO getInstance() {
	        return instance;
	    }

    // 식단 데이터 삽입 메서드
    public void insertDietPlan(DietPlanVO dietPlan) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO DIETPLAN (DIETID, FOODNAME, CALORIES, PROTEIN, CARBOHYDRATE, FAT, MINERALS, DIET_SHOW, DIET_COMMENT, USER_NUM) "
                   + "VALUES (DIETPLAN_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, dietPlan.getFoodName());  // FOODNAME
            pstmt.setDouble(2, dietPlan.getCalories());  // CALORIES
            pstmt.setDouble(3, dietPlan.getProtein());   // PROTEIN
            pstmt.setDouble(4, dietPlan.getCarbohydrate()); // CARBOHYDRATE
            pstmt.setDouble(5, dietPlan.getFat());       // FAT
            pstmt.setDouble(6, dietPlan.getMinerals());  // MINERALS
            pstmt.setInt(7, dietPlan.getDietShow());     // DIET_SHOW
            pstmt.setInt(8, dietPlan.getDietComment());  // DIET_COMMENT
            pstmt.setLong(9, dietPlan.getUserNum());     // USER_NUM

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error while inserting DietPlan", e);
        } finally {
            DBUtil.executeClose(null, pstmt, conn);
        }
    }

    // 식단 데이터 조회 (특정 사용자 USER_NUM 기준)
    public List<DietPlanVO> selectDietPlansByUserNum(long userNum) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT DIETID, FOODNAME, CALORIES, PROTEIN, CARBOHYDRATE, FAT, MINERALS, DIET_SHOW, DIET_COMMENT, USER_NUM "
                   + "FROM DIETPLAN WHERE USER_NUM = ?";
        List<DietPlanVO> dietPlans = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, userNum);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                DietPlanVO dietPlan = new DietPlanVO();
                dietPlan.setDietId(rs.getLong("DIETID"));
                dietPlan.setFoodName(rs.getString("FOODNAME"));
                dietPlan.setCalories(rs.getDouble("CALORIES"));
                dietPlan.setProtein(rs.getDouble("PROTEIN"));
                dietPlan.setCarbohydrate(rs.getDouble("CARBOHYDRATE"));
                dietPlan.setFat(rs.getDouble("FAT"));
                dietPlan.setMinerals(rs.getDouble("MINERALS"));
                dietPlan.setDietShow(rs.getInt("DIET_SHOW"));
                dietPlan.setDietComment(rs.getInt("DIET_COMMENT"));
                dietPlan.setUserNum(rs.getLong("USER_NUM"));

                dietPlans.add(dietPlan);
            }
        } catch (SQLException e) {
            throw new SQLException("Error while selecting DietPlans", e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return dietPlans;
    }

    // 식단 데이터 수정
    public void updateDietPlan(DietPlanVO dietPlan) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE DIETPLAN SET FOODNAME = ?, CALORIES = ?, PROTEIN = ?, CARBOHYDRATE = ?, FAT = ?, "
                   + "MINERALS = ?, DIET_SHOW = ?, DIET_COMMENT = ? WHERE DIETID = ?";

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, dietPlan.getFoodName());  // FOODNAME
            pstmt.setDouble(2, dietPlan.getCalories());  // CALORIES
            pstmt.setDouble(3, dietPlan.getProtein());   // PROTEIN
            pstmt.setDouble(4, dietPlan.getCarbohydrate()); // CARBOHYDRATE
            pstmt.setDouble(5, dietPlan.getFat());       // FAT
            pstmt.setDouble(6, dietPlan.getMinerals());  // MINERALS
            pstmt.setInt(7, dietPlan.getDietShow());     // DIET_SHOW
            pstmt.setInt(8, dietPlan.getDietComment());  // DIET_COMMENT
            pstmt.setLong(9, dietPlan.getDietId());      // DIETID (PK)

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error while updating DietPlan", e);
        } finally {
            DBUtil.executeClose(null, pstmt, conn);
        }
    }

    // 식단 데이터 삭제
    public void deleteDietPlan(long dietId) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM DIETPLAN WHERE DIETID = ?";

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, dietId);  // DIETID (PK)
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error while deleting DietPlan", e);
        } finally {
            DBUtil.executeClose(null, pstmt, conn);
        }
    }

    // 식단 데이터 조회 (특정 DIETID 기준)
    public DietPlanVO selectDietPlanByDietId(long dietId) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT DIETID, FOODNAME, CALORIES, PROTEIN, CARBOHYDRATE, FAT, MINERALS, DIET_SHOW, DIET_COMMENT, USER_NUM "
                   + "FROM DIETPLAN WHERE DIETID = ?";
        DietPlanVO dietPlan = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, dietId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dietPlan = new DietPlanVO();
                dietPlan.setDietId(rs.getLong("DIETID"));
                dietPlan.setFoodName(rs.getString("FOODNAME"));
                dietPlan.setCalories(rs.getDouble("CALORIES"));
                dietPlan.setProtein(rs.getDouble("PROTEIN"));
                dietPlan.setCarbohydrate(rs.getDouble("CARBOHYDRATE"));
                dietPlan.setFat(rs.getDouble("FAT"));
                dietPlan.setMinerals(rs.getDouble("MINERALS"));
                dietPlan.setDietShow(rs.getInt("DIET_SHOW"));
                dietPlan.setDietComment(rs.getInt("DIET_COMMENT"));
                dietPlan.setUserNum(rs.getLong("USER_NUM"));
            }
        } catch (SQLException e) {
            throw new SQLException("Error while selecting DietPlan by DietId", e);
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return dietPlan;
    }
    
    public List<DietPlanVO> searchDietByKeyword(String keyword, int startRow, int endRow) throws Exception {
        List<DietPlanVO> foodList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Oracle의 페이징을 위한 SQL
        String sql = "SELECT DIETID, FOODNAME FROM ( "
                   + "    SELECT DIETID, FOODNAME, ROW_NUMBER() OVER (ORDER BY DIETID DESC) AS row_num "
                   + "    FROM DIETPLAN "
                   + "    WHERE FOODNAME LIKE ? "
                   + ") "
                   + "WHERE row_num BETWEEN ? AND ?";

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            // 검색어에 %를 추가하여 부분 일치 검색을 수행
            pstmt.setString(1, "%" + keyword + "%");  // "%고구마%"와 같은 형태로 쿼리
            
            // 페이징 처리: 시작 행과 끝 행을 전달
            pstmt.setInt(2, startRow);  // 시작 인덱스 (예: 1, 11, 21...)
            pstmt.setInt(3, endRow);    // 끝 인덱스 (예: 10, 20, 30...)

            rs = pstmt.executeQuery();

            while (rs.next()) {
                DietPlanVO dietPlan = new DietPlanVO();
                dietPlan.setDietId(rs.getLong("DIETID"));
                dietPlan.setFoodName(rs.getString("FOODNAME"));
                foodList.add(dietPlan);
            }
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return foodList;
    }



    public int getDietCountByKeyword(String keyword) throws Exception {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT COUNT(*) FROM DIETPLAN WHERE FOODNAME LIKE ?";

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            DBUtil.executeClose(rs, pstmt, conn);
        }

        return count;
    }

    
}
