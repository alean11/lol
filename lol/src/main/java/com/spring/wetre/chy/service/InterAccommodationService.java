package com.spring.wetre.chy.service;

import java.util.*;

import com.spring.wetre.model.AccVO;

public interface InterAccommodationService {


	// #y3. 검색어 (미)포함 상품목록
	List<AccVO> getAccList(HashMap<String, Object> optMap);

	// #y3. 검색어 (미)포함 총 게시물 수
	int getAccListCount(HashMap<String, Object> optMap);
	
	// #y3. 뷰단 옵션에 뿌려줄 호텔 등급별 개수 가져옴.
	List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap);

	// #y3. 뷰단 옵션에 뿌려줄 호텔 타입별 개수 가져옴.
	List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap);

	// #y3. 태그 클라우드 뽑기
	List<HashMap<String, Object>> getTagList();

	// #y5. 호텔주소 & 호텔이름 뽑아옴.
	List<AccVO> autoSearchWord(HashMap<String, String> ajaxMap);

	// #y5. 호텔 위치한 지역 뽑아옴.
	List<HashMap<String, String>> getRegionList(HashMap<String, String> ajaxMap);




	

}
