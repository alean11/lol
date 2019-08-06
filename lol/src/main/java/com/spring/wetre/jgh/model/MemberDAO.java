package com.spring.wetre.jgh.model;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.CompanyVO;

// === #32. DAO 선언 ===
@Repository
public class MemberDAO implements InterMemberDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private SqlSessionTemplate sqlsession;

	@Override
	public int isUseUserid(String cp_id) {
		int n = sqlsession.selectOne("jgh.isUseUserid",cp_id);
		return n;
	}

	@Override
	public int registerMember(CompanyVO cvo) {	
		int n = sqlsession.insert("jgh.registerMember",cvo);
		return n;
	}

	@Override
	public int updateMember(CompanyVO cvo) {
		int n = sqlsession.update("jgh.updateMember",cvo);
		return n;
	}

	@Override
	public CompanyVO selectUserInfo(String cp_id) {
		CompanyVO selectUserInfo =  sqlsession.selectOne("jgh.selectUserInfo",cp_id);
		return selectUserInfo;
	}

	
	
}
