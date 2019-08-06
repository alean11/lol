<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=${requestScope.regid}&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<%--// 여러개 쓰면 ajax에서 받아올 때 에러남. 값은 받아와서 성공인 걸로 code 200 뜨는데, 그게 에러 메세지로 뜸. 또 forEach로도 안 돌려짐.
	// 그래서 뷰단에서 ajax를 반복문으로 돌렸음. ajax를 반복문 돌릴 시, 충돌 안 나는 옵션 줘야됨.
	// 여기 서비스 키는 내 개인 키이므로, 딴데서 쓰지 말 것.
--%>

<%-- 이건 sk꺼. appkey는 본인 가입한 appkey 넣어야 하고, 각 지역별 관측소 전부 넣은 것임. 이것도 반복문 돌리거나 여러개 쓰면 오류남.
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=90&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=93&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=95&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=98&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=99&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=100&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=101&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=102&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=104&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=105&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=106&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=108&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=112&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=114&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=115&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=119&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=121&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=127&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=129&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=130&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=131&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=133&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=135&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=136&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=137&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=138&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=140&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=143&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=146&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=152&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=155&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=156&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=159&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=162&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=165&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=168&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=170&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=172&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=174&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=175&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=177&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=184&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=185&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=188&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=189&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=192&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=201&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=202&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=203&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=211&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=212&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=216&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=217&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=221&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=226&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=232&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=236&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=238&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=243&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=244&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=245&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=247&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=248&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=251&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=252&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=253&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=254&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=255&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=257&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=258&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=259&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=260&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=261&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=262&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=263&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=264&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=266&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=268&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=271&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=272&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=273&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=276&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=277&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=278&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=279&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=281&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=283&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=284&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=285&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=288&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=289&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=294&appKey= " charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=295&appKey= " charEncoding="UTF-8"/>
--%>




