<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">

	var companyuser = "${sessionScope.companyuser}";
	var gobackURL = "${requestScope.gobackURL}";
	
	if(companyuser != null && (gobackURL == null || gobackURL == "")) {
		alert("로그인 되었습니다.");
		location.href="<%= ctxPath%>/accommodation/accList.we";
	}
	
	else if(companyuser != null && (gobackURL != null && gobackURL != "")) {
		alert("로그인 되었습니다.");
		location.href=gobackURL;
	} 
</script>    