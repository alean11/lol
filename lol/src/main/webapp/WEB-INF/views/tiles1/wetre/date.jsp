<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div data-stid="section-hotel-search">
	<div class="uitk-grid all-y-gutter-three all-y-padding-three"
		id="exposed-search-form"></div>
	<form
		class="uitk-grid all-b-padding-two all-x-gutter-two all-y-gutter-two"
		action="/대명리조트-변산.h5700107.Hotel-Information" method="GET"
		novalidate="">
		<div class="uitk-cell s-cell-1-2 m-cell-1-2 l-cell-1-4 xl-cell-1-4">
			<div class="uitk-field has-floatedLabel-label has-icon">
				<input type="text" data-stid="input-date" id="hotels-check-in"
					name="startDate" placeholder="날짜 선택" value="2019-07-16"
					class="uitk-field-input is-hidden" aria-label="체크인" pattern="^$">
				<button data-stid="open-date-picker" id="hotels-check-in__btn"
					type="button" class="uitk-faux-input">
					<span class="is-visually-hidden" data-stid="date-field-label">체크인
						2019년 7월 16일</span><span aria-hidden="true"
						data-stid="hotels-check-in__dateLabel">7월 16일</span>
				</button>
				<label for="hotels-check-in" class="uitk-field-label"><span>체크인</span><span
					class="is-visually-hidden">날짜 선택</span></label><span
					class="uitk-icon uitk-field-icon uitk-icon-medium"><svg
						aria-hidden="true" height="100%" viewBox="0 0 24 24" width="100%"
						xmlns="http://www.w3.org/2000/svg"
						xmlns:xlink="http://www.w3.org/1999/xlink">
						<svg>
							<path
								d="M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z"></path></svg></svg></span>
			</div>
		</div>
		<div class="uitk-cell s-cell-1-2 m-cell-1-2 l-cell-1-4 xl-cell-1-4">
			<div class="uitk-field has-floatedLabel-label has-icon">
				<input type="text" data-stid="input-date" id="hotels-check-out"
					name="endDate" placeholder="날짜 선택" value="2019-07-18"
					class="uitk-field-input is-hidden" aria-label="체크아웃" pattern="^$">
				<button data-stid="open-date-picker" id="hotels-check-out__btn"
					type="button" class="uitk-faux-input">
					<span class="is-visually-hidden" data-stid="date-field-label">체크아웃
						2019년 7월 18일</span><span aria-hidden="true"
						data-stid="hotels-check-out__dateLabel">7월 18일</span>
				</button>
				<label for="hotels-check-out" class="uitk-field-label"><span>체크아웃</span><span
					class="is-visually-hidden">날짜 선택</span></label><span
					class="uitk-icon uitk-field-icon uitk-icon-medium"><svg
						aria-hidden="true" height="100%" viewBox="0 0 24 24" width="100%"
						xmlns="http://www.w3.org/2000/svg"
						xmlns:xlink="http://www.w3.org/1999/xlink">
						<svg>
							<path
								d="M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z"></path></svg></svg></span>
			</div>
		</div>
		<div class="uitk-cell s-cell-1-1 m-cell-3-4 l-cell-1-3 xl-cell-1-3">
			<div
				class="uitk-field has-floatedLabel-label has-icon has-no-placeholder">
				<input type="text" value="객실 1개, 2명" data-stid="input-date"
					class="uitk-field-input is-hidden" aria-label="[object Object]"
					pattern="^$">
				<button id="undefined__btn" type="button"
					data-stid="open-room-picker" class="uitk-faux-input">
					<span class="is-visually-hidden">숙박 인원 </span>객실 1개, 2명
				</button>
				<label class="uitk-field-label"><span>숙박 인원<span
						class="is-visually-hidden">객실 1개, 2명</span></span></label><span
					class="uitk-icon uitk-field-icon uitk-icon-medium"><svg
						aria-hidden="true" height="100%" viewBox="0 0 24 24" width="100%"
						xmlns="http://www.w3.org/2000/svg"
						xmlns:xlink="http://www.w3.org/1999/xlink">
						<svg>
							<path
								d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"></path></svg></svg></span>
			</div>
			<input type="hidden" name="adults" readonly="" value="2">
		</div>
		<input type="hidden" name="accessibility" value="" disabled=""><input
			type="hidden" name="amenities" value="" disabled=""><input
			type="hidden" name="daysInFuture" value="" disabled=""><input
			type="hidden" name="destination"
			value="Buan, North Jeolla, South Korea"><input type="hidden"
			name="group" value="" disabled=""><input type="hidden"
			name="guestRating" value="" disabled=""><input type="hidden"
			name="hotelName" value="" disabled=""><input type="hidden"
			name="latLong" value="" disabled=""><input type="hidden"
			name="lodging" value="" disabled=""><input type="hidden"
			name="paymentType" value="" disabled=""><input type="hidden"
			name="poi" value="" disabled=""><input type="hidden"
			name="price" value="" disabled=""><input type="hidden"
			name="selected" value="5700107"><input type="hidden"
			name="sort" value="recommended"><input type="hidden"
			name="star" value="" disabled=""><input type="hidden"
			name="stayLength" value="" disabled=""><input type="hidden"
			name="theme" value="" disabled=""><input type="hidden"
			name="travelerType" value="" disabled=""><input type="hidden"
			name="useRewards" value="true"><input type="hidden"
			name="userIntent" value="" disabled=""><input type="hidden"
			name="GCLID"
			value="EAIaIQobChMIn5HppOS14wIVgbaWCh06nwBNEAAYAiAAEgI82_D_BwE"><input
			type="hidden" name="SEMCID" value="KR.UB.GOOGLE.PT-c-KO.HOTEL"><input
			type="hidden" name="SEMDTL"
			value="a1366986233.b124371786593.r17c21f5f8e3572f8708543bd1fd30f15769c51e3ed5ee14bddcfb6ffc965c1b8a.g1kwd-27553303843.i1.d1216190416148.e1c.j11009871.k1.f11t2.n1.l1g.h1e.m1"><input
			type="hidden" name="hasClusterProp" value="false"><input
			type="hidden" name="pwa_ts" value="1563154509825"><input
			type="hidden" name="swpToggleOn" value="true"><input
			type="hidden" name="localDateFormat" value="" disabled=""><input
			type="hidden" name="semdtl" value="" disabled="">
		<div class="uitk-cell all-cell-fill">
			<button type="submit" data-stid="submit-hotel-search"
				class="uitk-button uitk-button-large uitk-button-fullWidth uitk-button-primary">
				<span class="uitk-button-container">검색</span>
			</button>
		</div>
	</form>
</div>