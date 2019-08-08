package com.spring.wetre.lyg.model;

import java.util.HashMap;
import java.util.List;

import javax.activation.CommandMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.wetre.lyg.controller.CartVO;
import com.spring.wetre.lyg.controller.RoomVO;
import com.spring.wetre.model.AccVO;


// === #32. DAO 선언 ===
@Repository
public class contactDAO implements InterContactDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired 
	private SqlSessionTemplate sqlsession;

	@Override
	public int hoteltag(String acc_idx) {
		int n = sqlsession.insert("lyg.hoteltag", acc_idx);
		return n;
	}
	
	
	@Override
	public AccVO roomdetail(String acc_idx) {
		AccVO rmList = sqlsession.selectOne("lyg.roomdetail", acc_idx);
		return rmList;
	}

	@Override
	public boolean isUserExists(HashMap<String, String> paramap) {
		
		boolean isUserExists = false;
		
		int n = sqlsession.selectOne("lyg.isUserExists", paramap);
		System.out.println(n);
		if(n==1) {
			isUserExists = true;
			}
		else {
			isUserExists = false;
			}
		return isUserExists;
	}


	@Override
	public List<AccVO> getStoreMap() {
		List<AccVO> storemapList = sqlsession.selectList("lyg.getStoreMap");
		return storemapList;
	}




	@Override
	public int checkEmail(HashMap<String, String> paramap) {
		int n = 0;
		if("2".equals(paramap.get("type")))
			n =sqlsession.selectOne("lyg.checkEmailCom", paramap);
		else
			n =sqlsession.selectOne("lyg.checkEmailPer", paramap);			
		return n;
	}


	@Override
	public int telcheck(HashMap<String, String> paramap) {
		int telcheck = 0;
		
		if (paramap.get("userType").equals("personal_mbr")) {
			telcheck = (int) sqlsession.selectOne("lyg.perTelCheck", paramap);			
		}
		else if (paramap.get("userType").equals("company_mbr")) {
			telcheck = (int) sqlsession.selectOne("lyg.comTelCheck", paramap);						
		}
		
		return telcheck;
		
	}

	@Override
	public List<CartVO> selectCartList(String userid) {
		return sqlsession.selectList("lyg.selectCartList", userid);
	}


	@Override
	public CartVO selectCartOne(HashMap<String, String> para) {
		return sqlsession.selectOne("lyg.selectCartOne", para);
	}


	@Override
	public String idFind(HashMap<String, String> map) {
		String result = "";
		if("1".equals(map.get("type")))
			result = sqlsession.selectOne("lyg.idFindPer", map);
		else if("2".equals(map.get("type")))
			result = sqlsession.selectOne("lyg.idFindCom", map);
		return result;
	}


	@Override
	public int pwdChange(HashMap<String, String> map) {
		int n = 0;
		if("1".equals(map.get("type")))
			n = sqlsession.update("lyg.pwdChangePer", map);
		else if("2".equals(map.get("type")))
			n = sqlsession.update("lyg.pwdChangeCom", map);
		return n;
	}

	
	
}
