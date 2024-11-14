package kr.member.vo;

import java.sql.Date;
 
public class MemberVO {
    private long user_num; // 회원번호 (USER 테이블의 PK)
    private String login_id; // 로그인 ID
    private int status; // 계정 상태 (int로 수정)
    private String nick_name; // 닉네임 (USER_DETAIL 테이블)
    private String name; // 이름
    private String email; // 이메일
    private String password; // 비밀번호
    private String phone; // 전화번호
    private Date registration_date; // 가입 날짜
    private String birth_date; // 생년월일 (String으로 수정)
    private Date modify_date; // 수정 날짜
    private int center_num; // 센터 번호 (1 = 강남, 2 = 강북)
    private int admin_code; // 관리자 코드

    // 비밀번호 일치 여부 체크
    public boolean isCheckedPassword(String inputPassword) {
        return password != null && password.equals(inputPassword);
    }

    // Getter and Setter methods
    public long getUser_num() {
        return user_num;
    }

    public void setUser_num(long user_num) {
        this.user_num = user_num;
    }

    public String getLogin_id() {
        return login_id;
    }

    public void setLogin_id(String login_id) {
        this.login_id = login_id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {  // 수정된 부분
        this.status = status;
    }

    public String getNick_name() {
        return nick_name;
    }

    public void setNick_name(String nick_name) {
        this.nick_name = nick_name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getRegistration_date() {
        return registration_date;
    }

    public void setRegistration_date(Date registration_date) {
        this.registration_date = registration_date;
    }

    public String getBirth_date() {
        return birth_date;
    }

    public void setBirth_date(String birth_date) {
        this.birth_date = birth_date;
    }

    public Date getModify_date() {
        return modify_date;
    }

    public void setModify_date(Date modify_date) {
        this.modify_date = modify_date;
    }

    public int getCenter_num() {
        return center_num;
    }

    public void setCenter_num(int center_num) {
        this.center_num = center_num;
    }

    public int getAdmin_code() {
        return admin_code;
    }

    public void setAdmin_code(int admin_code) {
        this.admin_code = admin_code;
    }
}