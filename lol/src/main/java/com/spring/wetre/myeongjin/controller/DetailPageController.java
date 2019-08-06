package com.spring.wetre.myeongjin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.MyUtil;
import com.spring.common.SHA256;
import com.spring.wetre.model.AccVO;
import com.spring.wetre.model.CompanyVO;
import com.spring.wetre.model.PersonalVO;
import com.spring.wetre.myeongjin.service.InterDetailPageService;


// Controller 선언
@Component
@Controller
public class DetailPageController {
	
	// 의존객체 주입하기(DI)
	@Autowired 	// Type에 따라 알아서 bean을 주입해준다.
	private InterDetailPageService service;
	
	
    /////////////////////////////  상세페이지 시작   ///////////////////////////////////
	
	// 상세페이지 VIEW 단 처리하기
	@RequestMapping(value="/accommodation/accView.we", method= {RequestMethod.GET})
	public ModelAndView accView(HttpServletRequest request, ModelAndView mv, HttpServletResponse response) {
		
		String str_acc_idx = request.getParameter("acc_idx");
		int acc_idx = 6;
				
		try {
			
			// 고유번호를 가지고 해당 숙박시설의 정보를 조회해오기
			AccVO avo = service.getOneAccInfomation(acc_idx);
			
			// 고유번호를 가지고서 해당 숙박시설의 추가 이미지 정보를 조회해오기
			// List<HashMap<String, String>> imgList = service.getImagesByPnum(acc_idx);
			
			if(avo == null) {
		 		// GET방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 고유번호를 입력한 경우  
		 		mv.addObject("errorAcc", "검색하신 "+acc_idx+"제품은 존재하지 않습니다.");
		 		mv.setViewName("accommodation/acc_errorpage.tiles1");
		 				 		
		 	}
		 	else {
		 		// 제품이 존재하는 경우
		 		mv.addObject("avo", avo);
		 	 // mv.addObject("imgList", imgList);
		 		request.setAttribute("goBackURL", MyUtil.getCurrentURL(request)); // goBackURL은 로그인 했을때 돌아갈 페이지의 키값을 뜻한다.
		 		
		 		// System.out.println("goBackURL : " + MyUtil.getCurrentURL(request));
		 		// goBackURL : shop/prodView.kh?pnum=2
		 		
		 		mv.setViewName("accommodation/acc_view.tiles1");
		 	}
				
		} catch (NumberFormatException e) {
			// GET방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 제품번호를 입력한 경우
			
			mv.addObject("errorAcc", "검색하신 "+acc_idx+"제품은 존재하지 않습니다.");
	 		mv.setViewName("accommodation/acc_errorpage.tiles1");
		}
		
		return mv;
	}
	
	
	@RequestMapping(value="/addMap.action", method= {RequestMethod.GET})
	@ResponseBody
	public ModelAndView addmap(AccVO accvo, ModelAndView mv) {
		
		String jsonStr = "";
		
		List<AccVO> accList = service.getaccList(accvo.getAcc_idx());
		
		JSONArray jsonArr= new JSONArray();
		
		for(AccVO avo : accList) {
			JSONObject jobt = new JSONObject();
			jobt.put("name", avo.getAcc_name());
			jobt.put("region_name", avo.getRegion_name());
			jobt.put("addr", avo.getAcc_addr1());
			
			jsonArr.put(jobt);
		}
		
		jsonStr = jsonArr.toString();
		
		mv.addObject("accList", accList);
		mv.addObject("jsonStr", jsonStr);
		mv.setViewName("map/googlemap.tiles1");
		
		return mv;
	}
	
	
	
}
