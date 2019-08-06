package com.spring.wetre.myeongjin.model;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.AccVO;
import com.spring.wetre.model.CompanyVO;
import com.spring.wetre.model.PersonalVO;

// DAO 선언
@Repository
public class LoginDAO implements InterLoginDAO {
	
	// 의존객체 주입하기(DI)
	@Autowired
	private SqlSessionTemplate sqlsession;

	
	// 개인회원 로그인 처리하기(트랜젝션)
	@Override
	public PersonalVO getLoginPrivateMember(HashMap<String, String> map) {
		PersonalVO loginuser = sqlsession.selectOne("kmj.getLoginPrivateMember", map);
		return loginuser;
	}
	@Override
	public void setLastPrivateMemberLoginDate(HashMap<String, String> map) {
		sqlsession.update("kmj.setLastPrivateMemberLoginDate", map);		
	}
	
	
	// 기업회원 로그인 처리하기
	@Override
	public CompanyVO getLoginCompanyMember(HashMap<String, String> map) {
		CompanyVO loginuser = sqlsession.selectOne("kmj.getLoginCompanyMember", map);
		return loginuser;
	}
	
	
	
	
	
	
	
}
