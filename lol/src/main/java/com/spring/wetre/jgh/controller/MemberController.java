package com.spring.wetre.jgh.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.SHA256;
import com.spring.wetre.jgh.service.InterMemberService;
import com.spring.wetre.model.CompanyVO;


/// #30. 컨트롤러 선언 ///
@Component
/* - XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   - 그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
   - 생략 가능한데, 써본거임.
*/


@Controller
public class MemberController {

	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private InterMemberService service;
	
	/// #36. 메인페이지 요청 ///
	@RequestMapping(value="/company.we", method= {RequestMethod.GET})
	public ModelAndView company(ModelAndView mv) {
		
		mv.setViewName("company/company.tiles1");
		return mv;
		// 위치는 여기: /FinalProjectC/src/main/webapp/WEB-INF/views/main/index.jsp
		// header랑 footer는 따로 있고, 이 index 파일은 content로 들어가는 것임.
	} // end of 메인페이지 요청 ------
	
	/// ID 중복체크
	@RequestMapping(value="/idCheck.we", method= {RequestMethod.GET})
	public ModelAndView idCheck(ModelAndView mv) {
	
		mv.setViewName("idcheck.notiles");
		return mv;
	}

	@RequestMapping(value="/idCheckB.we", method= {RequestMethod.POST})
	public ModelAndView idCheckB(HttpServletRequest request,  ModelAndView mv) {
		String cp_id = request.getParameter("cp_id");
		System.out.println(cp_id);
		int n = service.isUseUserid(cp_id);
	
		mv.addObject("cp_id", cp_id);
		
		mv.addObject("isUseUserid",n);
		mv.setViewName("idcheckB.notiles");
		return mv;
	}
	
	
	// 회원가입 성공/실패
	@RequestMapping(value="/joinInsert.we", method= {RequestMethod.POST})
	public ModelAndView joinInsert(HttpServletRequest request,  ModelAndView mv , CompanyVO cvo) {

		
		cvo.setCp_pwd(SHA256.encrypt(cvo.getCp_pwd()));
		
		int n = service.registerMember(cvo);
		String msg = "";
		String loc = "";
		if(n ==1) {
			msg = "회원가입에 성공했습니다.";
			loc = request.getContextPath()+"/0.we"; // 회원가입 성공여부를 보여준 후, 그 다음에 보여줄 페이지
		}
		else {
			msg = "회원가입 실패했습니다.";
			loc = "javascript:history.back()"; // 회원가입 실패했다면, 이전 페이지로 도로 보냄.
		}

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		
		
		
		mv.setViewName("msg");
		return mv;
	
		
		
	}

	
	// 회원가입 성공시 넘어갈 페이지
	@RequestMapping(value="/0.we", method= {RequestMethod.GET})
	public ModelAndView z(ModelAndView mv) {
		
		
		mv.setViewName("0.tiles1");
		
		return mv;
	}
	
	
	
	// 기업회원 정보 수정
	
	@RequestMapping(value="/companymp.we", method= {RequestMethod.GET})
	public ModelAndView companymp(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		
		HttpSession session = request.getSession();
		CompanyVO companyuser  = (CompanyVO) session.getAttribute("companyuser");
		
		String cp_id  = companyuser.getCp_id();
		
		CompanyVO selectUserInfo =  service.selectUserInfo(cp_id);
		
		mv.addObject("cvo",selectUserInfo);
		
		mv.setViewName("company/companymp.tiles1");
		
		return mv;		
	}
	
	
	
	// 기업회원정보 수정 성공/실패
		@RequestMapping(value="/mpjoinInsert.we", method= {RequestMethod.POST})
		public ModelAndView mpjoinInsert(HttpServletRequest request,  ModelAndView mv , CompanyVO cvo) {

			int n = service.updateMember(cvo);
			String msg = "";
			String loc = "";
			if(n ==1) {
				msg = "정보수정에 성공했습니다.";
				loc = request.getContextPath()+"/0.we"; // 회원가입 성공여부를 보여준 후, 그 다음에 보여줄 페이지
			}
			else {
				msg = "정보수정에 실패했습니다.";
				loc = "javascript:history.back()"; // 회원가입 실패했다면, 이전 페이지로 도로 보냄.
			}

			mv.addObject("msg",msg);
			mv.addObject("loc",loc);
			
			
			
			mv.setViewName("msg");
			return mv;
		
			
		}
	
	
	
}
