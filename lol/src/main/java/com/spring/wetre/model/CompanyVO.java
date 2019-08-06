package com.spring.wetre.model;

public class CompanyVO {

	private int idx;
	private String cp_id;
	private String cp_pwd;
	private String cp_num1;
	private String cp_num2;
	private String cp_num3;
	private String cp_name;
	private String ceoname;
	private String cp_email;
	private String cp_tel1;
	private String cp_tel2;
	private String cp_tel3;
	private int status;
	
	
	public CompanyVO() {}
	public CompanyVO(int idx, String cp_id, String cp_pwd, String cp_num1, String cp_num2, String cp_num3,
			String cp_name, String ceoname, String cp_email, String cp_tel1, String cp_tel2, String cp_tel3, int status) {
		this.idx = idx;
		this.cp_id = cp_id;
		this.cp_pwd = cp_pwd;
		this.cp_num1 = cp_num1;
		this.cp_num2 = cp_num2;
		this.cp_num3 = cp_num3;
		this.cp_name = cp_name;
		this.ceoname = ceoname;
		this.cp_email = cp_email;
		this.cp_tel1 = cp_tel1;
		this.cp_tel2 = cp_tel2;
		this.cp_tel3 = cp_tel3;
		this.status = status;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getCp_id() {
		return cp_id;
	}
	public void setCp_id(String cp_id) {
		this.cp_id = cp_id;
	}
	public String getCp_pwd() {
		return cp_pwd;
	}
	public void setCp_pwd(String cp_pwd) {
		this.cp_pwd = cp_pwd;
	}
	public String getCp_num1() {
		return cp_num1;
	}
	public void setCp_num1(String cp_num1) {
		this.cp_num1 = cp_num1;
	}
	public String getCp_num2() {
		return cp_num2;
	}
	public void setCp_num2(String cp_num2) {
		this.cp_num2 = cp_num2;
	}
	public String getCp_num3() {
		return cp_num3;
	}
	public void setCp_num3(String cp_num3) {
		this.cp_num3 = cp_num3;
	}
	public String getCp_name() {
		return cp_name;
	}
	public void setCp_name(String cp_name) {
		this.cp_name = cp_name;
	}
	public String getCeoname() {
		return ceoname;
	}
	public void setCeoname(String ceoname) {
		this.ceoname = ceoname;
	}
	public String getCp_email() {
		return cp_email;
	}
	public void setCp_email(String cp_email) {
		this.cp_email = cp_email;
	}
	public String getCp_tel1() {
		return cp_tel1;
	}
	public void setCp_tel1(String cp_tel1) {
		this.cp_tel1 = cp_tel1;
	}
	public String getCp_tel2() {
		return cp_tel2;
	}
	public void setCp_tel2(String cp_tel2) {
		this.cp_tel2 = cp_tel2;
	}
	public String getCp_tel3() {
		return cp_tel3;
	}
	public void setCp_tel3(String cp_tel3) {
		this.cp_tel3 = cp_tel3;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
