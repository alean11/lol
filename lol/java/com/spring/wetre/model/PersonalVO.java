package com.spring.wetre.model;

public class PersonalVO {

	private int idx;
	private String p_userid;
	private String p_pwd;
	private String p_name;
	private String p_email;
	private String p_birthday;
	private int p_gender;
	private String p_hp1;
	private String p_hp2;
	private String p_hp3;
	private String p_post1;
	private String p_post2;
	private String p_addr1;
	private String p_addr2;
	private String p_registerday;
	private String p_lastlogin;
	private String p_lastpwdchg;
	private int p_status;

    /////////////////////////////////////////////////////////////////////////////////////
	private boolean requirePwdChange = false; 
	private boolean idleStatus = false;
	private int lastlogindategap;   
	private int pwdchangegap;       
	public PersonalVO() {}
	public PersonalVO(int idx, String p_userid, String p_pwd, String p_name, String p_email, String p_birthday,
			int p_gender, String p_hp1, String p_hp2, String p_hp3, String p_post1, String p_post2, String p_addr1,
			String p_addr2, String p_registerday, String p_lastlogin, String p_lastpwdchg, int p_status) {
		this.idx = idx;
		this.p_userid = p_userid;
		this.p_pwd = p_pwd;
		this.p_name = p_name;
		this.p_email = p_email;
		this.p_birthday = p_birthday;
		this.p_gender = p_gender;
		this.p_hp1 = p_hp1;
		this.p_hp2 = p_hp2;
		this.p_hp3 = p_hp3;
		this.p_post1 = p_post1;
		this.p_post2 = p_post2;
		this.p_addr1 = p_addr1;
		this.p_addr2 = p_addr2;
		this.p_registerday = p_registerday;
		this.p_lastlogin = p_lastlogin;
		this.p_lastpwdchg = p_lastpwdchg;
		this.p_status = p_status;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getP_userid() {
		return p_userid;
	}
	public void setP_userid(String p_userid) {
		this.p_userid = p_userid;
	}
	public String getP_pwd() {
		return p_pwd;
	}
	public void setP_pwd(String p_pwd) {
		this.p_pwd = p_pwd;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_email() {
		return p_email;
	}
	public void setP_email(String p_email) {
		this.p_email = p_email;
	}
	public String getP_birthday() {
		return p_birthday;
	}
	public void setP_birthday(String p_birthday) {
		this.p_birthday = p_birthday;
	}
	public int getP_gender() {
		return p_gender;
	}
	public void setP_gender(int p_gender) {
		this.p_gender = p_gender;
	}
	public String getP_hp1() {
		return p_hp1;
	}
	public void setP_hp1(String p_hp1) {
		this.p_hp1 = p_hp1;
	}
	public String getP_hp2() {
		return p_hp2;
	}
	public void setP_hp2(String p_hp2) {
		this.p_hp2 = p_hp2;
	}
	public String getP_hp3() {
		return p_hp3;
	}
	public void setP_hp3(String p_hp3) {
		this.p_hp3 = p_hp3;
	}
	public String getP_post1() {
		return p_post1;
	}
	public void setP_post1(String p_post1) {
		this.p_post1 = p_post1;
	}
	public String getP_post2() {
		return p_post2;
	}
	public void setP_post2(String p_post2) {
		this.p_post2 = p_post2;
	}
	public String getP_addr1() {
		return p_addr1;
	}
	public void setP_addr1(String p_addr1) {
		this.p_addr1 = p_addr1;
	}
	public String getP_addr2() {
		return p_addr2;
	}
	public void setP_addr2(String p_addr2) {
		this.p_addr2 = p_addr2;
	}
	public String getP_registerday() {
		return p_registerday;
	}
	public void setP_registerday(String p_registerday) {
		this.p_registerday = p_registerday;
	}
	public String getP_lastlogin() {
		return p_lastlogin;
	}
	public void setP_lastlogin(String p_lastlogin) {
		this.p_lastlogin = p_lastlogin;
	}
	public String getP_lastpwdchg() {
		return p_lastpwdchg;
	}
	public void setP_lastpwdchg(String p_lastpwdchg) {
		this.p_lastpwdchg = p_lastpwdchg;
	}
	public int getP_status() {
		return p_status;
	}
	public void setP_status(int p_status) {
		this.p_status = p_status;
	}
	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}
	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	public boolean isIdleStatus() {
		return idleStatus;
	}
	public void setIdleStatus(boolean idleStatus) {
		this.idleStatus = idleStatus;
	}
	public int getLastlogindategap() {
		return lastlogindategap;
	}
	public void setLastlogindategap(int lastlogindategap) {
		this.lastlogindategap = lastlogindategap;
	}
	public int getPwdchangegap() {
		return pwdchangegap;
	}
	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}
	
	
	
}
