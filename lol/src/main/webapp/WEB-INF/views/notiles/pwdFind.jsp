<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<meta charset="utf-8">
<script src="<%=ctxPath%>/resources/js/jquery-3.2.1.min.js"></script>

<style>
#div_userid {
	width: 70%;
	height: 15%;
	margin-bottom: 5%;
	margin-left: 10%;
	position: relative;
}

#div_email {
	width: 70%;
	height: 15%;
	margin-bottom: 5%;
	margin-left: 10%;
	position: relative;
}

#div_findResult {
	width: 70%;
	height: 15%;
	margin-bottom: 5%;
	margin-left: 10%;
	position: relative;
}

#div_btnFind {
	width: 70%;
	height: 15%;
	margin-bottom: 5%;
	margin-left: 10%;
	position: relative;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$("#div_findResult").hide();
		$("#not").hide();
		$("#pwdchange").hide();
		$("#div_confirmResult").hide();

	});
	function fn_emailCheck() {
		var userid = $("#userid").val();
		var email = $("#email").val();
		var type = $("#type").val();
		var userData = {
			"userid" : userid,
			"type" : type,
			"email" : email
		}

		if (userid.length < 1) {
			alert("아이디를 입력해주시기 바랍니다.");
		} else if (email.length < 1) {
			alert("이메일을 입력해주시기 바랍니다.");
		} else {
			$.ajax({
				type : "POST",
				url : "checkEmail.we",
				data : userData,

				success : function(result) {
					if (result == 0) {
						alert("아이디와 이메일이 일치하지 않습니다.");
					} else {
						$("#div_findResult").show();
						$("#div_btnFind").hide();
						$("#div_userid").hide();
						$("#div_email").hide();
					}

				},
				error : function(error) {
					alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
				}
			});
		}
	};

	function fn_Confirm() {
		var input_confirmCode = $("#input_confirmCode").val();
		var userData = {
			"emailConfirm" : input_confirmCode
		}

		if (input_confirmCode.length < 1) {
			alert("인증코드를 입력해주시기 바랍니다.");
		} else {
			$.ajax({
				type : "POST",
				url : "emailVerifyCertification.we",
				data : userData,

				success : function(result) {
					if (!result) {
						alert("인증코드가 일치하지 않습니다.");
					} else {
						$("#div_findResult").hide();
						$("#pwdchange").show();
					}

				},
				error : function(error) {
					alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
				}
			});
		}
	}
	function fn_changePwd() {
		var pwd = $("#pwd").val();
		var userid = $("#userid").val();
		var type = $("#type").val();
		var userData = {
			"pwd" : pwd,
			"type" : type,
			"userid" : userid
		}

		if (pwd.length < 1) {
			alert("비밀번호를 입력해주시기 바랍니다.");
		} else {
			$.ajax({
				type : "POST",
				url : "pwdChange.we",
				data : userData,

				success : function(result) {
					if (result=0) {
						alert("암호변경에 실패하였습니다.");
					} else {
						alert("암호가 새로이 변경되었습니다.\n 창을 닫고 로그인해주세요.");
						$("#div_findResult").hide();
						$("#pwdchange").show();
					}

				},
				error : function(error) {
					alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
				}
			});
		}
	}
</script>
<% String type =  request.getParameter("type");%>
	<input type="text" name="type" id="type" value="<%=type%>"/>

	<div id="div_userid" align="center">
		<span style="color: blue; font-size: 12pt;">아이디</span><br /> <input
			type="text" name="userid" id="userid" size="15" placeholder="ID"
			required />
	</div>

	<div id="div_email" align="center">
		<span style="color: blue; font-size: 12pt;">이메일</span><br /> <input
			type="text" name="email" id="email" size="15"
			placeholder="abc@def.com" required />
	</div>

	<div id="div_findResult" align="center">
		<div id="pwdConfirmCodeDiv">
			<span style="font-size: 10pt;">인증코드가 ${email}로 발송되었습니다.</span><br />
			<span style="font-size: 10pt;">인증코드를 입력해주세요</span><br /> <input
				type="text" name="input_confirmCode" id="input_confirmCode" required />
			<br /> <br />
			<button type="button" class="btn btn-info" id="btnConfirmCode"
				onclick="fn_Confirm();">인증하기</button>
		</div>
	</div>


	<div id="div_btnFind" align="center">
		<button type="button" class="btn btn-success" id="btnFind" onclick="fn_emailCheck();">찾기</button>
	</div>


<div id="pwdchange">
	<div id="div_pwd" align="center">
		<span style="color: blue; font-size: 12pt;">새암호</span><br /> <input
			type="password" name="pwd" id="pwd" size="15" placeholder="PASSWORD"
			required />
	</div>

	<div id="div_pwd2" align="center">
		<span style="color: blue; font-size: 12pt;">새암호확인</span><br /> <input
			type="password" name="pwd2" id="pwd2" size="15"
			placeholder="PASSWORD" required />
	</div>


		<div id="div_confirmResult" align="center">
			암호가 새로이 변경되었습니다.<br />
		</div>

		<div id="div_btnUpdate" align="center">
			<button type="button" class="btn btn-success" id="btnUpdate" onclick="fn_changePwd();">암호변경하기</button>
		</div>
</div>









