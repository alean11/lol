<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>


<script type="text/javascript">

</script>
    
    
    
	<!--================ Start Book a Trip Area =================-->
	<section class="trip-area section_gap">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-7 col-md-10">
					<div class="trip-form-section">
						<h1>Payment</h1>
						
						<form name="payFrm" class="trip-form-area trip-page-form trip-form text-right">
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">예약하신 호텔 정보</span>
								<span style="font-size: small; color: white; margin: 15px 10px 0px 2px; display: block;">· 호텔명</span>
								<input type="text" class="form-control" style="cursor: default; margin-bottom: 10px;" value="${cvo.fk_acc_name} (${cvo.acc_grade}성급)" readonly />
								
								<span style="font-size: small; color: white; margin: 15px 10px 0px 2px; display: block;">· 방 정보</span>
								<input type="text" class="form-control" style="cursor: default; margin-bottom: 10px;" value="${cvo.fk_rtype_name}<%-- , ${cvo.fk_rtype_cnt}개 --%>" readonly />

								<span style="font-size: small; color: white; margin: 15px 10px 0px 2px; display: block;">· 호텔주소</span>
								<input type="text" class="form-control" style="cursor: default; margin-bottom: 10px;" value="${cvo.full_acc_addr}" readonly />

								<span style="font-size: small; color: white; margin: 15px 10px 0px 2px; display: block;">· 호텔 전화번호</span>
								<input type="text" class="form-control" style="cursor: default;" value="${cvo.full_acc_tel}" readonly />

							</div>


							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px; margin-bottom: ">투숙일</span>
								<input type="text" class="form-control" style="cursor: default; margin-top: 15px;" value="${cvo.book_start} ~ ${cvo.book_end}" readonly />
							</div>

							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">투숙객 대표자 성명</span>
								<input type="email" class="form-control" name="p_userid" style="cursor: default; margin-top: 15px;" readonly value="${cvo.reserver}"/>
							</div>

							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">예약한 회원명</span>
								<input type="text" class="form-control" name="p_name" style="cursor: default; margin-top: 15px;" readonly value="${cvo.p_name}" />
							</div>
							
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">예약한 인원수</span>
								<input type="text" class="form-control" name="p_name" style="cursor: default; margin-top: 15px;" readonly value="어른${cvo.adultNum}, 어린이${cvo.kidsNum}" />
							</div>

							
							<div class="form-group col-md-12" style="text-align: left;">
								<input type="text" class="form-control" style="cursor: default;" name="contactInfo" value="${cvo.contactinfo}"/>
							</div>

							
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">총금액</span>
								<fmt:formatNumber var="priceComma" value="${cvo.cart_price}" pattern="###,###"/>
								<input type="text" class="form-control" style="cursor: default; margin-top: 15px;" readonly value="${priceComma} 원 " />
							</div>

							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px; display: block;">요청사항</span>
								<textarea name="requestTxt"
										  style="margin-top: 15px; border: 0; padding: 0px 20px; font-size: 13px; background: rgba(119, 135, 146, 0.8); color: white; line-height: 40px; border-radius: 0px; width: 100%; height: 100px;" 
										  >${cvo.requesttxt}</textarea>
							</div>
							
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px; display: inline-block;">
								<span style="font-size: large; color: white; margin-left: 10px;">체크인 예정시간</span>
								<span style="font-size: small; color: white; margin: 10px 10px 0px 2px; display: block;">체크인 시간에 관해 숙소로부터 답변이 올 수 있습니다.</span>
								<span style="font-size: small; color: white; margin: 0px 10px 10px 2px; display: block;">24시간 프런트 데스크: 편한 때에 오세요 – 고객님의 객실은 14:00에 준비 완료됩니다.</span>
								<div class="form-select" style="width: 160px;">
									<input type="text" class="form-control" style="cursor: default; margin-top: 15px;" readonly value="${cvo.expectedtime}"/>
								</div>
							</div>
							
							
						
							
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<div class="form-select">
									<span style=" font-size: large; color: white; margin-left: 10px;">결제 방식</span>
									<input value="${cvo.payMethod}"/>
								</div>
							</div>
							
							<div class="col-lg-12 text-center">
								<button id="payment" class="primary-btn text-uppercase">Pay</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>	
	</section>
	<!--================ End Book a Trip Area =================-->

