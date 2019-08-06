package com.spring.wetre.lyg.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;

import javax.activation.CommandMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.common.AES256;
import com.spring.wetre.lyg.controller.CartVO;
import com.spring.wetre.lyg.controller.RoomVO;
import com.spring.wetre.lyg.model.InterContactDAO;
import com.spring.wetre.model.AccVO;


// === #31. Service 선언 ===
@Service
public class ContactService implements InterContactService {


	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private InterContactDAO dao;
	
	//===== #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 암호화/복호화 하기위한 클래스 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired
	private AES256 aes;

	@Override
	public int hoteltag(String acc_idx) {

		int n = dao.hoteltag(acc_idx);
		return n;
	}

	@Override
	public AccVO roomdetail(String acc_idx) {

		AccVO roList = dao.roomdetail(acc_idx);
		return roList;
	}

	@Override
	public boolean isUserExists(HashMap<String, String> paramap) {
		System.out.println("dao전");
		
		boolean isUserExists = dao.isUserExists(paramap);
		return isUserExists;
	}

	@Override
	public List<AccVO> getStoreMap() {
		List<AccVO> storemapList = dao.getStoreMap();
		return storemapList;
	}

	
	@Transactional
	@Override
	public int checkEmail(HashMap<String, String> paramap) {
	/*	try {
			 paramap.put("email", aes.encrypt(paramap.get("email")));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}*/
		return dao.checkEmail(paramap);
	}

	@Override
	public int telcheck(HashMap<String, String> paramap) {
		return dao.telcheck(paramap);
	}

	

	@Override
	public List<CartVO> selectCartList(String userid) {
		// TODO Auto-generated method stub
		return dao.selectCartList(userid);
	}

	@Override
	public CartVO selectCartOne(HashMap<String, String> para) {
		// TODO Auto-generated method stub
		return dao.selectCartOne(para);
	}

	
	
	
	
	
	
}
