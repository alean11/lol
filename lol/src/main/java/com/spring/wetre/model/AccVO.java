package com.spring.wetre.model;

import com.spring.wetre.lyg.controller.RoomVO;

public class AccVO {

	private int acc_idx;
	private String cp_id;
	private int state;
	private String acc_name;
	private String acc_tel1;
	private String acc_tel2;
	private String acc_tel3;
	private String acc_post1;
	private String acc_post2;
	private String acc_addr1;
	private String acc_addr2;
	private String acc_img;
	private int acc_Rcnt;
	private int acc_status;
	private String acc_type;
	private int acc_grade;
	private String acc_text;
	
	// join 하면서 같이 받아와야해서
	private RoomVO room;	// 방정보 객체.
	
	// 인라인뷰로 합치면서, 새로운 컬럼들 넣어줘야 해서 넣어줌.
	private String region_name;
	private String region_shortname;
	
	private int cnt;
	
	public AccVO() {}

	public AccVO(int acc_idx, String cp_id, int state, String acc_name, String acc_tel1, String acc_tel2,
			String acc_tel3, String acc_post1, String acc_post2, String acc_addr1, String acc_addr2, String acc_img,
			int acc_Rcnt, int acc_status, String acc_type, int acc_grade, String acc_text, RoomVO room,
			String region_name, String region_shortname, int cnt) {
		super();
		this.acc_idx = acc_idx;
		this.cp_id = cp_id;
		this.state = state;
		this.acc_name = acc_name;
		this.acc_tel1 = acc_tel1;
		this.acc_tel2 = acc_tel2;
		this.acc_tel3 = acc_tel3;
		this.acc_post1 = acc_post1;
		this.acc_post2 = acc_post2;
		this.acc_addr1 = acc_addr1;
		this.acc_addr2 = acc_addr2;	
		this.acc_img = acc_img;
		this.acc_Rcnt = acc_Rcnt;
		this.acc_status = acc_status;
		this.acc_type = acc_type;
		this.acc_grade = acc_grade;
		this.acc_text = acc_text;
		this.room = room;
		this.region_name = region_name;
		this.region_shortname = region_shortname;
		this.cnt = cnt;
	}

	public int getAcc_idx() {
		return acc_idx;
	}

	public void setAcc_idx(int acc_idx) {
		this.acc_idx = acc_idx;
	}

	public String getCp_id() {
		return cp_id;
	}

	public void setCp_id(String cp_id) {
		this.cp_id = cp_id;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getAcc_name() {
		return acc_name;
	}

	public void setAcc_name(String acc_name) {
		this.acc_name = acc_name;
	}

	public String getAcc_tel1() {
		return acc_tel1;
	}

	public void setAcc_tel1(String acc_tel1) {
		this.acc_tel1 = acc_tel1;
	}

	public String getAcc_tel2() {
		return acc_tel2;
	}

	public void setAcc_tel2(String acc_tel2) {
		this.acc_tel2 = acc_tel2;
	}

	public String getAcc_tel3() {
		return acc_tel3;
	}

	public void setAcc_tel3(String acc_tel3) {
		this.acc_tel3 = acc_tel3;
	}

	public String getAcc_post1() {
		return acc_post1;
	}

	public void setAcc_post1(String acc_post1) {
		this.acc_post1 = acc_post1;
	}

	public String getAcc_post2() {
		return acc_post2;
	}

	public void setAcc_post2(String acc_post2) {
		this.acc_post2 = acc_post2;
	}

	public String getAcc_addr1() {
		return acc_addr1;
	}

	public void setAcc_addr1(String acc_addr1) {
		this.acc_addr1 = acc_addr1;
	}

	public String getAcc_addr2() {
		return acc_addr2;
	}

	public void setAcc_addr2(String acc_addr2) {
		this.acc_addr2 = acc_addr2;
	}

	public String getAcc_img() {
		return acc_img;
	}

	public void setAcc_img(String acc_img) {
		this.acc_img = acc_img;
	}

	public int getAcc_Rcnt() {
		return acc_Rcnt;
	}

	public void setAcc_Rcnt(int acc_Rcnt) {
		this.acc_Rcnt = acc_Rcnt;
	}

	public int getAcc_status() {
		return acc_status;
	}

	public void setAcc_status(int acc_status) {
		this.acc_status = acc_status;
	}

	public String getAcc_type() {
		return acc_type;
	}

	public void setAcc_type(String acc_type) {
		this.acc_type = acc_type;
	}

	public int getAcc_grade() {
		return acc_grade;
	}

	public void setAcc_grade(int acc_grade) {
		this.acc_grade = acc_grade;
	}

	public String getAcc_text() {
		return acc_text;
	}

	public void setAcc_text(String acc_text) {
		this.acc_text = acc_text;
	}

	public RoomVO getRoom() {
		return room;
	}

	public void setRoom(RoomVO room) {
		this.room = room;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}

	public String getRegion_shortname() {
		return region_shortname;
	}

	public void setRegion_shortname(String region_shortname) {
		this.region_shortname = region_shortname;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	
	
	
}
