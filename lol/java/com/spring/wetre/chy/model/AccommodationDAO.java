package com.spring.wetre.chy.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.model.AccVO;


/// DAO 선언 ///
@Repository
public class AccommodationDAO implements InterAccommodationDAO {

	/// myBatis(JDBC) sqlSessionTemplate 의존 객체 주입 ///
	@Autowired
	private SqlSessionTemplate sqlsession;

	
	
	
	
	
	
	// #y3. 검색어 (미)포함 상품목록
	@Override
	public List<AccVO> getAccList(HashMap<String, Object> optMap) {
		List<AccVO> accList = sqlsession.selectList("chy.getAccList", optMap);
		for(AccVO accvo : accList) {System.out.println("호텔이름(dao임): "+accvo.getAcc_name());}
		return accList;
	}

	
	// #y3. 검색어 (미)포함 총 게시물 수
	@Override
	public int getAccListCount(HashMap<String, Object> optMap) {
		int totalAccCnt = sqlsession.selectOne("chy.getAccListCount", optMap);
		return totalAccCnt;
	}	

	// #y3. 호텔 등급별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccGradeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accGradeCnt = sqlsession.selectList("chy.getAccGradeCnt", optMap);
		return accGradeCnt;
	}


	// #y3. 호텔 타입별 개수 뽑기
	@Override
	public List<HashMap<String, Object>> getAccTypeCnt(HashMap<String, Object> optMap) {
		List<HashMap<String, Object>> accTypeCnt = sqlsession.selectList("chy.getAccTypeCnt", optMap);
		return accTypeCnt;
	}

	
	// #y3. 태그 클라우드
	@Override
	public List<HashMap<String, Object>> getTagList() {
		List<HashMap<String, Object>> tagList = sqlsession.selectList("chy.getTagList");
		return tagList;
	}
	

	// #y5. 호텔주소 & 호텔이름 뽑아옴.
	@Override
	public List<AccVO> getAutoSearchWord(HashMap<String, String> ajaxMap) {
		List<AccVO> weWordList = sqlsession.selectList("chy.getAutoSearchWord", ajaxMap);
		return weWordList;
	}
	
	
	// #y5. 호텔 위치한 지역 뽑아옴.
	@Override
	public List<HashMap<String, String>> getRegionList(HashMap<String, String> ajaxMap) {
		List<HashMap<String, String>> regionList = sqlsession.selectList("chy.getRegionList", ajaxMap);
		return regionList;
	}
	
	
	
}
