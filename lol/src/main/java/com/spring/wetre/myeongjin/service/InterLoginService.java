package com.spring.wetre.myeongjin.service;

import java.util.HashMap;

import com.spring.wetre.model.AccVO;
import com.spring.wetre.model.CompanyVO;
import com.spring.wetre.model.PersonalVO;


public interface InterLoginService {

	// 개인회원 로그인 처리하기
	PersonalVO getLoginPrivateMember(HashMap<String, String> map);

	// 기업회원 로그인 처리하기
	CompanyVO getLoginCompanyMember(HashMap<String, String> map);

	 

}
