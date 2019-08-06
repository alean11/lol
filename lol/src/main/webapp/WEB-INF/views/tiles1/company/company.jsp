<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="css/bootstrap.css">

</head>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/SemiProjectC/js/jquery/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		var now = new Date(); 
		// 자바스크립트에서 현재날짜시각을 얻어온다.
		
		console.log(now.getFullYear());
		// 4자리 년도를 얻어 오는 것. getFullYear() 메소드로 그렇게 해줬음.

		$(".error_passwd").hide();
		$(".error_ph").hide();
		$(".error_post").hide();
		$(".error_addr").hide();
		$(".error").hide();
	
		$(".single-input").each(function(){
			$(this).blur(function(){
				var data = $(this).val().trim();
				if(data == "") {
					// 입력하지 않거나 공백만 입력했을 경우
					$(this).parent().find(".error").show();
					$(":input").attr("disabled",true); 
					$(this).attr("disabled",false);
					$(this).focus();
				}
				else {
					// 공백이 아닌 글자를 입력했을 경우
					$(this).parent().find(".error").hide();
					$(":input").attr("disabled",false); 
				}
			});
		}); // end of $(".requiredInfo").each()-------
	
		
		/// ID중복확인하기 위한 팝업창 띄우기 ///
		$("#cp_id").click(function() {
			
			// 팝업창 띄우기
			var url = "idCheck.we";
			window.open(url, "idcheck",
					    "left=500px, top=100px, width=300px, height=230px"); // method 조건 없으므로, get방식임.			
		});// end of $("#idcheck").click()------------
		
		
		$("#cp_pwd").blur(function(){
			var passwd = $(this).val();
			
		//	var regExp_PW = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			// 또는
			var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 객체 생성
			
			var bool = regExp_PW.test(passwd);
			
			if(!bool) {
				$(".error_passwd").show();
				$(":input").attr("disabled",true); 
				$(this).attr("disabled",false);
				$(this).focus();
			}
			else {
				$(".error_passwd").hide();
				$(":input").attr("disabled",false); 
				$("#pwdcheck").focus();
			} 
		}); // end of $("#pwd").blur()---------------
		
	
		$("#pwdcheck").blur(function(){
			var passwd = $("#cp_pwd").val();
			var passwdCheck = $(this).val();
			
			if(passwd != passwdCheck) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled",true);
				$(this).attr("disabled",false);
				$("#cp_pwd").attr("disabled",false);
				$("#cp_pwd").focus();
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled",false);
			}
			
		});// end of $("#pwdcheck").blur()--------------
		
		
		$("#cp_email").blur(function(){
			
			var email = $(this).val();
			
			var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
			
			var bool = regExp_EMAIL.test(email);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled",true);
				$(this).attr("disabled",false); 
				$(this).focus();
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled",false);
			}
			
		});// end of $("#email").blur()--------------
		
		
		$("#hp2").blur(function(){
			var hp2 = $(this).val();
			
			var bool1 = false;
			var regExp_HP2a = /^[1-9][0-9][0-9]$/g;
			// 3글자가 숫자이라면 들어오도록 검사해주는 정규표현식
			var bool1 = regExp_HP2a.test(hp2);
			
			var bool2 = false;
			var regExp_HP2b = /^[0-9][0-9][0-9][0-9]$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			var bool2 = regExp_HP2b.test(hp2);
			
			if( !(bool1 || bool2) ) {
				$(".error_ph").show();
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
			}
			else {
				$(".error_ph").hide();
				$(":input").attr("disabled", false);
			}
			
		});// end of $("#hp2").blur()-------------
		
		
		$("#hp3").blur(function(){
			var hp3 = $(this).val();
			
			var regExp_HP3 = /^\d{4}$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			
			var bool = regExp_HP3.test(hp3);
			
			if(!bool) {
				$(".error_ph").show();
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
			}
			else {
				$(".error_ph").hide();
				$(":input").attr("disabled", false);
			}			
		});// end of $("#hp3").blur()-------------
		
		
		$(".zipcodeSearch").click(function(){
			new daum.Postcode({
				oncomplete: function(data) {
				    $("#post1").val(data.postcode1);  // 우편번호의 첫번째 값     예> 151
				    $("#post2").val(data.postcode2);  // 우편번호의 두번째 값     예> 019
				    $("#addr1").val(data.address);    // 큰주소                        예> 서울특별시 종로구 인사로 17 
				    $("#addr2").focus();
				}
			}).open();
		});
		
		
		$(".address").blur(function(){
			var address = $(this).val().trim();
			if(address == "") {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
				$(this).focus();
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled", false);
			}
		});
		
	}); // end of $(document).ready()-------------------
	
	
	function goRegister(event) {

		/* if( !$("input:radio[name=gender]").is(":checked")) {
			  alert("성별을 선택하셔야 합니다.");
			  return;
		} */
		

		if( !$("input:checkbox[id=agree]").is(":checked") ) {
			alert("이용약관에 동의하셔야 합니다.");
			return;
		} 
   	 
		var frm = document.registerFrm;
		frm.method = "POST";
		frm.action = "joinInsert.we";
		frm.submit();
	} // end of function goRegister(event)----------
	
</script>


       <!-- ****** 회원가입 Area Start ****** -->
            <div class="container" id="regist_container">
                <div class="row">

                    <div class="col-12"> <%-- col-md-6 클래스 붙어 있었는데, 이거 때문에 폼 크기 고정 돼서 일단 빼봄. --%>
                        <div class="checkout_details_area mt-50 clearfix">

                            <div class="cart-page-heading" style= "margin-top: 5%;">
                                <h3>기업회원가입</h3>
                                <p>Company Registration</p>
                            </div>

                            <form name="registerFrm">
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label for="cp_id">기업회원 아이디 <span>*</span></label>
                                        <input type="text" class="single-input" id="cp_id" name="cp_id" style="width: 250px;" required />
                                        <span class="error">아이디는 필수입력 사항입니다.</span>
                                    </div>
                                    <div style="margin: 0 15px 15px 15px;">
                                        <label for="cp_pwd">비밀번호 <span>*</span></label>
                                        <input type="password" class="single-input" id="cp_pwd" name="cp_pwd" style="width: 250px;" required />
                                        <span class="error error_passwd" style="margin: 3px;">암호는 영문자, 숫자, 특수기호가 혼합된<br/>8~15 글자로만 입력가능합니다.</span>
                                    </div>
                                    <div style="margin: 0 15px 15px 15px;">
                                        <label for="last_name">비밀번호 확인 <span>*</span></label>
                                        <input type="password"  id="pwdcheck" style="width: 250px;" required class="single-input" />
                                    	<span class="error" style="margin: 3px;">암호가 일치하지 않습니다.</span>
                                    </div>
                                    
                                    <div class="col-md-12 mb-3" style="margin-bottom: 0 !important; ">
                                  		<label for="company_number">사업자 등록번호 <span>*</span></label>
                                    </div>
                                    <div style="margin: 0 10px 15px 10px;">
                                        <input type="text" class="single-input" name="cp_num1" id="cp_num1" name="cp_num1" maxlength="3" style="width: 75px" />
                                    </div>
                                    <span style="margin: 15px 3px;">-</span>
                                    <div style="margin: 0 10px 15px 10px;">
                                        <input type="text" class="single-input" name="cp_num2" id="cp_num2" name="cp_num2" maxlength="2" style="width: 75px" />
                                    </div>
                                    <span style="margin: 15px 3px;">-</span>
                                    <div  style="margin: 0 10px 15px 10px;">
                                        <input type="text" class="single-input" name="cp_num3" id="cp_num3" name="cp_num3" maxlength="5" style="width: 75px" />
                                    </div>
                                    <div class="col-12 mb-3">
                                    	<span class="error error_cn">올바른 사업자등록번호가 아닙니다.</span>
                                    </div>
                                    
                                                                        
                                    <div class="col-md-12 mb-3">
                                        <label for="cp_name">기업명 <span>*</span></label>
                                        <input type="text" class="single-input" id="cp_name" name="cp_name" style="width: 250px;" />
                                        <span class="error">기업명은 필수입력 사항입니다.</span>
                                    </div>
                                  
                                  	<div class="col-md-12 mb-3">
                                        <label for="ceoname">대표자 이름 <span>*</span></label>
                                        <input type="text" class="single-input" id="ceoname" name="ceoname" style="width: 250px;" />
                                        <span class="error">이름은 필수입력 사항입니다.</span>
                                    </div>
                                  
                                    <div class="col-12 mb-3">
                                        <label for="cp_email">회사 대표 메일 <span>*</span></label>
                                        <input type="email" class="single-input" id="cp_email" name="cp_email" placeholder="abcd@google.com" style="width: 344px" />
                                    	<span class="error">이메일 형식에 맞지 않습니다.</span>
                                    </div>
                                    <div class="col-md-12 mb-3" style="margin-bottom: 0 !important; ">
                                  		<label for="company_number">회사 전화번호 <span>*</span></label>
                                    </div>
                                    <div style="margin: 0 10px 15px 10px;">
                                        <input type="text" class="single-input" name="cp_tel1" id="cp_tel1" name="cp_tel1" maxlength="3" style="width: 75px" />
                                    </div>
                                    <span style="margin: 15px 3px;">-</span>
                                    <div style="margin: 0 10px 15px 10px;">
                                        <input type="text" class="single-input" name="cp_tel2" id="cp_tel2" name="cp_tel2" maxlength="4" style="width: 75px" />
                                    </div>
                                    <span style="margin: 15px 3px;">-</span>
                                    <div  style="margin: 0 10px 15px 10px;">
                                        <input type="text" class="single-input" name="cp_tel3" id="cp_tel3" name="cp_tel3" maxlength="4" style="width: 75px" />
                                    </div>
                                    <div class="col-12 mb-3">
                                    	<span class="error error_cp">올바른 연락처 형식이 아닙니다.</span>
                                    </div>
                                    
                                    <!-- <div class="col-md-12 mb-3" style="margin: 0 !important;">
                                  		<label for="gender">성별 <span>*</span></label>
                                    </div>                  
                                	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 30px 25px 15px !important;">
                                            <input type="radio" class="custom-control-input" id="male" name="gender" value="1">
                                            <label class="custom-control-label" for="male">남자</label>
                                    </div>
                                	<div class="custom-control custom-checkbox d-block mb-2"  style="margin: 0 30px 25px 15px !important;">
                                            <input type="radio" class="custom-control-input" id="female" name="gender" value="2">
                                            <label class="custom-control-label" for="female">여자</label>
                                    </div> -->
                                    
                                    
                                    <iframe src="<%= request.getContextPath()%>/resources/agree/agree.html" width="85%" height="150px" class="box" style="margin: 15px 0px 15px 15px;"></iframe>
                                                                       
                                    <div class="custom-control custom-checkbox d-block mb-2" style="margin: 0 10px 50px 15px !important;">
                                            <input type="checkbox" class="custom-control-input" id="agree">
                                            <label class="custom-control-label" for="agree">이용약관에 동의합니다.</label>
                                    </div>
                                </div>
                                    <button type="button" id="btnRegister" class="btn karl-checkout-btn" onClick="goRegister(event);">가입하기</button>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        <!-- ****** 회원가입 Area End ****** -->