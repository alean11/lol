<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="<%= ctxPath%>/resources/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	$(".msg").hide();
	$(".comp").hide();

		
	$("#email_checkBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_EmailCheck();
	});
	$("#emailConfirm_checkBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_EmailConfirmCheck();
	});

});

function fn_EmailCheck() {
	var email = $("#email").val();
	var userData = {
		"email" : email
	}

	if (email.length < 1) {
		alert("이메일을 입력해주시기 바랍니다.");
	} else {
		$.ajax({
			type : "POST",
			url : "checkEmail.we",

			data : userData,
			dataType : "json",
			success : function(result) {
				if (result == 0) {
					alert("이메일이 틀렸습니다. \n 다시 입력해 주세요.");
				} else if (result == 1) {
					alert("입력한 이메일로 이메일이 발송되었습니다.");
					$(".msg").show();
					$(".email").hide();
				} else if (result == -1) {
					alert("메일 발송이 실패했습니다.");
				} else {
					alert("에러가 발생하였습니다.");
				}
			},
			error : function(error) {
				alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
			}
		});
	}
};

function fn_EmailConfirmCheck() {
	var emailConfirm = $("#emailConfirm").val();
	var userData = {
		"emailConfirm" : emailConfirm
	}

	if (emailConfirm.length < 1) {
		alert("이메일을 입력해주시기 바랍니다.");
	} else {
		$.ajax({
			type : "POST",
			url : "emailVerifyCertification.we",

			data : userData,
			dataType : "json",
			success : function(result) {
				if (!result) {
					alert("발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!");
				} else if (result) {
					alert("인증성공 되었습니다.");
					$("#email").attr("disabled", true);
					$(".confirmEnd").show();
					$(".comp").show();
					$(".msg").hide();
				} else {
					alert("에러가 발생하였습니다.");
				}
			},
			error : function(error) {
				alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
			}
		});
	}
};

</script>
</head>
<body>
	<input type="text" name="email" id="email" class="email" placeholder="인증번호 발송 시 필요합니다." /> 
	<a href="#" id="email_checkBtn" class="btn email">인증코드 보내기</a> 
	<input type="text"name="emailConfirm" id="emailConfirm" class="msg" /> 
	<a href="#" id="emailConfirm_checkBtn" class="btn msg">이메일 인증</a>
	<div class="comp">인증이 완료되었습니다.<br/>창을 닫으시고 계속 진행하십시오.</div>
</body>
</html>