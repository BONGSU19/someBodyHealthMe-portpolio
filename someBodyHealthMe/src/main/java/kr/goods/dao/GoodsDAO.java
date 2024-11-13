package kr.goods.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.goods.vo.GoodsVO;
import kr.util.DBUtil;

public class GoodsDAO {
	//싱글턴 패턴
	private static GoodsDAO instance = new GoodsDAO();
	public static GoodsDAO getInstance() {
		return instance;
	}
	private GoodsDAO() {}
	
	//글 등록 (상품등록)
	public void insertGoods(GoodsVO goods)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO goods (goods_num, goods_name, goods_price, goods_info, goods_stock, "
					+ "goods_category, goods_img, goods_date) VALUES (goods_seq.nextval,?,?,?,?,?,?,SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, goods.getGoods_name());
			pstmt.setInt(2, goods.getGoods_price());
			pstmt.setString(3, goods.getGoods_info());
			pstmt.setInt(4, goods.getGoods_stock());
			pstmt.setString(5, goods.getGoods_category());
			pstmt.setString(6, goods.getGoods_img());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//전체글 개수/검색글 개수
	//전체글 목록/검색글 목록
	//글 상세 (상품상세)
	//파일삭제
	//글 수정
	//글 삭제
	//좋아요 개수
	//좋아요 등록
	//좋아요 삭제
	//내가 선택한 좋아요 목록
	//댓글 등록 (리뷰 등록)
	//리뷰 점수 등록
	//댓글 개수 (리뷰 개수)
	//댓글 상세 (리뷰 수정, 삭제시 작성자 회원번호 체크용도로 사용)
	//댓글 수정 (리뷰 수정)
	//댓글 삭제 (리뷰 삭제)
	
}
