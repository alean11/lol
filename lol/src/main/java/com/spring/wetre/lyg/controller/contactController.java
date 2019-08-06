package com.spring.wetre.lyg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.activation.CommandMap;
import javax.servlet.http.*;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
/*
import com.google.code.geocoder.*;
import com.google.code.geocoder.model.*;*/
import com.spring.wetre.lyg.service.InterContactService;
import com.spring.wetre.model.*;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

/// #30. 컨트롤러 선언 ///
@Component
/*
 * - XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. -
 * 그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
 */
@Controller
public class contactController {
	@Autowired
	private InterContactService service;

	// 지도페이지
	@RequestMapping(value = "/contact.we", method = { RequestMethod.GET })
	public ModelAndView contact(ModelAndView mv) {
		/*
		 * List<AccVO> storemapList = service.getStoreMap();
		 * mv.addObject("storemapList", storemapList);
		 */
		/*
		 * String address = "서울"; geoCodeController geo = new geoCodeController();
		 * float[] geoArr = geo.getAddress(address);
		 * 
		 * System.out.println("geo1 : " + geoArr[0]); System.out.println("geo2 : " +
		 * geoArr[1]);
		 */
		mv.setViewName("wetre/contact.tiles1");

		return mv;
	}

	// 예약페이지
	@RequestMapping(value = "/map.we", method = { RequestMethod.GET })
	public ModelAndView map(HttpServletRequest request, ModelAndView mv) {
		List<AccVO> storemapList = service.getStoreMap();
		for (AccVO accVO : storemapList) {
			System.out.println(accVO.getAcc_addr1());
		}
		System.out.println(storemapList.size());
		mv.addObject("storemapList", storemapList);
		mv.setViewName("map2");

		return mv;

	}
	@RequestMapping(value = "/map3.we", method = { RequestMethod.GET })
	public ModelAndView map3(HttpServletRequest request, ModelAndView mv) {
		List<AccVO> storemapList = service.getStoreMap();
		for (AccVO accVO : storemapList) {
			System.out.println(accVO.getAcc_addr1());
		}
		System.out.println(storemapList.size());
		mv.addObject("storemapList", storemapList);
		mv.setViewName("map3");
		
		return mv;
		
	}

	@RequestMapping(value = "/reserve.we", method = { RequestMethod.GET })
	public ModelAndView reserve(HttpServletRequest request, ModelAndView mv) {
		String acc_idx = request.getParameter("acc_idx");
		
		AccVO accvo = service.roomdetail(acc_idx);
		mv.addObject("accvo", accvo);
		System.out.println(accvo.getRoom().getR_text());
		HttpSession session = request.getSession();
		session.setAttribute("okok", false);
		System.out.println(session.getAttribute("okok"));
		mv.setViewName("wetre/reserve.tiles1");

		return mv;
	}




	@RequestMapping(value = "/myPage.we", method = RequestMethod.GET)
	public ModelAndView myPage(ModelAndView mv) throws Exception {
		String userid = "admin";
		
		CartVO cvo = service.selectCart(userid);
		mv.addObject("cvo", cvo);
		mv.setViewName("wetre/myPage.tiles1");
		return mv;
	}
		
}
