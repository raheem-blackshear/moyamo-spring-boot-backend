<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/editors/summernote.css">
<link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/editors/codemirror.css">
<link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/editors/theme/monokai.css">
<link rel="stylesheet" type="text/css" href="/static/assets/css/datepicker.css">

<script src="/static/app-assets/vendors/js/editors/summernote/summernote.js"></script>
<script src="/static/app-assets/vendors/js/editors/codemirror/lib/codemirror.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/mode/xml/xml.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/2.36.0/formatting.js"></script>


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
<!-- <script src="/static/js/moyamo/template/modal/notification.js"></script> -->


<div class="modal-content">
    <div class="modal-header bg-blue-grey">
        <h3 class="modal-title white" style="font-size: 1.1rem;">
            <b id="modal_posting_name"> 인기상품 수정/삭제</b>
        </h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(true);">
            <span aria-hidden="true" style="color: white;">&times;</span>
        </button>
    </div>
    <form name="detail_form" id="detail_form" action="" method="post">


        <input type="hidden" id="bestGoodsId" name="bestGoodsId" value="">

        <div class="modal-body" style="padding: 0;">
            <div class="card-body">
                <fieldset class="form-group" style="display: block;">
                    <label class="text-bold-600" for="projectinput4">모야모샵</label>
                    <p>1위 상품코드</p>
                        <input type="text" class="form-control" id="code1" name="code" placeholder="">
                    <p>2위 상품코드</p>
                        <input type="text" class="form-control" id="code2" name="code" placeholder="">
                    <p>3위 상품코드</p>
                        <input type="text" class="form-control" id="code3" name="code" placeholder="">
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
                    <!--
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
                    </fieldset> -->
                </div>
            </div>
<%--        </div>--%>


        <div class="modal-footer bg-blue-grey" style="height: 55px;">
            <button id="modify_noti" class="btn btn-secondary" type="button">
                <i class="la la-save"></i> 수정
            </button>
            <button id="remove_noti" class="btn btn-secondary" type="button">
                <i class="la la-save"></i> 삭제
            </button>
        </div>
    </form>
</div>


<script type="text/javascript">

    $(document).ready(function(){

        console.log('view 부분 나옴');

        /* 달력, 초기화 */
        init_notice('#detail_form #startDatepicker');
        init_notice('#detail_form #endDatepicker');

        /* 사진 선택 버튼 클릭, 등록 된 이미지 view */
        // $(this).find('#detail_form input[name*=files]').change(function(e){
        //     var itemEl = getDisplayItem(window.URL.createObjectURL(this.files[0]), "img");
        //     $(this).parent().parent().find("#detail_form #modify_id").val("");
        //     $(this).parent().parent().find(".view:eq(0)").empty().prepend(itemEl);
        //     //window.URL.revokeObjectURL(itemEl);
        //     $(this).next('.custom-file-label').html(this.files[0].name);
        // });
        //
        // $(this).find('#detail_form input:checkbox[name=popup]').change(function(e){
        //     if($(this).is(":checked") == true) {
        //         $("#detail_form #popup_view").show();
        //     }else{
        //         $("#detail_form #popup_view").hide();
        //     }
        // });
        //
        // $('#detail_form #summernote').summernote({
        //     toolbar: [
        //         // [groupName, [list of button]]
        //         ['fontname', ['fontname']],
        //         ['fontsize', ['fontsize']],
        //         ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
        //         ['color', ['forecolor','color']],
        //         ['table', ['table']],
        //         ['para', ['ul', 'ol', 'paragraph']],
        //         ['height', ['height']],
        //         ['insert',['picture','link','video']],
        //         ['view', ['fullscreen', 'help']],
        //         ['misc', ['codeview']]
        //     ],
        //     fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
        //     fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
        //
        //     dialogsInBody: true,
        //     height: 580,
        //     //width: 870,
        //     focus: true,
        //     callbacks: {
        //         onImageUpload: function(files, editor, welEditable) {
        //             console.log('callback', files);
        //             for(let i=0; i < files.length; i++) {
        //                 sendFile(files[i],editor,welEditable);
        //             }
        //         }
        //     },
        //     codemirror: { // codemirror options
        //         theme: 'monokai'
        //     }
        // });
        //
        // var sendFile = function (file, editor, welEditable) {
        //     var form_data = new FormData();
        //     form_data.append('file', file);
        //     $.ajax({
        //         data: form_data,
        //         type: "POST",
        //         // url: '/rest/notice/summernote/file',
        //         cache: false,
        //         contentType: false,
        //         enctype: 'multipart/form-data',
        //         processData: false,
        //         async: false,
        //         success: function(data) {
        //             $('#detail_form #summernote').summernote('insertImage',data.url);
        //         },
        //         error: function(e){
        //             console.log(e);
        //         }
        //     });
        // }
    });

</script>
