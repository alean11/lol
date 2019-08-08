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

		
	$("#phone_checkBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_phoneCheck();
	});
	$("#phoneConfirm_checkBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_phoneConfirmCheck();
	});

});

function fn_phoneCheck() {
	var phone = $("#phone").val();
	var userData = {
		"phone" : phone
	}

	if (phone.length < 1) {
		alert("이메일을 입력해주시기 바랍니다.");
	} else {
		$.ajax({
			type : "POST",
			url : "checkPhone.we",

			data : userData,
			dataType : "json",
			success : function(result) {
				if (result == 0) {
					alert("이메일이 틀렸습니다. \n 다시 입력해 주세요.");
				} else if (result == 1) {
					alert("입력한 이메일로 이메일이 발송되었습니다.");
					$(".msg").show();
					$(".phone").hide();
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

function fn_phoneConfirmCheck() {
	var phoneConfirm = $("#phoneConfirm").val();
	var userData = {
		"phoneConfirm" : phoneConfirm
	}

	if (phoneConfirm.length < 1) {
		alert("이메일을 입력해주시기 바랍니다.");
	} else {
		$.ajax({
			type : "POST",
			url : "phoneVerifyCertification.we",

			data : userData,
			dataType : "json",
			success : function(result) {
				if (!result) {
					alert("발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!");
				} else if (result) {
					alert("인증성공 되었습니다.");
					$("#phone").attr("disabled", true);
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
	<span>전화번호 : </span>
	<input type="text" name=phone id="phone" class="phone" placeholder="-는 생략하세요." /> 
	<a href="#" id="phone_checkBtn" class="btn phone">인증코드 보내기</a> 
	<input type="text"name="phoneConfirm" id="phoneConfirm" class="msg" /> 
	<a href="#" id="phoneConfirm_checkBtn" class="btn msg">이메일 인증</a>
	<div class="comp">인증이 완료되었습니다.<br/>창을 닫으시고 계속 진행하십시오.</div>
</body>
</html>