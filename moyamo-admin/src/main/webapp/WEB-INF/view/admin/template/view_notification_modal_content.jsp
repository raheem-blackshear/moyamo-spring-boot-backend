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
			<b id="modal_posting_name"> 알림 등록</b>
		</h3>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(true);">
			<span aria-hidden="true" style="color: white;">&times;</span>
		</button>
	</div>
	<form name="notification_form" id="notification_form" action="/rest/registNotification" method="post">
		<input type="hidden" name="notificationId" value="">
		<input type="hidden" name="postingId" value="">
		<input type="hidden" name="postingType" value="magazine">
		<div class="modal-body" style="padding: 0;">
			<div class="card-body">
		       	<label class="text-bold-600">예약 발송</label>
				<fieldset class="form-group" style="display: block;">
					<div class="col-md-12 col-sm-12">
						<fieldset>
                            <input type="checkbox" name="notiType" id="reserved" value="reserve">
			       			알림 예약
                        </fieldset>
					<!-- <div class="col-sm-0 text-left"> -->
						<fieldset id="reservedFieldset" style="display: none;">
							<div class="dataTables_length" id="postingtable_length">
								<label>
									<input type="text" class="input_notification" id="notificationDatepicker" name="notificationDatepicker">
								</label> 일
								&nbsp;&nbsp;
								<label>
									<select id="time" name="time" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
									</select>
								</label> 시
								&nbsp;&nbsp;
								<label>
									<!-- <p>
										<input type="text" class="input_notification" id="minute" name="minute">
									</p> -->
									<select id="minute" name="minute" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
										<option value="00">00</option>
										<option value="05">05</option>
										<option value="10">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option>
										<option value="30">30</option>
										<option value="35">35</option>
										<option value="40">40</option>
										<option value="45">45</option>
										<option value="50">50</option>
										<option value="55">55</option>
									</select>
								</label> 분 발송 예약
							</div>
						</fieldset>
					</div>
				</fieldset>

				<hr size="100%">
				<fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
					<div class="col-md-12 col-sm-12">
						<div class="row skin skin-flat">
                        	<label class="text-bold-600"> 대상 사용자 그룹</label>
	                        <div class="col-md-12 col-sm-11">
	                            <div class="skin-states">
	                             <fieldset>
	                                 <input type="radio" id="deviceGroup" name="deviceGroup" value="all" checked="checked">
	                                 <label for="input-11"> 전체</label>
	                             </fieldset>
	                             <fieldset>
	                                 <input type="radio" id="deviceGroup" name="deviceGroup" value="android">
	                                 <label for="input-12"> Android</label>
	                             </fieldset>
	                             <fieldset>
	                                 <input type="radio" id="deviceGroup" name="deviceGroup" value="ios">
	                                 <label for="input-13"> iOS</label>
	                             </fieldset>
									<fieldset>
										<input type="radio" id="deviceGroup" name="deviceGroup" value="none">
										<label for="input-13"> 발송안함</label>
									</fieldset>
	                            </div>
	                        </div>
                       	</div>
					</div>
				</fieldset>

				<hr size="100%">
				<fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
					<div class="col-md-12 col-sm-12">
						<div class="row skin skin-flat">
                        	<label class="text-bold-600"> 대상 사용자 그룹</label>
	                        <div class="col-md-12 col-sm-11">
	                            <div class="skin-states">
	                             <fieldset>
	                                 <input type="radio" name="expertGroup" value="all" checked="checked">
	                                 <label for="input-11"> 전체</label>
	                             </fieldset>
	                             <fieldset>
	                                 <input type="radio" name="expertGroup" value="name">
	                                 <label for="input-12"> 식물이름 전문가</label>
	                             </fieldset>
	                             <fieldset>
	                                 <input type="radio" name="expertGroup" value="clinic">
	                                 <label for="input-13"> 클리닉 전문가</label>
	                             </fieldset>
	                             <fieldset>
	                                 <input type="radio" name="expertGroup" value="contents">
	                                 <label for="input-14"> 컨텐츠 전문가</label>
	                             </fieldset>
	                            </div>
	                        </div>
                       	</div>
					</div>
				</fieldset>
				<hr size="100%">
				<fieldset class="form-group" style="display: block;">
					<label class="text-bold-600" for="projectinput4">제목</label>
					<div class="col-md-12 col-sm-12">
						<input type="text" class="form-control" id="title" name="title" placeholder="알림 제목을 입력해 주세요.">
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="text-bold-600">내용</label>
					<div class="col-md-12 col-sm-12">
						<textarea rows="3" class="form-control autosize" id="text" name="text" placeholder="알림 내용을 입력해 주세요."></textarea>
					</div>
				</fieldset>
				<fieldset class="form-group" id="link-form-group">
					<label class="text-bold-600">링크</label>
					<div class="col-md-12 col-sm-12">
						<input type="text" class="form-control" id="link" name="link" placeholder="알림을 클릭하면 이동할 주소를 넣어주세요.">
					</div>
				</fieldset>
				<fieldset class="form-group">
					<div class="col-md-12 col-sm-12">
						<div class="custom-file">
							<input type="file" accept="image/*" class="custom-file-input" name="files" />
							<label class="custom-file-label" aria-describedby="inputGroupFileAddon02">사진 선택</label>
							<input type="hidden" name="id">
						</div>
						<div class="view"></div>
					</div>
				</fieldset>
			</div>
		</div>
		<div class="modal-footer bg-blue-grey" style="height: 55px;">
			<button id="test_noti" class="btn btn-success" type="button">
				<i class="la la-save"></i> 알림 테스트
			</button>
			<button id="regist_noti" class="btn btn-secondary" type="button" disabled="disabled">
				<i class="la la-save"></i> 알림 등록
			</button>
			<button id="modify_noti" class="btn btn-secondary" type="button" disabled="disabled">
				<i class="la la-save"></i> 알림 수정
			</button>
			<button id="remove_noti" class="btn btn-secondary" type="button">
				<i class="la la-save"></i> 알림 삭제
			</button>
		</div>
	</form>
</div>
