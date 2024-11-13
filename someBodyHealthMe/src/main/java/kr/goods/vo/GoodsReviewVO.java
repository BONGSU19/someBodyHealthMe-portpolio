package kr.goods.vo;

import java.sql.Date;

public class GoodsReviewVO {
	private long re_num;
	private String re_content;
	private int re_rating;
	private Date re_date;
	private Date re_mdate;
	private String re_ip;
	private long goods_num;
	private long user_num;
	
	public long getRe_num() {
		return re_num;
	}
	public void setRe_num(long re_num) {
		this.re_num = re_num;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public int getRe_rating() {
		return re_rating;
	}
	public void setRe_rating(int re_rating) {
		this.re_rating = re_rating;
	}
	public Date getRe_date() {
		return re_date;
	}
	public void setRe_date(Date re_date) {
		this.re_date = re_date;
	}
	public Date getRe_mdate() {
		return re_mdate;
	}
	public void setRe_mdate(Date re_mdate) {
		this.re_mdate = re_mdate;
	}
	public String getRe_ip() {
		return re_ip;
	}
	public void setRe_ip(String re_ip) {
		this.re_ip = re_ip;
	}
	public long getGoods_num() {
		return goods_num;
	}
	public void setGoods_num(long goods_num) {
		this.goods_num = goods_num;
	}
	public long getUser_num() {
		return user_num;
	}
	public void setUser_num(long user_num) {
		this.user_num = user_num;
	}
}
