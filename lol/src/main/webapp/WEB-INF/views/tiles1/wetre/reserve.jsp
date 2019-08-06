<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<style>
.spinner {
	width: 100px;
}

.spinner input {
	text-align: right;
}

.input-group-btn-vertical {
	position: relative;
	white-space: nowrap;
	width: 1%;
	vertical-align: middle;
	display: table-cell;
}

.input-group-btn-vertical>.btn {
	display: block;
	float: none;
	width: 100%;
	max-width: 100%;
	padding: 8px;
	margin-left: -1px;
	position: relative;
	border-radius: 0;
}

.input-group-btn-vertical>.btn:first-child {
	border-top-right-radius: 4px;
}

.input-group-btn-vertical>.btn:last-child {
	margin-top: -2px;
	border-bottom-right-radius: 4px;
}

.input-group-btn-vertical i {
	position: absolute;
	top: 0;
	left: 4px;
}
</style>
<script type="text/javascript">
	$(function() {
		/* spinner starttttttttttttttttttttttttttttttttttttttttttttttt */
		$('#lee').blur(function() {
			var regexp = /^[0-9]*$/

			var input = $('#lee').val();

			if (!regexp.test(input)) {

				alert("숫자만 입력하세요");

				$('#lee').val("");
			}
			console.log(input);
			if (parseInt(input) > 10) {
				$('#lee').val(10);
			} else if (parseInt(input) < 0) {
				$('#lee').val(0);

			}
		});
		$('.spinner .btn:first-of-type').on(
				'click',
				function() {
					var btn = $(this);
					var input = btn.closest('.spinner').find('input');
					if (input.attr('max') == undefined
							|| parseInt(input.val()) < parseInt(input
									.attr('max'))) {
						input.val(parseInt(input.val(), 10) + 1);
					} else {
						btn.next("disabled", true);
					}
				});
		$('.spinner .btn:last-of-type').on(
				'click',
				function() {
					var btn = $(this);
					var input = btn.closest('.spinner').find('input');
					if (input.attr('min') == undefined
							|| parseInt(input.val()) > parseInt(input
									.attr('min'))) {
						input.val(parseInt(input.val(), 10) - 1);
					} else {
						btn.prev("disabled", true);
					}
				});
		/* spinner enddddddddddddddddddddddddddddddddddd */

		/* datepicker startttttttttttttttttttttttttttttttttt */
		$('input[name="startDate"], input[name="endDate"]').daterangepicker({
			autoUpdateInput : false,
			locale : {
				cancelLabel : 'Clear'
			}
		});
		$('input[name="startDate"], input[name="endDate"]').on(
				'apply.daterangepicker',
				function(ev, picker) {
					$("#startDate").val(picker.startDate.format('YYYY-MM-DD'));
					$("#endDate").val(picker.endDate.format('YYYY-MM-DD'));

					var startDate = $("#startDate").val();
					$(".time").text(startDate);
					var endDate = $("#endDate").val();
					var date = new Date(startDate);

					var date1 = new Date(endDate);
					var diff = (date1.getTime() - date.getTime())
							/ (1000 * 60 * 60 * 24);
					console.log(diff + '일');
					$(".dateCnt").text(diff + "박");

				});

		$('input[name="startDate"], input[name="endDate"]').on(
				'cancel.daterangepicker', function(ev, picker) {
					$("#startDate").val('');
					$("#endDate").val('');
				});
		/* datepicker enddddddddddddddddddddddddddddddddddddd */
	});
	$(document).ready(function() {
			$(".confirm").show();
			$(".confirmEnd").hide();
		$(".submit").click(function() {
		
		});
		$(".myclose").click(function() {
			$.ajax({
				type : "GET",
				url : "ok.we",
				dataType : "json",
				success : function(result) {
					if (result == true) {
						$(".confirm").hide();
						$(".confirmEnd").show();
					}
				},
				error : function(error) {
					alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
				}
			});
		});
		
		

	});
	
</script>

<div align="center">
	<form name="hotelFrm">
		<div align="center" style="width: 80%;">
			<div align="left">
				<h1>hotelname</h1>
				<h2>${accvo.acc_name}</h2>
			</div>
			<!-- {p_name} -->

			<div align="left">
				<h2>room</h2>
				<h3>${accvo.room.r_text }</h3>
			</div>
			<!-- r_name -->
			<div>
				<img
					src="/wetre/resources/img/hotel_img/${accvo.acc_img}"
					width="30%;" align="left" />
			</div>
			<!-- 
			<h1 style="width:100%; font-family: serif;">
				<input style="width:47%;" type="text" name="datefilter" id="startDate" value="" placeholder="체크인"/> -> 
				<input style="width:47%;" type="text" name="datefilter" id="endDate" value="" placeholder="체크아웃"/>
			</h1>
			<h2 style="width:100%; font-family: serif;">10:00 -> 24:00</h2> -->
			<div style="margin-top: 10px;">
				<table style="width: 100%; font-size: 30px;">

					<tr style="width: 100%;">

						<td align="left"><input style="width: 90%;" type="text"
							name="startDate" id="startDate" value="" placeholder="체크인"
							autocomplete="off" /></td>

						<td align="center">-></td>

						<td align="left"><input style="width: 90%;" type="text"
							name="endDate" id="endDate" value="" placeholder="체크아웃"
							autocomplete="off" /></td>
					</tr>
					<tr style="width: 100%;">
						<td align="left">10:00</td>
						<td align="center"></td>
						<td align="left">24:00</td>
					</tr>
				</table>

				<div>
					총 숙박기간 : <span class="dateCnt"></span>
				</div>

			</div>

			<div align="left">
				<h2>예약정보</h2>
			</div>

			<div style="width: 100%" align="left">
				<label style="width: 8%">투숙객 대표자 성명</label><input type="text"
					name="p_name" placeholder="체크인 시 필요합니다."
					style="margin: 1%; width: 40%;" />
			</div>
			<!-- spinnerrrrrrrrrrrrrrrrrrrrrrrrrr  -->
			<div class="input-group spinner" align="left">
				<span style="text-align: left;">인원수</span> <input type="text" id="lee" class="form-control"
				
					max="10" min="0" value="0">
				<div class="input-group-btn-vertical">
					<button class="btn btn-default" type="button">
						<i class="fa fa-caret-up"></i>
					</button>
					<button class="btn btn-default" type="button">
						<i class="fa fa-caret-down"></i>
					</button>
				</div>
			</div>

			<!--  -->


			<!-- 			<div style="width: 100%">
				<label style="width: 8%">예약약자 번호</label><input type="text" name="tel" placeholder="예약문자 발송 시 필요합니다." style="margin:1%; width: 90%;"/>
			</div> -->

			<!-- <div align="left">
				<input type="text" name="email" id="email" class="email"
					placeholder="인증번호 발송 시 필요합니다." /> <a href="#" id="email_checkBtn"
					class="btn email">인증코드 보내기</a> <input type="text"
					name="emailConfirm" id="emailConfirm" class="confirm" /> <a
					href="#" id="emailConfirm_checkBtn" class="btn confirm">이메일 인증</a>
			</div> -->
				<div class="confirm">
						<a style="cursor: pointer;" data-toggle="modal" data-target="#emailCheck" data-dismiss="modal" >이메일로 인증</a> /
		    		   <a style="cursor: pointer;" data-toggle="modal" data-target="#phoneCheck" data-dismiss="modal" data-backdrop="static">핸드폰으로 인증</a>
		    	</div>
		    	<div class="confirmEnd">
		    		인증이 완료되었습니다.
		    	</div>
			<div style="width: 100%; margin-bottom: 10px;">
				<div>
					<div align="left">
						별도 요청 사항<br /> 별도 요청 사항 제공을 보장해드리기 어렵습니다만, 숙소 측에서 최선을 다해 준비하겠습니다.<br />
						예약 후에도 별도 요청 사항을 보내실 수 있어요!<br /> 고객 메시지 및 요청에 답변이 빠른 숙소입니다
					</div>

					<textarea rows="10" cols="200">
				</textarea>
				</div>
				
				<div>
					<span>숙소 측에 체크인 예정 시간을 알려주세요 (선택 입력)<br /> 체크인 시간에 관해 숙소로부터
						답변이 올 수 있습니다.<br /> 24시간 프런트 데스크: 편한 때에 오세요 – 고객님의 객실은 14:00에 준비
						완료됩니다<br /> 도착 시간: <span class="time"></span></span>
					<div style="display: inline-block;">
						<select name="" id="" class="">

							<option value="-1">아모른직다</option>
							<c:forEach begin="14" end="23" var="i">
								<option aria-label="2019년 8월 12일 월요일 : ${i}:00 - ${i+1}:00"
									value="14">${i}:00 - ${i+1}:00</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<button style="width: 30%" class="submit">확인</button>
			</div>
		</div>
	</form>

</div>

<%-- ****** 아이디 찾기 Modal ****** --%>
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


<%-- ****** 비밀번호 찾기 Modal ****** --%>
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