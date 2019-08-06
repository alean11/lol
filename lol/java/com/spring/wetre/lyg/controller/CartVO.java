package com.spring.wetre.lyg.controller;

import com.spring.wetre.model.AccVO;

public class CartVO {
	
	private int cartno;
	private String p_userid;
	private String p_name;
	private int r_idx;
	private int cart_price;
	private int cart_cnt;
	private String fk_acc_name;
	private String fk_rtype_name;
	private String full_acc_addr;
	private String full_acc_tel;
	private String reserver;
	private int adultNum;
	private int kidsNum;
	private String contactinfo;
	private String payMethod;
	private String requesttxt;
	private String book_start;
	private String book_end;
	private String expectedtime;
	private String acc_grade;
	
	private AccVO accvo;
	public CartVO() {}
	public CartVO(int cartno, String p_userid, String p_name, int r_idx, int cart_price, int cart_cnt,
			String fk_acc_name, String fk_rtype_name, String full_acc_addr, String full_acc_tel, String reserver,
			int adultNum, int kidsNum, String contactinfo, String payMethod, String requesttxt, String book_start,
			String book_end, String expectedtime, String acc_grade, AccVO accvo) {
		super();
		this.cartno = cartno;
		this.p_userid = p_userid;
		this.p_name = p_name;
		this.r_idx = r_idx;
		this.cart_price = cart_price;
		this.cart_cnt = cart_cnt;
		this.fk_acc_name = fk_acc_name;
		this.fk_rtype_name = fk_rtype_name;
		this.full_acc_addr = full_acc_addr;
		this.full_acc_tel = full_acc_tel;
		this.reserver = reserver;
		this.adultNum = adultNum;
		this.kidsNum = kidsNum;
		this.contactinfo = contactinfo;
		this.payMethod = payMethod;
		this.requesttxt = requesttxt;
		this.book_start = book_start;
		this.book_end = book_end;
		this.expectedtime = expectedtime;
		this.acc_grade = acc_grade;
		this.accvo = accvo;
	}
	public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public String getP_userid() {
		return p_userid;
	}
	public void setP_userid(String p_userid) {
		this.p_userid = p_userid;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public int getR_idx() {
		return r_idx;
	}
	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}
	public int getCart_price() {
		return cart_price;
	}
	public void setCart_price(int cart_price) {
		this.cart_price = cart_price;
	}
	public int getCart_cnt() {
		return cart_cnt;
	}
	public void setCart_cnt(int cart_cnt) {
		this.cart_cnt = cart_cnt;
	}
	public String getFk_acc_name() {
		return fk_acc_name;
	}
	public void setFk_acc_name(String fk_acc_name) {
		this.fk_acc_name = fk_acc_name;
	}
	public String getFk_rtype_name() {
		return fk_rtype_name;
	}
	public void setFk_rtype_name(String fk_rtype_name) {
		this.fk_rtype_name = fk_rtype_name;
	}
	public String getFull_acc_addr() {
		return full_acc_addr;
	}
	public void setFull_acc_addr(String full_acc_addr) {
		this.full_acc_addr = full_acc_addr;
	}
	public String getFull_acc_tel() {
		return full_acc_tel;
	}
	public void setFull_acc_tel(String full_acc_tel) {
		this.full_acc_tel = full_acc_tel;
	}
	public String getReserver() {
		return reserver;
	}
	public void setReserver(String reserver) {
		this.reserver = reserver;
	}
	public int getadultNum() {
		return adultNum;
	}
	public void setadultNum(int adultNum) {
		this.adultNum = adultNum;
	}
	public int getkidsNum() {
		return kidsNum;
	}
	public void setkidsNum(int kidsNum) {
		this.kidsNum = kidsNum;
	}
	public String getContactinfo() {
		return contactinfo;
	}
	public void setContactinfo(String contactinfo) {
		this.contactinfo = contactinfo;
	}
	public String getpayMethod() {
		return payMethod;
	}
	public void setpayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public String getRequesttxt() {
		return requesttxt;
	}
	public void setRequesttxt(String requesttxt) {
		this.requesttxt = requesttxt;
	}
	public String getBook_start() {
		return book_start;
	}
	public void setBook_start(String book_start) {
		this.book_start = book_start;
	}
	public String getBook_end() {
		return book_end;
	}
	public void setBook_end(String book_end) {
		this.book_end = book_end;
	}
	public String getExpectedtime() {
		return expectedtime;
	}
	public void setExpectedtime(String expectedtime) {
		this.expectedtime = expectedtime;
	}
	public String getAcc_grade() {
		return acc_grade;
	}
	public void setAcc_grade(String acc_grade) {
		this.acc_grade = acc_grade;
	}
	public AccVO getAccvo() {
		return accvo;
	}
	public void setAccvo(AccVO accvo) {
		this.accvo = accvo;
	}
	
	

}
