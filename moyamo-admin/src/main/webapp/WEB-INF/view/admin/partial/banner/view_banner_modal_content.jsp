<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/static/assets/css/datepicker.css">

<style type="text/css">
.input_notification{
    font-size: 13px;
    border: 1px solid #CACFE7;
    border-radius: 5px;
    height: 28px;
    text-align: center;
    vertical-align: middle;
    width: 100px;
}
</style>
<script src="/static/js/moyamo/template/modal/notification.js"></script>

<div class="modal-content">
	<div class="modal-header bg-blue-grey">
		<h3 class="modal-title white" style="font-size: 1.1rem;">
			<b id="modal_posting_name"> 배너 등록</b>
		</h3>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(true);">
			<span aria-hidden="true" style="color: white;">&times;</span>
		</button>
	</div>
	<form name="detail_form" id="detail_form" action="/rest/registBanner" method="post">
		<input type="hidden" id="bannerId" name="bannerId" value="">
		<div class="modal-body" style="padding: 0;">
			<div class="card-body">

				<fieldset class="form-group" style="display: block;">
					<label class="text-bold-600" for="projectinput4">제목</label>
					<div class="col-md-12 col-sm-12">
						<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해 주세요.">
					</div>
				</fieldset>


				<fieldset class="form-group">
					<label class="text-bold-600">컨텐츠</label>
					<div class="row" style="padding:0px 15px 20px 15px;">
						<div class="col-md-2 col-sm-2">
							<select style="height: 40.5px;"  class="custom-select custom-select-sm form-control form-control-sm" id="resourceType" name="resourceType">
								<option value="magazine">매거진</option>
								<option value="question">이름이뭐야</option>
								<option value="clinic">클리닉</option>
								<option value="free">자유수다</option>
								<option value="boast">자랑하기</option>
								<option value="shop">쇼핑몰</option>
								<option value="web">웹</option>
							</select>
						</div>

						<div class="col-md-2 col-sm-2">
							<select style="height: 40.5px;" class="custom-select custom-select-sm form-control form-control-sm" id="resourceSelector" name="resourceSelector">
								<option value="home">쇼핑몰 홈</option>
								<option value="goodsNo">상품 / 카테고리</option>
								<%--<option value="free">카트</option>
								<option value="coupon">쿠폰</option>
								<option value="wish">찜</option>
								<option value="review">리뷰</option>
								<option value="order">주문</option>
								<option value="cancel">취소내역</option>
								<option value="deposit">잔액</option>
								<option value="qa">문의내역</option>
								<option value="recommended">추천</option>
								<option value="refund">환불</option>
								<option value="shipping">배송정보</option>
								<option id="resource-id-input" value="">직접입력</option>--%>
							</select>
						</div>

						<div class="col-md-8 col-sm-8">
							<input type="text" class="form-control" id="resourceId" name="resourceId" placeholder="">
						</div>

					</div>
				</fieldset>

				<fieldset class="form-group">
					<label class="text-bold-600">이미지</label>
					<div class="col-md-12 col-sm-12">
						<div class="custom-file">
							<input type="file" accept="image/*" class="custom-file-input" name="file" />
							<label class="custom-file-label" aria-describedby="inputGroupFileAddon02">사진 선택</label>
							<input type="hidden" name="id">
						</div>
						<div class="view"></div>
					</div>
				</fieldset>

				<hr size="100%">
				<label class="text-bold-600">노출 시작시간</label>
				<fieldset class="form-group" style="display: block;">
					<div class="col-md-12 col-sm-12">
						<fieldset id="reservedFieldset">
							<div class="dataTables_length" id="postingtable_length">
								<label>
									<input type="text" class="input_notification" id="startDatepicker" name="startDatepicker">
								</label> 일
								&nbsp;&nbsp;
								<label>
									00시 00분
								</label>

							</div>
						</fieldset>
					</div>
				</fieldset>
				<label class="text-bold-600">노출 종료시간</label>
				<fieldset class="form-group" style="display: block;">
					<div class="col-md-12 col-sm-12">
						<fieldset id="reservedFieldset">
							<div class="dataTables_length" id="postingtable_length">
								<label>
									<input type="text" class="input_notification" id="endDatepicker" name="endDatepicker">
								</label> 일
								&nbsp;&nbsp;
								<label>
									23시 59분 59초
								</label>
								&nbsp;&nbsp;
							</div>
						</fieldset>
					</div>
				</fieldset>

				<fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
					<div class="col-md-12 col-sm-12">
						<div class="row skin skin-flat">
							<label class="text-bold-600"> 노출여부</label>
							<div class="col-md-12 col-sm-11">
								<div class="skin-states">
									<fieldset>
										<input type="radio" name="status" value="open" checked="checked">
										<label for="input-11"> 공개</label>
									</fieldset>
									<!-- <fieldset>
                                        <input type="radio" name="status" value="preview">
                                        <label for="input-12"> 대기</label>
                                    </fieldset> -->
									<fieldset>
										<input type="radio" name="status" value="close">
										<label for="input-13"> 숨김</label>
									</fieldset>
								</div>
							</div>
						</div>
					</div>
				</fieldset>
			</div>
		</div>
		<div class="modal-footer bg-blue-grey" style="height: 55px;">
			<%--<button id="test_noti" class="btn btn-success" type="button">
				<i class="la la-save"></i> 알림 테스트
			</button>--%>
			<button id="regist_noti" class="btn btn-secondary" type="button">
				<i class="la la-save"></i> 배너 등록
			</button>
			<button id="remove_noti" class="btn btn-secondary" type="button">
				<i class="la la-save"></i> 배너 삭제
			</button>
		</div>
	</form>
</div>


<script type="text/javascript">

	$(document).ready(function(){

		/* 달력, 초기화 */
		initBanner('#detail_form #startDatepicker');
		initBanner('#detail_form #endDatepicker');


		$(this).find('#detail_form input[name*=file]').change(function(e){
			var itemEl = getDisplayItem(window.URL.createObjectURL(this.files[0]), "img");
			$(this).parent().parent().find("#detail #bannerId").val("");
			$(this).parent().parent().find(".view:eq(0)").empty().prepend(itemEl);
			//window.URL.revokeObjectURL(itemEl);
			$(this).next('.custom-file-label').html(this.files[0].name);
		});
	});

</script>
