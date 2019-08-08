<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.spring.wetre.model.*" %>      
<% String ctxPath = request.getContextPath(); %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">




<link rel="stylesheet" href="<%= ctxPath%>/resources/css/style_companylogin.css" type="text/css" />

<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#btnCompanyLogin").click(function() {
			// alert("dtd");
	   		 func_Login();
	   	 }); // end of $("#btnLOGIN").click();-----------------------
	   	 
	   	 $("#password").keydown(function(event){
	 			
	 			if(event.keyCode == 13) { // 엔터를 했을 경우
	 				func_Login();
	 			}
	   	 }); // end of $("#pwd").keydown();-----------------------
		
	}); // end of $(document).ready(function() -----------------
	
	
	
	function func_Login() {
		 
		 var userid = $("#userid").val(); 
		 var pwd = $("#password").val();
		 		 
		 		 		
		 if(userid.trim() == "") {
		 	 alert("아이디를 입력해주십시오.");
			 $("#userid").val(""); 
			 $("#userid").focus();
			 return;
		 }
		
		 if(pwd.trim() == "") {
			 alert("암호를 입력해주십시오.");
			 $("#password").val(""); 
			 $("#password").focus();
			 return;
		 }

		 var frm = document.companyLoginFrm;
		 frm.action = "<%=ctxPath%>/companyLoginEnd.we";
		 frm.method = "POST";
		 frm.submit();
		 
		 
		 
   } // end of function func_Login(event)-----------------------------		
			
</script>

<%
    ///////////////////////////////  쿠키를 사용한  아이디 저장  //////////////////////////////////////////
	CompanyVO loginuser =  (CompanyVO) session.getAttribute("companyuser"); 
	
	if(loginuser == null) { // 세션에 저장된 사용자 정보가 없는 경우. 즉, 로그인 안한 경우
		
		/*
		  로그인 하려고 할때 WAS(톰캣서버)는 사용자 컴퓨터 웹브라우저로부터 전송받은
		  쿠키들을 검사해서 그 쿠키의 이름(키값)중 "saveid" 가 존재하는지 알아와서
		  존재한다라면 "saveid" 에 해당하는 값을 form 태그 내의 input 태그중  아이디에 넣어주고,
		  또한, 아이디저장이라는 체크박스도 체크를 해주도록 한다.
		*/
		String cookie_key = "";
		String cookie_value = "";
		boolean flag = false;
		
		Cookie[] cookieArr = request.getCookies(); // 쿠키를 받아온다.
		
		if(cookieArr != null) {
			// 사용자 클라이언트 컴퓨터에서 보내온 쿠키들의 정보가 있다라면
			
			for(Cookie ck : cookieArr) {
				cookie_key = ck.getName(); // 쿠키의 이름(키값)을 꺼내오는 메소드 (saveid)
				
				if("saveid".equals(cookie_key)) {
					cookie_value = ck.getValue();
					flag = true;
					break; // for 문 탈출
				}
							
				
			} // end of for()-------------------------------------
		} // end of if() --------------------------------------
	
%>

</head>
<body>
	<div class="body">
		<form name="companyLoginFrm">
		<div class="grad"></div>
		<div class="header">
			<div><span>기업회원<br/>로그인</span></div>
		</div>
		<br>
		<div class="login">
				<input type="text" placeholder="username" name="userid" id="userid" autocomplete="off"
				<% if (flag == true) { %>
		    			value="<%= cookie_value%>"
		    		<% }  %> /><br>
				<input type="password" placeholder="password" name="password" id="password"><br>
				<input type="button" value="Login" id="btnCompanyLogin"/>
				<input type="button" value="Register" id="btnCompanyRegister" /><br/><br/>
				<% 
						if(flag == true) { %> 
							<input type="checkbox" id="saveid" name="saveid" style="vertical-align: text-top;" checked /><label for="saveid" style="margin-right: 20px; vertical-align: middle; font-size: 11pt;">아이디저장</label>
				 <% }
					else { %> 
						 <input type="checkbox" id="saveid" name="saveid" style="vertical-align: text-top;"  /><label for="saveid" style="margin-right: 20px; vertical-align: middle; font-size: 11pt;">아이디저장</label> 
				 <%	 }  %>
		 <%	 }  %>
		 	  
		 <a data-toggle="modal" data-target="#idFind" data-dismiss="modal" >아이디찾기</a> /
		 <a data-toggle="modal" data-target="#pwdFind" data-dismiss="modal" >비밀번호찾기</a>
		 
		 
		</div>
		
		
		</form>
	</div>
	
	
		
</body>

</html>
  <div class="modal fade" id="idFind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">이메일로 인증하기</h4>
        </div>
        <div class="modal-body" style="height: 300px; width: 100%;">
          <div id="idFind">
          	<div align="left">
					<iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath()%>/idFind.we?type=2">
          			</iframe>
			</div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
  <div class="modal fade" id="pwdFind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">이메일로 인증하기</h4>
        </div>
        <div class="modal-body" style="height: 300px; width: 100%;">
          <div id="idFind">
          	<div align="left">
          			
					<iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath()%>/pwdFind.we?type=2">
          			</iframe>
          			<input type="text" value="2" />
			</div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>