package kr.mybody.vo;

import java.sql.Date;

public class MyBodyStatusVO {
	
	// 필드 정의 (테이블 컬럼에 대응)
    private long healthInfoID;    // HealthInfoID
    private double height;        // Height
    private double weight;        // Weight
    private int age;              // Age
    private double bmi;           // BMI
    private String goal;          // Goal
    private String gender;        // Gender
    private Date createdAt;       // CreatedAt
    private Date modifyDate;      // ModifyDate
    private long userNum;         // user_num
    
    
	public long getHealthInfoID() {
		return healthInfoID;
	}
	public void setHealthInfoID(long healthInfoID) {
		this.healthInfoID = healthInfoID;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public double getBmi() {
		return bmi;
	}
	public void setBmi(double bmi) {
		this.bmi = bmi;
	}
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public long getUserNum() {
		return userNum;
	}
	public void setUserNum(long userNum) {
		this.userNum = userNum;
	}
	
	// toString 메소드 (옵션)
    @Override
    public String toString() {
        return "Healthinfo [healthInfoID=" + healthInfoID + ", height=" + height + ", weight=" + weight 
                + ", age=" + age + ", bmi=" + bmi + ", goal=" + goal + ", gender=" + gender 
                + ", createdAt=" + createdAt + ", modifyDate=" + modifyDate + ", userNum=" + userNum + "]";
    }
    
    
}
