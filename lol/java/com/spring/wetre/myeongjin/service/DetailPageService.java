package com.spring.wetre.myeongjin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wetre.model.AccVO;
import com.spring.wetre.myeongjin.model.InterDetailPageDAO;


//Service 선언
@Service
public class DetailPageService implements InterDetailPageService {

	// 의존객체 주입하기(DI)
		@Autowired
		private InterDetailPageDAO dao;
		
		
		// 고유번호를 가지고 해당 숙박시설의 정보를 조회해오기
		@Override
		public AccVO getOneAccInfomation(int acc_idx) {
			
			AccVO avo = dao.getOneAccInfomation(acc_idx);
			return avo;
		}

		// 구글 지도 사용하기
		@Override
		public List<AccVO> getaccList(int acc_idx) {
			List<AccVO> accList = dao.getaccList(acc_idx);
			return accList;
		}

}
