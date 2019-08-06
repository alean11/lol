package com.spring.wetre.jgh.model;

import java.util.List;

import com.spring.wetre.model.CompanyVO;

public interface InterMemberDAO {

	int isUseUserid(String cp_id);

	int registerMember(CompanyVO cvo); // 기업회원가입

	int updateMember(CompanyVO cvo); // 기업회원 정보수정

	CompanyVO selectUserInfo(String cp_id);


}
