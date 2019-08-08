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

import com.spring.common.SHA256;
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
public class certificationController {
	@Autowired
	private InterContactService service;

	@RequestMapping(value = "/emailPage.we", method = { RequestMethod.GET })
	public String emailPage(HttpServletRequest request) throws Exception {
		
		
		return "emailPage.notiles";
	}
	@RequestMapping(value = "/phonePage.we", method = { RequestMethod.GET })
	public String phonePage(HttpServletRequest request) throws Exception {
		
		
		return "phonePage.notiles";
	}

	@RequestMapping(value = "/checkEmail.we", method = { RequestMethod.POST })
	@ResponseBody
	public int checkEmail(HttpServletRequest request) throws Exception {
		String type = request.getParameter("type");
		String p_userid = "";
		HttpSession session = request.getSession();
		PersonalVO loginuser = (PersonalVO) session.getAttribute("loginuser");
		if(loginuser!=null) {
			p_userid = loginuser.getP_userid();
		}
		else
			p_userid = request.getParameter("userid");
		String email = request.getParameter("email");
		HashMap<String, String> paramap = new HashMap<String, String>();
		paramap.put("email", email);
		paramap.put("type", type);
		paramap.put("p_userid", p_userid);
		int n = 0;
		n = service.checkEmail(paramap);
		System.out.println("n" + n);
		if(n == 1) {
		
		GoogleMail mail = new GoogleMail();

		// 인증키를 랜덤하게 생성하도록 한다.
		Random rnd = new Random();
		
		String certificationCode = "";
		// certificationCode ==> "sfwte0983154"

		char randchar = ' ';
		for (int i = 0; i < 5; i++) {
			
			 
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			certificationCode += randchar;
		}

		int randnum = 0;
		for (int i = 0; i < 7; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			certificationCode += randnum;
		}

		// 랜덤하게 생성한 인증코드를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
		try {
			mail.sendmail(email, certificationCode);

			session.setAttribute("certificationCode", certificationCode);
			// 자바에서 발급한 인증코드를 세션에 저장

			request.setAttribute("email", email);
		} catch (Exception e) {
			e.printStackTrace();

			n = -1;
		}
			
		}
		return n;
	}

	@RequestMapping(value = "/emailVerifyCertification.we", method = { RequestMethod.POST })
	@ResponseBody
	public boolean EmailverifyCertification(HttpServletRequest request) throws Exception {
		String emailConfirm = request.getParameter("emailConfirm");

		HttpSession session = request.getSession();
		String certificationCode = (String) session.getAttribute("certificationCode");

		boolean bool = certificationCode.equals(emailConfirm);
			session.setAttribute("okok", bool);
		
		// !!! 중요 !!! //
		// 세션에 저장된 인증코드 삭제하기!!!!
		session.removeAttribute("certificationCode");

		return bool;
	}
	
	@RequestMapping(value = "/checkPhone.we", method = RequestMethod.POST)
	public int checkPhone(HttpServletRequest request) throws Exception {
		int n = 0;
		String userType = "";
		String idx = "";
		HttpSession session = request.getSession();
		if(session.getAttribute("loginuser")!=null) {
			userType = "personal_mbr";
			PersonalVO pervo = (PersonalVO) session.getAttribute("loginuser");
			idx = Integer.toString(pervo.getIdx());
		}
		else if(session.getAttribute("companyuser")!=null) {
			userType = "company_mbr";
			CompanyVO comvo = (CompanyVO) session.getAttribute("companyuser");
			idx = Integer.toString(comvo.getIdx());
		}
		String tel = request.getParameter("phone");
		HashMap<String, String> paramap = new HashMap<String, String>();
		paramap.put("userType", userType);
		paramap.put("idx", idx);
		paramap.put("tel", tel);
		
		n = service.telcheck(paramap);
		if(n==1) {
			System.out.println("확인하자");
			String api_key = "NCS8LAOMSUNBE4L2";
		    String api_secret = "DHYVGBJ14OQK9CGPKJBGOU6CKCKAYDCM";
		    Message coolsms = new Message(api_key, api_secret);
		    Random rnd = new Random();
			
			String certificationCode = "";
			// certificationCode ==> "sfwte0983154"
			
			char randchar = ' ';
			for(int i=0; i<5; i++) {
			/*
			   min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면
			   int rndnum = rnd.nextInt(max - min + 1) + min;
			      영문 소문자 'a' 부터 'z' 까지 중 랜덤하게 1개를 만든다.	  
			*/
				randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
				certificationCode += randchar;
			}
			
			int randnum = 0;
			for(int i=0; i<7; i++) {
				randnum = rnd.nextInt(9-0+1)+0;
				certificationCode += randnum;
			}
		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", tel); // 수신번호
		    params.put("from", "01046657830"); // 발신번호
		    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
		    params.put("text", "OO을 위한 인증코드입니다. 인증코드란에 아래의 인증코드를 입력해주세요. 인증코드는 ["+certificationCode+"] 입니다."); // 문자내용    
		    params.put("app_version", "JAVA SDK v2.2"); // application name and version
		    params.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.
	/*
		     Optional parameters for your own needs
		     params.put("image", "desert.jpg"); // image for MMS. type must be set as "MMS"
		     params.put("image_encoding", "binary"); // image encoding binary(default), base64 
		     params.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.
		     params.put("delay", "10"); // 0~20사이의 값으로 전송지연 시간을 줄 수 있습니다.
		     params.put("force_sms", "true"); // 푸시 및 알림톡 이용시에도 강제로 SMS로 발송되도록 할 수 있습니다.
		     params.put("refname", ""); // Reference name
		     params.put("country", "KR"); // Korea(KR) Japan(JP) America(USA) China(CN) Default is Korea
		     params.put("sender_key", "5554025sa8e61072frrrd5d4cc2rrrr65e15bb64"); // 알림톡 사용을 위해 필요합니다. 신청방법 : http://www.coolsms.co.kr/AboutAlimTalk
		     params.put("template_code", "C004"); // 알림톡 template code 입니다. 자세한 설명은 http://www.coolsms.co.kr/AboutAlimTalk을 참조해주세요. 
		     params.put("datetime", "20140106153000"); // Format must be(YYYYMMDDHHMISS) 2014 01 06 15 30 00 (2014 Jan 06th 3pm 30 00)
		     params.put("mid", "mymsgid01"); // set message id. Server creates automatically if empty
		     params.put("gid", "mymsg_group_id01"); // set group id. Server creates automatically if empty
		     params.put("subject", "Message Title"); // set msg title for LMS and MMS
		     params.put("charset", "euckr"); // For Korean language, set euckr or utf-8
		     params.put("app_version", "Purplebook 4.1") // 어플리케이션 버전
	*/
		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      session.setAttribute("certificationCode", certificationCode);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		    	n = -1;
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
		}
		return n;
	}
	// 인증결과
	@RequestMapping(value = "/phoneVerifyCertification.we", method = RequestMethod.POST)
	public boolean phoneVerifyCertification(HttpServletRequest request) throws Exception {
		
		String emailConfirm = request.getParameter("emailConfirm");

		HttpSession session = request.getSession();
		String certificationCode = (String) session.getAttribute("certificationCode");
		boolean bool = certificationCode.equals(emailConfirm);
		session.setAttribute("okok", bool);

		// !!! 중요 !!! //
		// 세션에 저장된 인증코드 삭제하기!!!!
		session.removeAttribute("certificationCode");

		return bool;
		
	}
	
	
	@RequestMapping(value = "/ok.we", method = RequestMethod.GET)
	@ResponseBody
	public boolean ok(HttpServletRequest request) throws Exception {
		boolean result = false;
		HttpSession session = request.getSession();
		result = (boolean) session.getAttribute("okok");
		System.out.println(result);
		return result;
		
	}
	/*@RequestMapping(value = "/phoneGo.we", method = RequestMethod.GET)
	public void phoneGo(HttpServletRequest request) throws Exception {
		String api_key = "NCS8LAOMSUNBE4L2";
	    String api_secret = "DHYVGBJ14OQK9CGPKJBGOU6CKCKAYDCM";
		    Message coolsms = new Message(api_key, api_secret);

		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", "01046657830"); // 수신번호
		    params.put("from", "01046657830"); // 발신번호
		    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
		    params.put("text", "Test Message"); // 문자내용    
		    params.put("app_version", "JAVA SDK v1.2"); // application name and version
		    params.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.

		    // Optional parameters for your own needs
		    // params.put("image", "desert.jpg"); // image for MMS. type must be set as "MMS"
		    // params.put("image_encoding", "binary"); // image encoding binary(default), base64 
		    // params.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.
		    // params.put("delay", "10"); // 0~20사이의 값으로 전송지연 시간을 줄 수 있습니다.
		    // params.put("force_sms", "true"); // 푸시 및 알림톡 이용시에도 강제로 SMS로 발송되도록 할 수 있습니다.
		    // params.put("refname", ""); // Reference name
		    // params.put("country", "KR"); // Korea(KR) Japan(JP) America(USA) China(CN) Default is Korea
		    // params.put("sender_key", "5554025sa8e61072frrrd5d4cc2rrrr65e15bb64"); // 알림톡 사용을 위해 필요합니다. 신청방법 : http://www.coolsms.co.kr/AboutAlimTalk
		    // params.put("template_code", "C004"); // 알림톡 template code 입니다. 자세한 설명은 http://www.coolsms.co.kr/AboutAlimTalk을 참조해주세요. 
		    // params.put("datetime", "20140106153000"); // Format must be(YYYYMMDDHHMISS) 2014 01 06 15 30 00 (2014 Jan 06th 3pm 30 00)
		    // params.put("mid", "mymsgid01"); // set message id. Server creates automatically if empty
		    // params.put("gid", "mymsg_group_id01"); // set group id. Server creates automatically if empty
		    // params.put("subject", "Message Title"); // set msg title for LMS and MMS
		    // params.put("charset", "euckr"); // For Korean language, set euckr or utf-8
		    // params.put("app_version", "Purplebook 4.1") // 어플리케이션 버전

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
	}*/
	@RequestMapping(value = "/idFind.we", method = { RequestMethod.GET })
	public ModelAndView idFind(ModelAndView mv, HttpServletRequest request) {
		String type = request.getParameter("type");
		System.out.println("type" + type);
	
		mv.setViewName("idFind.notiles");
		return mv;
		
	}
	@RequestMapping(value = "/pwdFind.we", method = { RequestMethod.GET })
	public ModelAndView pwdFind(ModelAndView mv, HttpServletRequest request) {
		String type = request.getParameter("type");
		System.out.println("type" + type);
		
		mv.setViewName("pwdFind.notiles");
		return mv;
		
	}
	@RequestMapping(value = "/idFindEnd.we", method = { RequestMethod.POST})
	@ResponseBody
	public String idFindEnd(ModelAndView mv, HttpServletRequest request) {
		String type = request.getParameter("type");
		System.out.println("type2" + type);
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		System.out.println(name);
		System.out.println(mobile);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("mobile", mobile);
		map.put("type", type);
		String userid = service.idFind(map);
		System.out.println(userid);
		if(userid==null)
			userid = "null";
		System.out.println(userid);
		return userid;
	}
	@RequestMapping(value = "/pwdChange.we", method = { RequestMethod.POST})
	@ResponseBody
	public int pwdChange(ModelAndView mv, HttpServletRequest request) {
		String type = request.getParameter("type");
		int n = 0;
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		pwd = SHA256.encrypt(pwd);
		System.out.println(userid);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pwd", pwd);
		map.put("type", type);
		n = service.pwdChange(map);
		
		return n;
	}
}
