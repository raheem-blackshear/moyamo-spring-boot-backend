<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<input type="hidden" id="noticeId" name="noticeId" value="">

<div class="modal-body" style="padding: 0;">
	<div class="card-body">
		<fieldset class="form-group" style="display: block;">
			<label class="text-bold-600" for="projectinput4">제목</label>
			<div class="col-md-12 col-sm-12">
				<input type="text" class="form-control" id="title" name="title" placeholder="">
			</div>
		</fieldset>
		<hr size="100%">
		<fieldset class="form-group">
			<label class="text-bold-600">내용</label>
			<div class="col-md-12 col-sm-12">
				<textarea rows="3" class="form-control autosize" id="text" name="text" placeholder="" style="display: none;"></textarea>
				<div id="summernote" class="summernote"></div>
			</div>
		</fieldset>
		
		<hr size="100%">
		<fieldset class="form-group" style="display: block;">
			<label class="text-bold-600" for="projectinput4">URL</label>
			<div class="col-md-12 col-sm-12">
				<input type="text" class="form-control" id="url" name="url" placeholder="">
			</div>
		</fieldset>
		
		<hr size="100%">
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
		
		<hr size="100%">
		<fieldset class="form-group" style="display: block;">
			<label class="text-bold-600" for="projectinput4">팝업으로 노출하기</label>
				<div class="col-md-12 col-sm-11">
					<div class="skin-states">
						<fieldset>
							<input type="checkbox" name="popup" id="popup" value="true">
							<label for="input-11"> 사용</label>
						</fieldset>
					</div>
				</div>
		</fieldset>

		<div id="popup_view" style="display: none; padding: 20px; border: 1px solid #eee;">
<!-- 					<hr size="100%"> -->
			<fieldset class="form-group" style="display: block;">
				<label class="text-bold-600" for="projectinput4">노출 주기 설정</label>
				<!-- <div class="col-md-12 col-sm-12">
					<input type="text" class="form-control" id="interval" name="interval" placeholder="">
				</div> -->
				<div class="col-md-12 col-sm-11">
					<div class="skin-states">
						<fieldset>
							<input type="radio" name="interval" value="1" checked="checked">
							<label for="input-11"> 하루마다 노출</label>
						</fieldset>
						<fieldset>
							<input type="radio" name="interval" value="3">
							<label for="input-12"> 3일마다 노출</label>
						</fieldset>
						<fieldset>
							<input type="radio" name="interval" value="7">
							<label for="input-13"> 7일마다 노출</label>
						</fieldset>
						<fieldset>
							<input type="radio" name="interval" value="30">
							<label for="input-14"> 30일마다 노출</label>
						</fieldset>
						<fieldset>
							<input type="radio" name="interval" value="0">
							<label for="input-15"> 반복 없음</label>
						</fieldset>
					</div>
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
								<select id="startTime" name="startTime" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
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
								<select id="startMinute" name="startMinute" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
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
								<select id="endTime" name="endTime" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
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
								<select id="endMinute" name="endMinute" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
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
							</label> 
						</div>
					</fieldset>
				</div>
			</fieldset>
			
			<hr size="100%">
			<fieldset class="form-group">
				<label class="text-bold-600">이미지로 공지 올리기 <span style="color:red; text-decoration: underline;">(*이미지로 공지를 올릴 경우 제목과 내용은 노출되지 않습니다.)</span></label>
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
</div>
