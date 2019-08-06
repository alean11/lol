package com.spring.wetre.myeongjin.model;

import java.util.HashMap;

import com.spring.wetre.model.AccVO;
import com.spring.wetre.model.CompanyVO;
import com.spring.wetre.model.PersonalVO;

public interface InterLoginDAO {

	// 개인회원 로그인 처리하기
	PersonalVO getLoginPrivateMember(HashMap<String, String> map);

	// 마지막으로 로그인 한 날짜시간 변경(기록)하기
	 void setLastPrivateMemberLoginDate(HashMap<String, String> map);

	// 기업회원 로그인 처리하기
	CompanyVO getLoginCompanyMember(HashMap<String, String> map);
	 
}
