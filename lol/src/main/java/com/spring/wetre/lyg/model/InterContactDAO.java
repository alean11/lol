package com.spring.wetre.lyg.model;

import java.util.HashMap;
import java.util.List;

import javax.activation.CommandMap;

import com.spring.wetre.lyg.controller.CartVO;
import com.spring.wetre.lyg.controller.RoomVO;
import com.spring.wetre.model.AccVO;

public interface InterContactDAO {

	int hoteltag(String acc_idx);

	AccVO roomdetail(String acc_idx);

	boolean isUserExists(HashMap<String, String> paramap);

	List<AccVO> getStoreMap();

	int checkEmail(HashMap<String, String> paramap);

	int telcheck(HashMap<String, String> paramap);

	List<CartVO> selectCartList(String userid);

	CartVO selectCartOne(HashMap<String, String> para);

	
	
	
	
	
	
	
	
	
	

}
