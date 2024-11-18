package kr.mybody.vo;

public class InbodyStatusVO {
	private String month; // 월 (예: "2023-01")
    private double avgMuscleMass; // 월별 평균 근육량
    private double avgBodyFatPercentage; // 월별 평균 체지방률
    
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public double getAvgMuscleMass() {
		return avgMuscleMass;
	}
	public void setAvgMuscleMass(double avgMuscleMass) {
		this.avgMuscleMass = avgMuscleMass;
	}
	public double getAvgBodyFatPercentage() {
		return avgBodyFatPercentage;
	}
	public void setAvgBodyFatPercentage(double avgBodyFatPercentage) {
		this.avgBodyFatPercentage = avgBodyFatPercentage;
	}
    
    
    
}
