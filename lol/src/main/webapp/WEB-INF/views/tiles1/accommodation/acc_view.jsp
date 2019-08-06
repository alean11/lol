<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<%
    String ctxPath = request.getContextPath();
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	$(document).ready(function(){

		var form_data = $("#idx").val();
	
		$.ajax({
			url:"<%= request.getContextPath()%>/addMap.action",
			data:form_data,
			type:"GET",
			dataType: "JSON",
			success:function(json) {
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
			 
	}); // end of $(document).ready(function() -------------

</script>


</head>
<body>
   <div style="width: 95%;">
      <%-- 숙박시설 명칭 및 숙박시설 주소 --%>   
      <div class="col-md-4 line">
         <ul style="list-style-type: none;">
            <li style="font-size: 15pt; color: navy; margin-bottom: 10px;">${avo.acc_name}</li>
            <li style="font-size: 13pt; color: navy;">${avo.acc_addr1}</li>
         </ul>
      </div>
      
      <%-- 숙박시설 대표이미지 및 숙박시설 설명 --%>
      <div class="row" style="border: 1px solid red;"> 
         <div class="col-md-4 line" style="margin-left: 50px;">
            <img src="<%= request.getContextPath()%>/resources/img/hotel_img/${avo.acc_img}" style="width: 350px; height: 290px;">
         </div>
         
         <div class="col-md-6 line" style="margin-left: 25px;">
            <span>${avo.acc_text}</span>
         </div>
      </div>
      
      
      <%-- 숙박시설 위치(구글지도 API 사용) --%>
      <div id="googlemap"></div>
   
   	   <form name="map">
   	   		<input type="hidden" name="idx" id="idx" value="${avo.acc_idx}"/>
   	   </form>
   
     
  
 
</div>      
</body>
</html>