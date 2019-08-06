<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

    <!--================  start footer Area =================-->
	<footer class="footer-area">
		<div class="footer_top section_gap_top">
			<div class="container">
				<div class="row">
					<div class="col-lg-3 col-md-6 col-sm-6">
						<div class="single-footer-widget">
							<h5 class="footer_title">About Wetre</h5>
							<p class="about-text"> We offer that you can go on a trip in nice weather. Just leave your time free for you.</p>
						</div>
					</div>
					<div class="col-lg-2 col-md-6 col-sm-6">
						<div class="single-footer-widget">
							<h5 class="footer_title">Navigation Links</h5>
							<div class="row">
								<div class="col-5">
									<ul class="list">
										<li><a href="#">Home</a></li>
										<li><a href="#">Weather</a></li>
										<li><a href="#">Short-range</a></li>
										<li><a href="#">Medium-range</a></li>
										<li><a href="#">Typhoon</a></li>
									</ul>
								</div>
								<div class="col-5">
									<ul class="list">
										<li><a href="#">Accommodation</a></li>
										<li><a href="#">Notice</a></li>
										<li><a href="#">Q & A</a></li>
										<li><a href="#">About us</a></li>
										<li><a href="#">Contact</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 col-sm-6">
<%-- ↓↓↓↓↓↓↓↓↓↓↓↓ 뉴스레터 부분인데, 쓸데가 없어서 일단 뺌. 디자인은 유지해야 해서 div만 남겨둠. 						
	 						<div class="single-footer-widget">
							<h5>Newsletter</h5>
							<p>For business professionals caught between high OEM price and mediocre print and graphic output, </p>
							<div class="footer-newsletter" id="mc_embed_signup">	
								<form target="_blank" novalidate="true" action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01"
								 method="get" class="form-inline">
									<div class="d-flex flex-row">
										<input class="form-control" name="EMAIL" placeholder="Enter Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Email '"
										 required="" type="email">
										<button class="click-btn btn btn-default"><span class="lnr lnr-location" aria-hidden="true"></span></button>
										<div style="position: absolute; left: -5000px;">
											<input name="b_36c4fd991d266f23781ded980_aefe40901a" tabindex="-1" value="" type="text">
										</div>
									</div>
									<div class="info"></div>
								</form>
							</div>
						</div> --%>
					</div>
					<div class="col-lg-3  col-md-6 col-sm-6">
						<div class="single-footer-widget mail-chimp">
							<h5 class="mb-20">Instragram Feed</h5>
							<ul class="instafeed d-flex flex-wrap">
								<li><img src="<%= ctxPath%>/resources/img/i1.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i2.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i3.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i4.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i5.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i6.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i7.jpg" alt=""></li>
								<li><img src="<%= ctxPath%>/resources/img/i8.jpg" alt=""></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="copyright">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-12">
						<p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
</p>
					</div>
					<div class="col-lg-6 col-md-12 text-right">
						<div class="social-icons">
							<a href="#"><i class="fa fa-facebook"></i></a>
							<a href="#"><i class="fa fa-twitter"></i></a>
							<a href="#"><i class="fa fa-dribbble"></i></a>
							<a href="#"><i class="fa fa-behance"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!--================ End footer Area =================-->
