package com.spring.wetre.jgh.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.AES256;
import com.spring.wetre.jgh.model.InterMemberDAO;
import com.spring.wetre.model.CompanyVO;

// === #31. Service 선언 ===
@Service
public class MemberService implements InterMemberService {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private InterMemberDAO dao;
	
	//===== #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 암호화/복호화 하기위한 클래스 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired
	private AES256 aes;

	@Override
	public int isUseUserid(String cp_id) {
		int n = dao.isUseUserid(cp_id);
		return n;
	}

	
	// 회원가입 (, email 암호화)
	@Override
	public int registerMember(CompanyVO cvo ) {
		String email = "";
		try {				
			email = aes.encrypt(cvo.getCp_email());
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {			
			e.printStackTrace();
		}
		cvo.setCp_email(email);	
		int n = dao.registerMember(cvo);
		return n;
	}


	@Override
	public int updateMember(CompanyVO cvo) {
	
		int n = dao.updateMember(cvo);
		return n;
	}


	@Override
	public CompanyVO selectUserInfo(String cp_id) {
		CompanyVO selectUserInfo = dao.selectUserInfo(cp_id);
		try {
			selectUserInfo.setCp_email(aes.decrypt(selectUserInfo.getCp_email()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return selectUserInfo;
	}

	
	
	
}
