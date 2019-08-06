package com.spring.wetre.myeongjin.model;

import java.util.HashMap;
import java.util.List;

import com.spring.wetre.model.AccVO;
import com.spring.wetre.model.CompanyVO;
import com.spring.wetre.model.PersonalVO;

public interface InterDetailPageDAO {

	// 고유번호를 가지고 해당 숙박시설의 정보를 조회해오기
	AccVO getOneAccInfomation(int acc_idx);

	// 구글 지도 사용하기
	List<AccVO> getaccList(int acc_idx); 
}
