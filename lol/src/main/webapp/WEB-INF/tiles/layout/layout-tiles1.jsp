<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<% String ctxPath = request.getContextPath(); %>

<%-- === #22. tiles 를 사용하는 레이아웃1 페이지: 사이드바가 *없는* 디자인 --%>    
<!DOCTYPE html>
<html>

<head>
	<!-- Required meta tags -->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="icon" href="<%= ctxPath%>/resources/img/favicon.png" type="image/png">
	<title>Wetre</title>
	<!-- Bootstrap CSS -->
	<script src="<%= ctxPath%>/resources/js/jquery-3.2.1.min.js"></script>
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/bootstrap.css">
	<link rel="stylesheet" href="<%= ctxPath%>/resources/vendors/linericon/style.css">
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/magnific-popup.css">
	<link rel="stylesheet" href="<%= ctxPath%>/resources/vendors/owl-carousel/owl.carousel.min.css">

    <link rel="stylesheet" href="<%= ctxPath%>/resources/vendors/nice-select/css/nice-select.css">
	<!-- main css -->
	<link rel="stylesheet" href="<%= ctxPath%>/resources/css/style.css">
</head>

<body>
	
	<tiles:insertAttribute name="header"/>

	<tiles:insertAttribute name="content"/>

	<tiles:insertAttribute name="footer"/>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="<%= ctxPath%>/resources/js/popper.js"></script>
	<script src="<%= ctxPath%>/resources/js/bootstrap.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/stellar.js"></script>
	<script src="<%= ctxPath%>/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="<%= ctxPath%>/resources/vendors/nice-select/js/jquery.nice-select.min.js"></script>
	<script src="<%= ctxPath%>/resources/vendors/owl-carousel/owl.carousel.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/owl-carousel-thumb.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/jquery.ajaxchimp.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/mail-script.js"></script>
	<!--gmaps Js-->
	
	<script src="<%= ctxPath%>/resources/js/gmaps.min.js"></script>
	<script src="<%= ctxPath%>/resources/js/theme.js"></script>

</body>

</html>