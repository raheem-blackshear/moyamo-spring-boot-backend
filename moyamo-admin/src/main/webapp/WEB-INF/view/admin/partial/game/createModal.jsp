
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020/08/20
  Time: 4:55 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal fade text-left" id="gamble_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="gamble_add_modal_dialog" style="">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b> 게임 등록</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  onclick="javascript:changeScroll(false);">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>
            <form name="gamble_add_form" id="gamble_add_form" action="/admin/registGamble" method="post" enctype="multipart/form-data">
                <div class="modal-body" style="padding: 0;">
                    <div class="card-body">
                        <fieldset class="form-group" id="gamble-title" style="display: block;">
                            <div class="row">
                                <div class="col-10">
                                    <label for="projectinput4">제목</label> <input type="text" class="form-control" id="title" name="title">
                                </div>
                                <div class="col-2">
                                    <label>활성화</label><input type="checkbox" class="form-control" name="active", value="true">
                                </div>
                            </div>
                        </fieldset>

                        <fieldset class="form-group" id="gamble-url" style="display: block;">
                            <label for="projectinput4">페이지URL</label> <input type="text" class="form-control" id="url" name="url">
                            <p>* 사용자를 식별하려면 'auth=true' url 파라미터를 추가합니다.</p>
                        </fieldset>

                        <fieldset class="form-group">
                            <div class="custom-file">
                                <input type="file" accept="image/*" class="custom-file-input" name="file" />
                                <label class="custom-file-label" aria-describedby="inputGroupFileAddon02">공유 사진 선택</label>
                                <input type="hidden" name="id">
                            </div>
                            <div class="view"></div>
                        </fieldset>

                        <fieldset class="form-group">
                            <div class="row">
                                <div class="col-6">
                                    <label>최대참여수</label><input type="number" class="form-control" placeholder="당첨수" name="maxAttempt" id="maxAttempt">
                                    <p>* 0 은 무제한</p>
                                </div>
                                <div class="col-6">
                                    <label>재시도(시간)</label><input type="number" class="form-control" placeholder="당첨수" name="retryHour" id="retryHour">
                                    <p>* 설정시간 후 재당첨가능</p>
                                </div>
                            </div>
                        </fieldset>

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

                        <br><br>
                        <hr size="3">
                        <fieldset class="form-group">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group item-repeater">
                                        <div data-repeater-list="repeater-list">
                                            <div data-repeater-item>
                                                <div class="row mb-1">
                                                    <div class="col-12 col-xl-12">
                                                        <fieldset class="form-group">
                                                            <label>상품명</label><input type="text" class="form-control" placeholder="상품명" name="name">
                                                        </fieldset>
                                                    </div>
                                                    <div class="col-12 col-xl-12">
                                                        <fieldset class="form-group">
                                                            <div class="row">
                                                                <%--<div class="col">
                                                                    <label for="maxAttempt">최대참여횟수</label>
                                                                    <select class="form-control" id="maxAttempt">
                                                                        <option value="0">무제한</option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                        <option value="4">4</option>
                                                                        <option value="5">5</option>
                                                                        <option value="6">6</option>
                                                                        <option value="7">7</option>
                                                                        <option value="8">8</option>
                                                                        <option value="9">9</option>
                                                                        <option value="10">10</option>
                                                                    </select>
                                                                </div>--%>
                                                                <div class="col-6">
                                                                    <label>당첨수</label><input type="number" class="form-control" placeholder="당첨수" name="amount">
                                                                </div>
                                                                <div class="col-2">
                                                                    <label>주소입력</label><input type="checkbox" class="form-control" name="address" value="true">
                                                                </div>
                                                                <div class="col-2">
                                                                    <label>꽝 여부</label><input type="checkbox" class="form-control" name="blank" value="true">
                                                                </div>
                                                                <div class="col-2">
                                                                    <label>삭제</label>
                                                                    <button type="button" style="float: right;" data-repeater-delete="" class="btn btn-icon btn-danger mr-1 delete_photo">
                                                                        <i class="ft-x"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                                <hr size="3" />
                                            </div>
                                        </div>
                                        <div class="col-12 col-xl-4" style="float: right; padding-left: 0px;">
                                            <button type="button" style="float: right;" data-repeater-create class="btn btn-primary add_photo">
                                                <i class="ft-plus"></i> 상품추가
                                            </button>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </fieldset>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="regist" class="btn btn-success" type="button">
                        <i class="la la-save"></i> 등록
                    </button>
                </div>
            </form>
            <form name="gamble_add_form" id="gamble_add_form_template" action="/admin/registGamble" method="post" enctype="multipart/form-data" style="display:none">
                <div class="modal-body" style="padding: 0;">
                    <div class="card-body">


                        <fieldset class="form-group">
                            <label>내용</label>
                            <textarea class="form-control autosize" name="text"></textarea>
                        </fieldset>

                        <fieldset class="form-group">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group file-repeater">
                                        <!-- <div data-repeater-list="repeater-list"> -->
                                        <div data-repeater-list="repeater-list">
                                            <div data-repeater-item>
                                                    <div class="row mb-1">
                                                        <div class="col-10 col-xl-11">
                                                            <div class="custom-file" style="height: 100%; width: 90%; margin-bottom: 15px;">
                                                                <input type="file" accept="image/*" class="custom-file-input" name="files" />
                                                                <label class="custom-file-label" aria-describedby="inputGroupFileAddon02">사진 선택</label>
                                                                <input type="hidden" name="id">
                                                                <div class="view"></div>
                                                            </div>
                                                        </div>
                                                        <div class="col-2 col-xl-1" style="float: right; padding-left: 0px;">
                                                            <button type="button" style="float: right;" data-repeater-delete="" class="btn btn-icon btn-danger mr-1">
                                                                <i class="ft-x"></i>
                                                            </button>
                                                        </div>
                                                        <div class="col-10 col-xl-11">
                                                            <fieldset class="form-group">
                                                                <textarea rows="2" class="form-control autosize" name="descriptions" placeholder="사진설명"></textarea>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                <hr size="3" />
                                            </div>
                                        </div>
                                        <div class="col-12 col-xl-4" style="float: right; padding-left: 0px;">
                                            <button type="button" style="float: right;" data-repeater-create class="btn btn-primary">
                                                <i class="ft-plus"></i> 사진추가
                                            </button>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </fieldset>

                        <fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
                            <label for="projectinput4">상품 등록</label> <input type="text" class="form-control" id="goodsNo" name="title">
                        </fieldset>
                    </div>
                </div>

                <div class="modal-footer">
                    <button id="regist" class="btn btn-success" type="button">
                        <i class="la la-save"></i> 등록
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="application/javascript">
    $(document).ready(function() {
        /* 달력, 초기화 */
        init_gamble('#gamble_add_form #startDatepicker');
        init_gamble('#gamble_add_form #endDatepicker');

    });
</script>



