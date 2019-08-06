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

    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA">
    </script>

<script type="text/javascript">
$(document).ready(function () {
    var map;
    var elevator;
    var myOptions = {
        zoom: 15,
        center: {lat: 37.567957, lng: 126.983134},
        
        mapTypeId: 'roadmap'
        
    };
    map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
   
    console.log(${storemapList.size()});
    /* var addresses = ['거제시', '통영시', '김해시','남해군','창원시']; */

    
    markerArr = new Array(${storemapList.size()});
//    for (var x = 0; x < addresses.length; x++) {
    	<c:forEach var="storemapvo" items="${storemapList}" varStatus="status">	
    	 $.getJSON('https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDDQx9Q_JsWUjWyssoeEaeBGSbhvGcTyrA&sensor=false&address='+"${storemapvo.acc_addr1}", null, function (data) {
             var p = data.results[0].geometry.location
             var latlng = new google.maps.LatLng(p.lat, p.lng);
             markerArr[${status.index}] = new google.maps.Marker({
                 position: latlng,
                 map: map, 
                 /*icon : addresses[x][3],              // 마커 이미지 */
     			title : "${storemapvo.acc_name}",          // 위에서 정의한 "${store.storeName}" 임
 /*     			title : addresses[x][1],          // 위에서 정의한 "${store.storeName}" 임 */
     			zIndex : ${status.index}  // 위에서 정의한 "${storevo.zindex}" 임.  Number() 함수를 꼭 사용해야 함을 잊지 말자.
 /*     			zIndex : Number(addresses[x][2])  // 위에서 정의한 "${storevo.zindex}" 임.  Number() 함수를 꼭 사용해야 함을 잊지 말자. */
             });
             markerListener(map, markerArr[${status.index}], ${status.index}, ${storemapvo.acc_idx});
         });
        </c:forEach>
//    }
    var geocoder = new google.maps.Geocoder();
    document.getElementById('submit').addEventListener('click', function() {
        geocodeAddress(geocoder, map);
      });

    
    
    var infowindowArr = new Array();  // 풍선창(풍선윈도우) 여러개를 배열로 저장하기 위한 용도 

    //**** 마커를 클릭했을때 어떤 동작이 발생하도록 하는 함수 생성하기 ****// 
    function markerListener(map, marcker, x, idx){      

    	// 확인용
    	console.log(marcker.zIndex);	//  1  2  3
    	

    	// === 풍선창(풍선윈도우)만들기 ===
    	var infowindow = new google.maps.InfoWindow(  
    			{//	content: '안녕하세요~', 
    			 // content: marker.title,	
    			    content: viewContent(marcker.title, idx), 
    			 // size: new google.maps.Size(200,200) 
    			});
    	
    	infowindowArr[x] = infowindow; 
    	// 생성한 풍선창(풍선윈도우) infowindow를 배열 infowindowArr 속에 집어넣기		
    	
    	// **** === marker에 click 이벤트 처리하기 === ***// 
    	/*  마커를 클릭했을때 어떤 동작이 발생하게 하려면  
         addListener() 이벤트 핸들러를 사용하여 이벤트 알림을 등록하면 된다. 
                    이 함수는 소스객체, 수신할 이벤트, 지정된 이벤트가 발생할 때 호출할 함수를 인자로 받는다. */
    	google.maps.event.addListener(marcker, 'click', 
    	    function(){ 
    		      // marker에(i번째 마커) click(클릭)했을 때 실행할 내용들...
         
               // 확인용
               // console.log(marker.zIndex);  // 1  2  3
    	     			
    			  for(var i=0; i<markerArr.length; i++) { // 생성된 마커의 갯수만큼 반복하여
    				  if(i != (marcker.zIndex) ) {     // 마커에 클릭하여 발생된 풍선창(풍선윈도우) infowindow 를 제외한 나머지 다른 마커에 달린 풍선창(풍선윈도우) infowindow 는
    					/* infowindowArr[i].close();	    // 닫는다. */	
    					
    				  }
    				  else if(i == (marcker.zIndex)) {           // 마커에 클릭하여 발생된 풍선창(풍선윈도우) infowindow 는
    					 infowindowArr[i].open(map, marcker);  // targetmap 상에 표시되어 있는 marker 위에 띄운다.
    					 
    				  }
    			  }// end of for-----------------------	 		
    		 	
    	  });  // end of google.maps.event.addListener()-------------------
    	
    }// end of function markerListener(map, marker)-----------

    function viewContent(title, zIndex) {
    	var html =  "<span style='color:red; font-weight:bold;'>"+title+"</span><br/>"
    		     +  "<a href='/wetre/reserve.we?acc_idx="+zIndex+"'>상세보기</a>"; 
    		         // 매장번호(marker.zIndex)를 넘겨받아 매장지점 상세정보 보여주기와 같은 팝업창 띄우기
    	return html;	
    }

    
}); // ready ------------------------------

function geocodeAddress(geocoder, resultsMap) {
    var address = document.getElementById('address').value;
    geocoder.geocode({'address': address}, function(results, status) {
      if (status === 'OK') {
        resultsMap.setCenter(results[0].geometry.location);
        
      } else {
        /* alert('Geocode was not successful for the following reason: ' + status); */
        alert('입력하신 주소는 없는주소 입니다.' + status);
      }
    });
  }
function goDetail(storeno) {
	var url = "reserve.we?acc_idx="+storeno;
	window.open(url, "reserve",
			    "width=700px, height=600px, top=50px, left=800px");
}

</script>
</head>

<body>
<div id="floating-panel">
	<input id="address" type="textbox" value="Sydney, NSW">
	<input id="submit" type="button" value="Geocode">
</div>
<div id="map_canvas"></div>

</body>

</html>
