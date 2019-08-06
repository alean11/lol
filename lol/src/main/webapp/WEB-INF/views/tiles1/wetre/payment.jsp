<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>


<script type="text/javascript">

	$(document).ready(function(){

		// 인증관련
		$(".confirm").show();
		$(".confirmEnd").hide();
		
		$('[name="contactInfo"]').attr("disabled", true); // 인증 전에 연락처 인풋을 동결시킴(인증 안 했으면 값을 전송 못 시키게 하려고).

		$(".myclose").click(function() {
			$.ajax({
				type : "GET",
				url : "ok.we",
				dataType : "json",
				success : function(result) {
					if (result == true) {
						$(".confirm").hide();
						$(".confirmEnd").show();
						
						// 인증 후 연락처 인풋을 readonly로 바꿈.
						$('[name="contactInfo"]').removeAttr("disabled");
						$('[name="contactInfo"]').attr("readonly", true);
					}
				},
				error : function(error) {
					alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
				}
			});
		});
		
		
		// 지불하기 버튼
		$("#payment").click(function(){
			
			console.log($("[name='payMethod']").val());
			
			if($("[name='payMethod']").val() == "" || $("[name='payMethod']").val() == null) {
				alert("결제 방식을 선택해주세요.");
				return false;
			}
			
			if(!$("#confirmCheckBox").is(":checked")) {
				alert("내용에 동의하셔야 결제가 진행됩니다.");
				return false;
			}

			payFrmAction();
			
		}); // end of 지불하기 ---------
		
	}); // end of document ready -----

	
	function payFrmAction() {
		var frm = document.payFrm;
		window.open("", "Payment", "left=350px, top=100px, width=820px, height=600px");
		frm.action = "<%= request.getContextPath()%>"+"/paymentEnd.we";
		frm.method = "POST";
		frm.target = "Payment";
		frm.submit();
	}
	
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
								<span style="font-size: large; color: white; margin-left: 10px;">선택하신 호텔 정보</span>
								<span style="font-size: small; color: white; margin: 15px 10px 0px 2px; display: block;">· 호텔명</span>
								<input type="text" class="form-control" style="cursor: default; margin-bottom: 10px;" value="${acc_name} (${acc_grade}성급)" readonly />

								<span style="font-size: small; color: white; margin: 15px 10px 0px 2px; display: block;">· 방 정보</span>
								<input type="text" class="form-control" style="cursor: default; margin-bottom: 10px;" value="${rtype_name}, ${rtype_cnt}개" readonly />

								<span style="font-size: small; color: white; margin: 15px 10px 0px 2px; display: block;">· 호텔주소</span>
								<input type="text" class="form-control" style="cursor: default; margin-bottom: 10px;" value="${acc_addr1} ${acc_addr2}" readonly />

								<span style="font-size: small; color: white; margin: 15px 10px 0px 2px; display: block;">· 호텔 전화번호</span>
								<input type="text" class="form-control" style="cursor: default;" value="${acc_tel1} - ${acc_tel2} - ${acc_tel3}" readonly />

								<input type="hidden" name="rtype_idx" value="${r_idx}" />
								<input type="hidden" name="rtype_idx" value="${rtype_idx}" />
								<input type="hidden" name="rtype_cnt" value="${rtype_cnt}" />
							</div>


							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px; margin-bottom: ">선택하신 날짜</span>
								<input type="text" class="form-control" style="cursor: default; margin-top: 15px;" value="${book_start} ~ ${book_end}" readonly />
								<input type="hidden" name="book_start" value="${book_start}" />
								<input type="hidden" name="book_end" value="${book_end}" />
							</div>

							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">회원 아이디</span>
								<input type="email" class="form-control" name="p_userid" style="cursor: default; margin-top: 15px;" readonly value="${p_userid}"/>
							</div>

							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">회원명</span>
								<input type="text" class="form-control" name="p_name" style="cursor: default; margin-top: 15px;" readonly value="${p_name}" />
								<input type="hidden" class="form-control" name="idx" value="${idx}" />
							</div>

							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">투숙객 대표자명</span>
								<input type="text" class="form-control" name="reserver" placeholder="체크인 시 필요합니다. 입력해주세요."
									   onfocus="this.placeholder = ''" onblur="this.placeholder = '체크인 시 필요합니다. 입력해주세요.'" style="margin-top: 15px;"/>
							</div>

							<div class="confirm form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">연락처 인증</span>
								<span class="confirmEnd" style="font-size: small; font-weight: bold; color: #ff2f8b; margin-left: 30px;">인증이 완료되었습니다.</span>
									<div class="button-group-area" style="margin-top: 0px;">
										<a class="genric-btn default circle" style="width: 58px; padding: 0px; line-height: 25px; color: white; background: #ff2f8b;"
											data-toggle="modal" data-target="#emailCheck" data-dismiss="modal" >이메일</a>
										<a class="genric-btn default circle" style="width: 58px; padding: 0px; line-height: 25px; color: white; background: #ff2f8b;"
											data-toggle="modal" data-target="#phoneCheck" data-dismiss="modal" data-backdrop="static">핸드폰</a>
									</div>
					    	</div>
							<div class="form-group col-md-12" style="text-align: left;">
								<input type="text" class="form-control" style="cursor: default;" name="contactInfo" value=""
									   placeholder="연락처는 인증하신 연락처로 자동으로 입력됩니다."/>
							</div>

							
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">가격</span>
								<fmt:formatNumber var="priceComma" value="${accPrice}" pattern="###,###"/>
								<input type="text" class="form-control" style="cursor: default; margin-top: 15px;" readonly value="${priceComma} 원 " />
								<input type="hidden" name="payPrice" value="${accPrice}" />
							</div>

							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px; display: block;">요청사항</span>
								<textarea name="requestTxt"
										  style="margin-top: 15px; border: 0; padding: 0px 20px; font-size: 13px; background: rgba(119, 135, 146, 0.8); color: white; line-height: 40px; border-radius: 0px; width: 100%; height: 100px;" 
										  placeholder="별도 요청 사항 제공을 보장해드리기 어렵습니다만, 숙소 측에서 최선을 다해 준비하겠습니다. 예약 후에도 별도 요청 사항을 보내실 수 있어요! 고객 메시지 및 요청에 답변이 빠른 숙소입니다."></textarea>
							</div>
							
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px; display: inline-block;">
								<span style="font-size: large; color: white; margin-left: 10px;">체크인 예정시간</span>
								<span style="font-size: small; color: white; margin: 10px 10px 0px 2px; display: block;">체크인 시간에 관해 숙소로부터 답변이 올 수 있습니다.</span>
								<span style="font-size: small; color: white; margin: 0px 10px 10px 2px; display: block;">24시간 프런트 데스크: 편한 때에 오세요 – 고객님의 객실은 14:00에 준비 완료됩니다.</span>
								<div class="form-select" style="width: 160px;">
									<select name="reserveDate" style="display: none;">
										<option value="-1">아직 모름</option>
										<c:forEach begin="14" end="23" var="i">
											<option aria-label="2019년 8월 12일 월요일 : ${i}:00 - ${i+1}:00" value="14">${i}:00 - ${i+1}:00</option>
										</c:forEach>
									</select>
								</div>
							</div>
							
							
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<span style="font-size: large; color: white; margin-left: 10px;">쿠폰 번호</span>
								<input type="text" class="form-control" id="" name="" />
								<%--	- 쿠폰 존재 확인(에이작스).
										- 여기 value에 직접 입력시킴.
										- 퍼센트값 얻어옴. 퍼센트값은 소수점으로 넣을 것. 그걸로 가격 계산. (가격*(1-퍼센트값))
										- 나온 가격을 가격 인풋에 다시 넣어줌.
										- 결제가 성공하면, 쿠폰을 지움.(트랜잭션)
											: 즉, 쿠폰 테이블에는 회원 아이디랑 쿠폰이 잇어야 됨. 그래서 그 회원의 그 쿠폰만 지움.
								 --%>
							</div>
							
							<div class="form-group col-md-12" style="text-align: left; margin-top: 50px;">
								<div class="form-select">
									<span style=" font-size: large; color: white; margin-left: 10px;">결제 방식</span>
									<select name="payMethod" style="display: none;">
										<option value="">결제 방식</option>
										<option value="card">카드</option>
										<option value="kakaoPay">카카오페이</option>
										<option value="bank">무통장 입금</option>
										<option value="direct">현장 결제</option>
									</select>
								</div>
							</div>
							
							<div class="form-group col-md-12" style="text-align: center; margin-top: 90px;">
								<label for="confirmCheckBox" style="margin-right: 2px; display: inline;">
									<span style="color: white;">이상의 내용을 확인하였으며, 해당 내용에 동의합니다.</span>
								</label>
								<input type="checkbox" id="confirmCheckBox">
								<span style="color: white; display: block;">(동의하지 않을 시 결제가 진행되지 않습니다.)</span>
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



<%-- ****** 이메일 인증 Modal ****** --%>
  <div class="modal fade" id="emailCheck" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">이메일로 인증하기</h4>
        </div>
        <div class="modal-body" style="height: 300px; width: 100%;">
          <div id="idFind">
          	<div align="left">
					<iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath()%>/emailPage.we">
          			</iframe>
			</div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>


<%-- ****** 휴대폰 인증 Modal ****** --%>
  <div class="modal fade" id="phoneCheck" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">휴대폰으로 인증</h4>
        </div>
        <div class="modal-body">
          <div id="pwFind">
				<iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath()%>/phonePage.we">
          			</iframe>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>	