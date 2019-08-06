package com.spring.wetre.myeongjin.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.AccVO;

//DAO 선언
@Repository
public class DetailPageDAO implements InterDetailPageDAO {

	// 의존객체 주입하기(DI)
	@Autowired
	private SqlSessionTemplate sqlsession;

	// 고유번호를 가지고 해당 숙박시설의 정보를 조회해오기
	@Override
	public AccVO getOneAccInfomation(int acc_idx) {
		AccVO avo = sqlsession.selectOne("kmj.getOneAccInfomation", acc_idx);		
		return avo;
	}

	// 구글 지도 사용하기
	@Override
	public List<AccVO> getaccList(int acc_idx) {
		List<AccVO> accList = sqlsession.selectList("kmj.getaccList", acc_idx);
		return accList;
	}

}



