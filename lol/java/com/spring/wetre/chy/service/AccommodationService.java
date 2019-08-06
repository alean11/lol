package com.spring.wetre.chy.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.AES256;
import com.spring.wetre.chy.model.InterAccommodationDAO;
import com.spring.wetre.model.AccVO;

/// 서비스 선언 ///
@Service
public class AccommodationService implements InterAccommodationService {

	/// DAO 의존객체 주입  ///
	@Autowired
	private InterAccommodationDAO dao;

	/// 암호화/복호화 의존객체 주입 ///
	@Autowired
	private AES256 aes;

	
	
	
	

	// #y3. 검색어 (미)포함 상품목록
	@Override
	public List<AccVO> getAccList(HashMap<String, Object> optMap) {
		List<AccVO> accList = dao.getAccList(optMap);
		return accList;
	}
	
	// #y3. 검색어 (미)포함 총 게시물 수
	@Override
	public int getAccListCount(HashMap<String, Object> optMap) {
		int totalAccCnt = dao.getAccListCount(optMap);
		return totalAccCnt;
	}

	// #y3. 호텔 등급별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accGradeCnt = dao.getAccGradeCnt(optMap);
		return accGradeCnt;
	}

	// #y3. 호텔 타입별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accTypeCnt = dao.getAccTypeCnt(optMap);
		return accTypeCnt;
	}
	
	// #y3. 태그 클라우드
	@Override
	public List<HashMap<String, Object>> getTagList() {
		List<HashMap<String, Object>> tagList = dao.getTagList();
		return tagList;
	}

	
	// #y5. 호텔주소 & 호텔이름 뽑아옴.
	@Override
	public List<AccVO> autoSearchWord(HashMap<String, String> ajaxMap) {
		List<AccVO> weWordList = dao.getAutoSearchWord(ajaxMap);
		return weWordList;
	}


	// #y5. 호텔 위치한 지역 뽑아옴.
	@Override
	public List<HashMap<String, String>> getRegionList(HashMap<String, String> ajaxMap) {
		List<HashMap<String, String>> regionList = dao.getRegionList(ajaxMap);
		return regionList;
	}

	
	
}
