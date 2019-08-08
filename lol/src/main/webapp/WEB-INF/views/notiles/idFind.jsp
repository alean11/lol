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
$(document).ready(function(){
	$("#div_findResult").hide();
	$("#not").hide();
	
});
function fn_idFind() {
	var name = $("#name").val();
	var mobile = $("#mobile").val();
	var type = $("#type").val();
	var userData = {
		"name" : name,
		"type" : type,
		"mobile" : mobile
	}

	if (name.length < 1) {
		alert("성명을 입력해주시기 바랍니다.");
	} 
	else if(mobile.length < 1) {
		alert("전화번호를 입력해주시기 바랍니다.");
	}
	else {
		$.ajax({
			type : "POST",
			url : "idFindEnd.we",
			data : userData,
			
			success : function(result) {
				if (result=='null') {
					$("#not").show(); 					
				}
				else{
				$("#div_findResult").show();
				$("#result").text(result);	
				$("#div_btnFind").hide();	
				
				}
				
			},
			error : function(error) {
				alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
			}
		});
	}
};
<% String type =  request.getParameter("type");%>
</script>
</head>
<body>
	<input type="text" name="type" id="type" value="<%=type%>"/>
    <div id="div_name" align="center">
      <span style="color: blue; font-size: 12pt;">성명</span><br/> 
      <input type="text" name="name" id="name" size="15" placeholder="홍길동" required />
   </div>
	
   <div id="div_mobile" align="center">
   	  <span style="color: blue; font-size: 12pt;">휴대전화</span><br/>
      <input type="text" name="mobile" id="mobile" size="15" placeholder="-없이 입력하세요" required />
   </div>
   
   
   <div id="div_findResult" align="center">
   	  ID : <span id="result" style="color: red; font-size: 16pt; font-weight: bold;"></span> 
   </div>
   <div id="not" align="center">
   		<span style="color: red; font-size: 16pt; font-weight: bold;">입력하신정보와 일치하는 아이디가 없습니다.</span>
   </div>
	
   <div id="div_btnFind" align="center">
   		<button type="button" class="btn btn-success" id="btnFind" onclick="fn_idFind();">찾기</button>
   </div>
   
   
</body>
</html>