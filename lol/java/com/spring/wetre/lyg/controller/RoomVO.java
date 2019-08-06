package com.spring.wetre.lyg.controller;

public class RoomVO {
	private int r_idx;
	private int acc_idx;
	private String r_kind;
	private String r_text;
	private int r_cnt;
	private int ay_fee;
	private int k_fee;
	public RoomVO() {}
	public RoomVO(int r_idx, int acc_idx, String r_kind, String r_text, int r_cnt, int ay_fee, int k_fee) {
		super();
		this.r_idx = r_idx;
		this.acc_idx = acc_idx;
		this.r_kind = r_kind;
		this.r_text = r_text;
		this.r_cnt = r_cnt;
		this.ay_fee = ay_fee;
		this.k_fee = k_fee;
	}
	public int getR_idx() {
		return r_idx;
	}
	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}
	public int getAcc_idx() {
		return acc_idx;
	}
	public void setAcc_idx(int acc_idx) {
		this.acc_idx = acc_idx;
	}
	public String getR_kind() {
		return r_kind;
	}
	public void setR_kind(String r_kind) {
		this.r_kind = r_kind;
	}
	public String getR_text() {
		return r_text;
	}
	public void setR_text(String r_text) {
		this.r_text = r_text;
	}
	public int getR_cnt() {
		return r_cnt;
	}
	public void setR_cnt(int r_cnt) {
		this.r_cnt = r_cnt;
	}
	public int getAy_fee() {
		return ay_fee;
	}
	public void setAy_fee(int ay_fee) {
		this.ay_fee = ay_fee;
	}
	public int getK_fee() {
		return k_fee;
	}
	public void setK_fee(int k_fee) {
		this.k_fee = k_fee;
	}
	 
	

}
