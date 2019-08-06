<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
function goDetail(cartno) {
	
}

</script>
<div class="whole-wrap">
	<div class="container">
		<div class="section-top-border">
			<h3 class="mb-30 title_color">Table</h3>
			<div class="progress-table-wrap">
				<div class="progress-table">
					<div class="table-head">
						<div class="serial">#</div>
						<div class="country">Hotel</div>
						<div class="visit">Date</div>
						<div class="percentage">Room</div>
					</div>
					<c:forEach var="cvo" items="${cvoList}" varStatus="status">
						<div class="table-row">
							<div class="serial">${status.count}</div>
							<div class="country">
								<img src="resources/img/hotel_img/${cvo.acc_img}" width="70px" height="70px"><a href='/wetre/myPageDetail.we?cartno=${cvo.cartno}'>${cvo.fk_acc_name} (${cvo.acc_grade}성급)</a>
							</div>
							<div class="visit">${cvo.book_start}~${cvo.book_end}</div>
							<div class="percentage">
									${cvo.fk_rtype_name}
							</div>
						</div>
					</c:forEach>
					<!-- <div class="table-row">
						<div class="serial">02</div>
						<div class="country">
							<img src="img/elements/f2.jpg" alt="flag">Canada
						</div>
						<div class="visit">645032</div>
						<div class="percentage">
							<div class="progress">
								<div class="progress-bar color-2" role="progressbar"
									style="width: 30%" aria-valuenow="30" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="table-row">
						<div class="serial">03</div>
						<div class="country">
							<img src="img/elements/f3.jpg" alt="flag">Canada
						</div>
						<div class="visit">645032</div>
						<div class="percentage">
							<div class="progress">
								<div class="progress-bar color-3" role="progressbar"
									style="width: 55%" aria-valuenow="55" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="table-row">
						<div class="serial">04</div>
						<div class="country">
							<img src="img/elements/f4.jpg" alt="flag">Canada
						</div>
						<div class="visit">645032</div>
						<div class="percentage">
							<div class="progress">
								<div class="progress-bar color-4" role="progressbar"
									style="width: 60%" aria-valuenow="60" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="table-row">
						<div class="serial">05</div>
						<div class="country">
							<img src="img/elements/f5.jpg" alt="flag">Canada
						</div>
						<div class="visit">645032</div>
						<div class="percentage">
							<div class="progress">
								<div class="progress-bar color-5" role="progressbar"
									style="width: 40%" aria-valuenow="40" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="table-row">
						<div class="serial">06</div>
						<div class="country">
							<img src="img/elements/f6.jpg" alt="flag">Canada
						</div>
						<div class="visit">645032</div>
						<div class="percentage">
							<div class="progress">
								<div class="progress-bar color-6" role="progressbar"
									style="width: 70%" aria-valuenow="70" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="table-row">
						<div class="serial">07</div>
						<div class="country">
							<img src="img/elements/f7.jpg" alt="flag">Canada
						</div>
						<div class="visit">645032</div>
						<div class="percentage">
							<div class="progress">
								<div class="progress-bar color-7" role="progressbar"
									style="width: 30%" aria-valuenow="30" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="table-row">
						<div class="serial">08</div>
						<div class="country">
							<img src="img/elements/f8.jpg" alt="flag">Canada
						</div>
						<div class="visit">645032</div>
						<div class="percentage">
							<div class="progress">
								<div class="progress-bar color-8" role="progressbar"
									style="width: 60%" aria-valuenow="60" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div> -->
				</div>
			</div>
		</div>
	</div>
</div>