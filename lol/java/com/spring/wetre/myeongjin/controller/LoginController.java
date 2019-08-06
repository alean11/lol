package com.spring.wetre.myeongjin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.MyUtil;
import com.spring.common.SHA256;
import com.spring.wetre.model.AccVO;
import com.spring.wetre.model.CompanyVO;
import com.spring.wetre.model.PersonalVO;
import com.spring.wetre.myeongjin.service.InterLoginService;

// Controller 선언
@Component
@Controller
public class LoginController {
	
	// 의존객체 주입하기(DI)
	@Autowired 	// Type에 따라 알아서 bean을 주입해준다.
	private InterLoginService service;
		
    /////////////////////////////  개인회원 로그인 처리 시작   ///////////////////////////////////
	// 개인회원 로그인 폼 페이지 요청
	@RequestMapping(value="/privateLogin.we", method= {RequestMethod.GET})
	public ModelAndView privateLogin(ModelAndView mv) {
				
		mv.setViewName("login/privateloginform");
		return mv;
	}
	
	// 개인회원 로그인 처리 하기
	@RequestMapping(value="/privateLoginEnd.we", method= {RequestMethod.POST})
	public ModelAndView privateLoginEnd(HttpServletRequest request, ModelAndView mv, HttpServletResponse response) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("password");
		String saveid = request.getParameter("saveid");
				
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pwd", SHA256.encrypt(pwd)); // pwd를 암호화시켜야 한다.
		
		PersonalVO loginuser = service.getLoginPrivateMember(map);
		/////////////////////////////////////////////////////////////
				
		HttpSession session = request.getSession();
		
		if(loginuser == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mv.addObject("msg", msg);
			mv.addObject("loc", loc);
			
			mv.setViewName("msg");
			// /FinalProjectC/src/main/webapp/WEB-INF/views/msg.jsp
		}
		else {
			
			if(loginuser.isIdleStatus() == true) { // 리턴 타입이 boolean 이면 VO 가면 이름이 is~ 라고 나온다.
				// 로그인 한지 1년이 지나서 휴면상태로 빠진 경우
				String msg = "로그인 한지 1년이 지나서 휴면처리 되었습니다. 관리자에게 문의 바랍니다.";
				
			    /// 로그인을 한지 1년이 지났으면 로그인을 하지 못하도록 막아버리는 것 ///	
			    // String loc = "javascript:history.back()";
				
				/// 로그인을 한지 1년이 지났지만 정상적으로 로그인 처리를 해주는 것 //
				/*
				String loc = "/accommodation/accList.we";
				session.setAttribute("loginuser", loginuser);
				
				mv.addObject("msg", msg);
				mv.addObject("loc", loc);
				
				mv.setViewName("msg");
				*/
			}
			else {
				if(loginuser.isRequirePwdChange() == true) {
					// 암호를 최근 3개월 동안 변경하지 않은 경우
					String msg = "암호를 최근 3개월 동안 변경하지 않으셨습니다. 암호를 변경해주세요.";
					// String loc = "board/login/myinfo";
					String loc = request.getContextPath()+"/privateLogin.we";
					
					mv.addObject("msg", msg);
					mv.addObject("loc", loc);
					
					mv.setViewName("msg");
					
					session.setAttribute("loginuser", loginuser); // 위에 하든 아래에 하든 상관없다.
				}
				else {
					// 아무런 이상없이 로그인 하는 경우
					session.setAttribute("loginuser", loginuser);
					
					/*
					  사용자가 로그인시 아이디저장 체크박스에 체크를 했을 경우와 체크를 해제 했을 경우
					  - 체크박스에 체크를 했을 경우       ==> 쿠키저장
					  - 체크박스에 체크를 해제했을 경우 ==> 저장된 쿠키가 있으면 쿠키를 삭제한다.
					*/
					
					Cookie cookie = new Cookie("saveid", loginuser.getP_userid());
					
					if("on".equals(saveid)) {
						// 체크박스에 체크를 했을 경우
						cookie.setMaxAge(7*24*60*60);
					}
					else {
						// 체크박스에 체크를 해제했을 경우
						cookie.setMaxAge(0);
						// 쿠키의 생존기간을 0초로 설정한다. 즉, 이것이 쿠키삭제이다.
					}
					
					cookie.setPath("/");
					/*
					  쿠키가 사용되어지는 디렉토리 정보 설정.
					  cookie.setPath("쿠키가 사용되어질 경로");
					  만일  "쿠키가 사용되어질 경로" 를 "/" 로 하면
					  해당 도메인(예: mjintech.co.kr)의 모든 웹페이지 내에서 사용이 가능하다.
					*/
					
					response.addCookie(cookie);
					/*
					  사용자 컴퓨터의 웹브라우저로 쿠키를 전송시킨다. 
					*/
					
					if(session.getAttribute("gobackURL") != null) {
						// 세션에 저장된 돌아갈 페이지의 주소 (gobackURL)이 있다라면 
						
						String gobackURL = (String) session.getAttribute("gobackURL");
						mv.addObject("gobackURL", gobackURL); // request 영역에 저장시키는 것이다.
						
						session.removeAttribute("gobackURL"); // 세션에서 gobackURL을 삭제한다.						
					}
				
					
					mv.setViewName("login/privateloginEnd.tiles1");
					// /FinalProjectC/src/main/webapp/WEB-INF/views/tiles1/login/privateloginEnd.jsp
				}
			}
			
		}
		
		return mv;
	}
	
	// 개인회원 로그아웃 처리하기
	@RequestMapping(value="/privateLogout.we", method= {RequestMethod.GET})
	public ModelAndView privateLogout(HttpServletRequest request, ModelAndView mv) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		String msg = "로그아웃 하였습니다.";
		String loc = request.getContextPath()+"/accommodation/accList.we";
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		
		mv.setViewName("msg"); 
		
		return mv;
	}
	
	/////////////////////////////  개인회원 로그인 처리 끝   ///////////////////////////////////
	
	
    /////////////////////////////  기업회원 로그인 처리 시작   ///////////////////////////////////
	// 기업회원 로그인 폼 페이지 요청
	@RequestMapping(value="/companyLogin.we", method= {RequestMethod.GET})
	public ModelAndView companyLogin(ModelAndView mv) {
				
		mv.setViewName("login/companyloginform");
		return mv;
	} 
	
	// 기업회원 로그인 처리 하기
	@RequestMapping(value="/companyLoginEnd.we", method= {RequestMethod.POST})
	public ModelAndView companyLoginEnd(HttpServletRequest request, ModelAndView mv, HttpServletResponse response) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("password");
		String saveid = request.getParameter("saveid");
				
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pwd", SHA256.encrypt(pwd)); // pwd를 암호화시켜야 한다.
		
		CompanyVO companyuser = service.getLoginCompanyMember(map);
		/////////////////////////////////////////////////////////////
				
		HttpSession session = request.getSession();
		
		if(companyuser == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mv.addObject("msg", msg);
			mv.addObject("loc", loc);
			
			mv.setViewName("msg");
			// /FinalProjectC/src/main/webapp/WEB-INF/views/msg.jsp
		}
				
		else {
			
			// 아무런 이상없이 로그인 하는 경우
			session.setAttribute("companyuser", companyuser);
			
			/*
			  사용자가 로그인시 아이디저장 체크박스에 체크를 했을 경우와 체크를 해제 했을 경우
			  - 체크박스에 체크를 했을 경우       ==> 쿠키저장
			  - 체크박스에 체크를 해제했을 경우 ==> 저장된 쿠키가 있으면 쿠키를 삭제한다.
			*/
			
			Cookie cookie = new Cookie("saveid", companyuser.getCp_id());
			
			if("on".equals(saveid)) {
				// 체크박스에 체크를 했을 경우
				cookie.setMaxAge(7*24*60*60);
			}
			else {
				// 체크박스에 체크를 해제했을 경우
				cookie.setMaxAge(0);
				// 쿠키의 생존기간을 0초로 설정한다. 즉, 이것이 쿠키삭제이다.
			}
			
			cookie.setPath("/");
			/*
			  쿠키가 사용되어지는 디렉토리 정보 설정.
			  cookie.setPath("쿠키가 사용되어질 경로");
			  만일  "쿠키가 사용되어질 경로" 를 "/" 로 하면
			  해당 도메인(예: mjintech.co.kr)의 모든 웹페이지 내에서 사용이 가능하다.
			*/
			
			response.addCookie(cookie);
			/*
			  사용자 컴퓨터의 웹브라우저로 쿠키를 전송시킨다. 
			*/
						
			if(session.getAttribute("gobackURL") != null) {
				// 세션에 저장된 돌아갈 페이지의 주소 (gobackURL)이 있다라면 
				
				String gobackURL = (String) session.getAttribute("gobackURL");
				mv.addObject("gobackURL", gobackURL); // request 영역에 저장시키는 것이다.
				
				session.removeAttribute("gobackURL"); // 세션에서 gobackURL을 삭제한다.						
			}
				
					
			mv.setViewName("login/companyloginEnd.tiles1");
			// /FinalProjectC/src/main/webapp/WEB-INF/views/tiles1/login/companyloginEnd.jsp
								
		}
		
		return mv;
	}
	
	// 기업회원 로그아웃 처리하기
	@RequestMapping(value="/companyLogout.we", method= {RequestMethod.GET})
	public ModelAndView companyLogout(HttpServletRequest request, ModelAndView mv) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		String msg = "로그아웃 하였습니다.";
		String loc = request.getContextPath()+"/accommodation/accList.we";
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		
		mv.setViewName("msg"); 
		
		return mv;
	}
	
	/////////////////////////////  기업회원 로그인 처리 끝   ///////////////////////////////////
		
	
	
}
