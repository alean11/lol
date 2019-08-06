package com.spring.wetre.myeongjin.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.AES256;
import com.spring.wetre.model.AccVO;
import com.spring.wetre.model.CompanyVO;
import com.spring.wetre.model.PersonalVO;
import com.spring.wetre.myeongjin.model.InterLoginDAO;

// Service 선언
@Service
public class LoginService implements InterLoginService {
	
	// 의존객체 주입하기(DI)
	@Autowired
	private InterLoginDAO dao;
	
	// 양방향 암호화 알고리즘인 AES256 를 사용하여 암호화/복호화 하기위한 클래스 의존객체 주입하기
	@Autowired
	private AES256 aes;
	
	// 개인회원 로그인 처리하기
	@Override
	public PersonalVO getLoginPrivateMember(HashMap<String, String> map) {
		
		// 로그인 시 마지막 로그인 날짜 오늘로 수정하기(트렌젝션 처리)
		PersonalVO loginuser = dao.getLoginPrivateMember(map);
		
		
		// aes 의존객체를 사용하여 로그인 되어진 사용자(loginuser)의 이메일주소를 복호화해서 보여준다.
		if(loginuser != null) {
			
			if( loginuser.getLastlogindategap() >= 12) {
				// 마지막으로 로그인 한 날짜가 현재일로부터 1년(12개월)이 지났으면 해당 로그인 계정을 비활성화(휴면) 처리한다.
				
				loginuser.setIdleStatus(true);
				
				//// 아래는  로그인 한지 1년이 지났지만 정상적으로 로그인 처리를 해주는 것 ////
				//// 정상적으로 로그인 처리를 허락하지 않으려면 아래부분은 삭제해야 한다.
				
				dao.setLastPrivateMemberLoginDate(map);  // 마지막으로 로그인 한 날짜시간 변경(기록)하기
				
				try {
					loginuser.setP_email(aes.decrypt(loginuser.getP_email())); // 빨간말이 나오면 try/catch를 해주어야 한다.
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				} 
				
				///////////////////////////////////////////////////////////////
			}
			else {
				
				if(loginuser.getPwdchangegap() > 3) {
					// 마지막으로 암호를 변경한 날짜가 현재 시각으로부터 3개월이 지났으면 true
					loginuser.setRequirePwdChange(true);
				}
				
				
				dao.setLastPrivateMemberLoginDate(map);  // 마지막으로 로그인 한 날짜시간 변경(기록)하기
							
				try {
					loginuser.setP_email(aes.decrypt(loginuser.getP_email())); // 빨간말이 나오면 try/catch를 해주어야 한다.
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				} 
			}
					
		}
		
		return loginuser;
	}

	// 기업회원 로그인 처리하기
	@Override
	public CompanyVO getLoginCompanyMember(HashMap<String, String> map) {
		// 로그인 시 마지막 로그인 날짜 오늘로 수정하기(트렌젝션 처리)
		CompanyVO companyuser = dao.getLoginCompanyMember(map);
			
			
			// aes 의존객체를 사용하여 로그인 되어진 사용자(loginuser)의 이메일주소를 복호화해서 보여준다.
			if(companyuser != null) {
									
				try {
					companyuser.setCp_email(aes.decrypt(companyuser.getCp_email())); // 빨간말이 나오면 try/catch를 해주어야 한다.
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				} 
				
				///////////////////////////////////////////////////////////////
			}	
										
			return companyuser;
	}
	
	
	

}
