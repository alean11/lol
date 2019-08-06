<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#map_canvas {
    width: 500px;
    height: 500px;
}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA&callback=initMap"></script>


<script type="text/javascript">
$(document).ready(function () {
    var map;
    var elevator;
    var myOptions = {
        zoom: 1,
        center: {lat: 37.567957, lng: 126.983134},
        
        mapTypeId: 'roadmap'
        
    };
    map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
    var addresses = [
       // <c:set var="cnt" value="1" />
       // <c:forEach var="storemapvo" items="${storemapList}" varStatus="status">               
           ${accList.acc_addr1}     
         //  <c:if test="${cnt < storemapList.size()}">
           
        //   </c:if>
       //    <c:set var="cnt" value="${cnt + 1}" />  
      //  </c:forEach>
       ];
    // console.log(${storemapList.size()});
    /* var addresses = ['거제시', '통영시', '김해시','남해군','창원시']; */

    
    for (var x = 0; x < addresses.length; x++) {
        $.getJSON('https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA&sensor=false&address='+addresses[x], null, function (data) {
            var p = data.results[0].geometry.location
            var latlng = new google.maps.LatLng(p.lat, p.lng);
            new google.maps.Marker({
                position: latlng,
                map: map
            });

        });
    }

});
</script>
</head>
<body>
<div id="map_canvas"></div>

</body>

</html>