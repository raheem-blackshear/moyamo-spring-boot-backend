<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.String" %>
<%@ page import="java.util.*" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<style>
    .select2-container--classic .select2-selection--multiple .select2-selection__choice, .select2-container--default .select2-selection--multiple .select2-selection__choice {
        background-color: #666EE8 !important;
    }
    .select2-container--classic .select2-selection--multiple, .select2-container--default .select2-selection--multiple {
        border: 1px solid #CACFE7 !important;
    }

    .href_eventName{
        cursor: pointer;
    }
    .arrow-red{
        color: #79c09b;
        font-weight: 600;
    }
    .custom_float_left{
        text-align: left;
        vertical-align: top;
    }

    .btn-custom-info:hover {
        border-color: #79c09b !important;
        background-color: #79c09b !important;
    }
    .btn-custom-info.First{
        border-top-right-radius: 2px !important;
        border-top-left-radius: 2px !important;
        border-bottom-right-radius: 2px !important;
        border-bottom-left-radius: 2px !important;
    }
    .btn-custom-info.Modify{
        width: 150px !important;
        border-top-right-radius: 2px !important;
        border-top-left-radius: 2px !important;
        border-bottom-right-radius: 2px !important;
        border-bottom-left-radius: 2px !important;
        margin-right:0px;
    }
    .btn-custom-info.Second{
        border-top-right-radius: 2px !important;
        border-top-left-radius: 2px !important;
        border-bottom-right-radius: 2px !important;
        border-bottom-left-radius: 2px !important;
    }

    .reg-btn{
        justify-content: flex-end;
        background-color: #79c09b;
        color: #FFFFFF !important;
        border-color: #79c09b;
        float:right;
    }
    .btn-secondary{
        float:right !important;
        background-color: #79c09b !important;
        color: #FFFFFF !important;
        width: 150px !important;
        border-color: #79c09b !important;
        border-radius: 0.25rem;
    }
    div.dataTables_wrapper div.dataTables_filter {
        text-align: left;
    }
    .dt-buttons{
        float:right !important;
        /* 		background-color: #f15149 !important; */
        color: #FFFFFF !important;
        width: 150px !important;
        height: 40px !important;
        border-color: #cc514b !important;
        border-radius: 0.25rem;
    }
    .boldcolumn{
        padding: 0;
        font-weight: bold;
        font-size: 13px;
        background-color: transparent;
        text-align: center;
    }
    .redhighlight{
        background-color: #79c09b !important;
        font-size: 15px;
        font-weight: 1000;
        cursor: move;
    }
    textarea.autosize { min-height: 50px; }
</style>


<script type="text/javascript">

    function init_gamble(target){
        $(target).datepicker({
            dateFormat: 'yy-mm-dd',
            prevText: '이전 달',

            nextText: '다음 달',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNames: ['일','월','화','수','목','금','토'],
            dayNamesShort: ['일','월','화','수','목','금','토'],

            dayNamesMin: ['일','월','화','수','목','금','토'],
            showMonthAfterYear: true,
            yearSuffix: '년',
        });
        $(target).datepicker().datepicker("setDate", new Date());
        $(target).datepicker().datepicker("option", "minDate", new Date());
    }

    var createRepeaterDiv;
    var modifyRepeaterDiv;
    $(document).ready(function(){
        /* 상단 타이틀 변경 */
        setMenuName('${menuName}');

        $(document).on('change', '.custom-file-input', function (event) {
            $(this).next('.custom-file-label').html(event.target.files[0].name);
        });

        var table = $('.zero-configuration').DataTable({
            dom:
                "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'><'col-sm-2'B>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-4'i><'col-sm-8'p>>",
            buttons: [
                {
                    text: '게임등록',
                    className: 'btn btn-custom-info First',
                    action: function ( e, dt, node, config ) {
                        addRepeaterDiv.setList([]);
                        $('#gamble_add_form .add_photo').click();
                        $('#gamble_add_form .custom-file-input').val('');
                        $('#gamble_add_form').find('.view img').remove();
                        $('#gamble_add_form .custom-file-label').html('공유 사진 선택');
                        $('#gamble_add_modal').modal("show");

                    }
                },
            ],
            language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
            'ajax' : {
                "url": '/rest/gamble/getGambleList'
            },
            'serverSide' : true,
            "processing" : true,
            //"order": [[ 0, "desc" ]],
            "drawCallback": function (oSettings, json) {
                $('[data-toggle="tooltip"]').tooltip();
            },
            "createdRow": function( row, data, dataIndex){
                $('td', row).eq(1).addClass('boldcolumn');
            },
            columns: [
                { data: "id", orderable: false },
                { data: "title", orderable: false},
                { data: "maxAttempt",
                    render: function(data, type, row, meta){
                        if(data == 0) {
                            return "제한없음";
                        } else {
                            return data;
                        }
                    }, orderable: false},
                { data: "retryHour",
                    render: function(data, type, row, meta){
                        if(data == 0) {
                            return "제한없음";
                        } else {
                            return data;
                        }
                    }, orderable: false},
                { data: "url",
                    render: function(data, type, row, meta){
                        if(data) {
                            console.log(row);
                            return data;
                        } else {
                            return "";
                        }
                    },
                    orderable: false
                },
                { data: "startDate",
                    render: function(data, type, row, meta){
                        return moment(data).tz('Asia/Seoul').format()//.format('YYYY-MM-DD HH:mm:ss');
                    },
                    orderable: false
                },
                { data: "endDate",
                    render: function(data, type, row, meta){
                        return moment(data).tz('Asia/Seoul').format()//.format('YYYY-MM-DD HH:mm:ss');
                    },
                    orderable: false
                },
                { data: "active",
                    render: function(data, type, row, meta){
                        console.log('data', data);
                        if(data == true) {
                            return "활성화";
                        } else {
                            return "비활성화";
                        }
                    },
                    orderable: false
                },
                { data: "id",
                    render: function(data, type, row, meta){
                        return '<button class="result btn btn-danger">조회</button>';
                    },
                    orderable: false
                }
            ]
        });

        //검색창 3글자 이내는 검색안되게 딜레이 600ms
        var searchWait = 0;
        var searchWaitInterval;
        $('.dataTables_filter input')
            .unbind() // leave empty here
            .bind('input', function(e){ //leave input
                var item = $(this);
                searchWait = 0;
                if(this.value.length >= 2 || e.keyCode == 13) {
                    if(!searchWaitInterval) searchWaitInterval = setInterval(function(){
                        if(searchWait >= 3){
                            clearInterval(searchWaitInterval);
                            searchWaitInterval = '';
                            searchTerm = $(item).val();
                            table.search(searchTerm).draw(); // change to new api
                            searchWait = 0;
                        }
                        searchWait++;
                    },200);
                }
                if(this.value == "") {
                    table.search("").draw();
                }
            });

        //** Row 클릭 **//
        $('.zero-configuration tbody').on('click', 'td', function () {

            if($(this).has("button.result").length > 0) {
                console.log("has result");
                return;
            }

            modifyRepeaterDiv.setList([]); // repeater 초기화
            $('#gamble_modify_modal').modal('show');
            var dataSet = table.row( $(this).parent() ).data();
            detailView(dataSet);
            /*if('boldcolumn' == $(this)[0].className.trim()){

            }*/
        });

        //** Row 클릭 **//
        $('.zero-configuration tbody').on('click', '.result', function () {
            //$('#gamble_result_modal').modal('show');
            var dataSet = table.row( $(this).parent().parent() ).data();
            console.log('result', dataSet);
            viewResult(dataSet.id);
            //detailView(dataSet);
            /*if('boldcolumn' == $(this)[0].className.trim()){

            }*/
        });


        /* 달력, 시간 2disit 맞추기 */
        function getDisit(target){
            return ("0" + target).slice(-2);
        }

        function detailSetDatepicker(data, form, targetPicker, targetTime, targetMinute){
            var start = new Date(moment(data).format('YYYY-MM-DD HH:mm:ss'));

            console.log('picker : ' + form + ' ' + targetPicker);
            $(form + ' ' + targetPicker).datepicker().datepicker("option", "minDate", new Date(0));
            $(form + ' ' + targetPicker).datepicker().datepicker("setDate", start);

            var startHour = getDisit(start.getHours());
            var startMinute = getDisit(start.getMinutes());

            $(form + ' ' + targetTime).val(startHour);
            $(form + ' ' + targetMinute).val(startMinute);
        }

        $("input:file.custom-file-input").change(function (){
            console.log(this, $(this).parent().parent(), $(this).parent().parent().find('.view img'));
            console.log('preview');

            var img = $('<img/>', {
                id: 'dynamic',
                style: 'margin-top: 10px;width:100%'
            });
            var file = this.files[0];
            var reader = new FileReader();
            // Set preview image into the popover data-content
            var input = $(this);

            reader.onload = function (e) {
                img.attr('src', e.target.result);
                input.parent().parent().find('.view img').remove();
                input.parent().parent().find('.view').append(img);
            }
            reader.readAsDataURL(file);
        });

        /* aws s3에서 가져오는 데이터 element 생성 */
        function getS3Data(data, setting, style){
            var httpName = '${httpName}';
            var itemEl = '<img style="'+style+'" src="'+httpName+data+setting+'" alt="">';
            return itemEl;
        }

        function detailView(dataSet) {
            console.log(dataSet);



            detailSetDatepicker(dataSet.startDate, '#gamble_modify_form', '#startDatepicker', '#startTime', '#startMinute');
            detailSetDatepicker(dataSet.endDate, '#gamble_modify_form', '#endDatepicker', '#endTime', '#endMinute');

            $('#gamble_modify_form #gambleId').val(dataSet.id);
            $('#gamble_modify_form #url').val(dataSet.url);
            $('#gamble_modify_form #interval').val(dataSet.interval);
            $('#gamble_modify_form #maxAttempt').val(dataSet.maxAttempt);
            $('#gamble_modify_form #retryHour').val(dataSet.retryHour);
            $("#gamble_modify_form input[name='active']").prop('checked', dataSet.active)
            //$('#visibility').val(dataSet.visibility).trigger('change');
            //$('#tagType').val(dataSet.tagType).trigger('change');

            //알림 정보
            $('#gamble_modify_form #title').val(dataSet.title);
            $('#gamble_modify_form #text').val(dataSet.description);

            //썸네일
            if(dataSet.resource){
                $('#gamble_modify_form .custom-file-input').val('');
                $('#gamble_modify_form .custom-file-label').html(dataSet.resource.filename);

                var setting = '';
                var style = 'width: 100%;margin-top: 10px;';
                var imgSrc = getS3Data(dataSet.photoUrl, setting, style);
                $("#gamble_modify_form input[name='file']").parent().parent().find(".view:eq(0)").empty().prepend(imgSrc);
            }

            console.log(dataSet.items);
            for(var i = 0; i < dataSet.items.length; i++){
                if(i < dataSet.items.length)
                    $('.add_photo').click();

                $("#gamble_modify_modal form[name=gamble_modify_form] input[name='repeater-list["+i+"][id]'").val(dataSet.items[i].id);
                $("#gamble_modify_modal form[name=gamble_modify_form] input[name='repeater-list["+i+"][name]'").val(dataSet.items[i].name);
                $("#gamble_modify_modal form[name=gamble_modify_form] input[name='repeater-list["+i+"][amount]'").val(dataSet.items[i].amount);
                $("#gamble_modify_modal form[name=gamble_modify_form] input[name='repeater-list["+i+"][address][]'").prop('checked', dataSet.items[i].address)
                $("#gamble_modify_modal form[name=gamble_modify_form] input[name='repeater-list["+i+"][blank][]'").prop('checked', dataSet.items[i].blank)
            }

            $('#gamble_modify_modal').modal('handleUpdate');

        }


        addRepeaterDiv = $('#gamble_add_modal .item-repeater').repeater({
            show: function () {
                /*var count = $(this).parent()[0].childElementCount;
                if(10 < count){
                    $(this).remove();
                    return;
                }*/
                //alert('add');
                $(this).slideDown();
                //$(this).find('input[name*=files]').off("change").on("change", btnFileAction);
            },
            hide: function(remove) {
                $(this).slideUp(remove);
            },

            ready: function(remove) {
                //initSelectMulti();
                $("form[name=gamble_add_form] input[name='repeater-list[0][files]']").off("change").on("change", btnFileAction);
            }
        });

        modifyRepeaterDiv = $('#gamble_modify_modal .item-repeater').repeater({
            show: function () {
                /*var count = $(this).parent()[0].childElementCount;
                if(10 < count){
                    $(this).remove();
                    return;
                }*/
                //alert('add');
                $(this).slideDown();
                //$(this).find('input[name*=files]').off("change").on("change", btnFileAction);
            },
            hide: function(remove) {
                $(this).slideUp(remove);
            },

            ready: function(remove) {
                //initSelectMulti();
                $("form[name=gamble_modify_form] input[name='repeater-list[0][files]']").off("change").on("change", btnFileAction);
            }
        });

    });

    function btnFileAction(e){
        //파일 선택후 element 만들기
        /*var itemEl = getDisplayItem(URL.createObjectURL(this.files[0]), "img");
        $(this).parent().find("#modify_id").val("");
        $(this).parent().find(".view:eq(0)").empty().prepend(itemEl);*/
    }

    $('#gamble_modify_form #modify').on('click', '', function () {
        if (confirm('수정 하시겠습니까?')) {
            event.preventDefault();
            var form = $('#gamble_modify_form')[0];
            var data = new FormData(form);


            var split_startDatepicker = data.get("startDatepicker").split("-");
            var startDate = new Date(split_startDatepicker[0], split_startDatepicker[1]-1, split_startDatepicker[2], data.get("startTime"), data.get("startMinute"));
            data.append("start", startDate.toUTCString());

            var split_endDatepicker = data.get("endDatepicker").split("-");
            var endDate = new Date(split_endDatepicker[0], split_endDatepicker[1]-1, split_endDatepicker[2], data.get("endTime"), data.get("endMinute"));
            data.append("end", endDate.toUTCString());


            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/rest/gamble/"+data.get('gambleId'),
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    if(data.resultCode == 9000){
                        alert("실패");
                        return false;
                    } else {
                        console.log(data);
                        $('.zero-configuration').DataTable().ajax.reload(null, false);
                        $('.modal').modal('hide');
                        //window.location.reload();
                    }
                },
                error: function (e) {
                    alert(e);
                }
            });

        }
    });

    $('#gamble_add_form #regist').on('click', '', function () {
        if (confirm('등록 하시겠습니까?')) {
            event.preventDefault();
            var form = $('#gamble_add_form')[0];
            var data = new FormData(form);

            var split_startDatepicker = data.get("startDatepicker").split("-");
            var startDate = new Date(split_startDatepicker[0], split_startDatepicker[1]-1, split_startDatepicker[2], data.get("startTime"), data.get("startMinute"));
            data.append("start", startDate.toUTCString());

            var split_endDatepicker = data.get("endDatepicker").split("-");
            var endDate = new Date(split_endDatepicker[0], split_endDatepicker[1]-1, split_endDatepicker[2], data.get("endTime"), data.get("endMinute"));
            data.append("end", endDate.toUTCString());

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/rest/gamble",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    if(data.resultCode == 9000){
                        alert("실패");
                        return false;
                    } else {
                        console.log(data);
                        $('.zero-configuration').DataTable().ajax.reload(null, false);
                        $('.modal').modal('hide');
                        //window.location.reload();
                    }
                },
                error: function (e) {
                    alert(e);
                }
            });

        }
    });


    function viewResult(gambleId, itemId, version) {
        const url = new URL(location.protocol + "//" + location.host + "/admin/gamble/result");
        url.searchParams.append("gambleId", gambleId);
        if(itemId)
            url.searchParams.append("itemId", itemId);

        if(version)
            url.searchParams.append("version", version);

        window.open(url.href, "a", "width=800, height=600, left=100, top=50");
    }

</script>



<!-- BEGIN: Content-->
<div class="content-wrapper">
    <!-- Add Modal -->
    <!-- view Modal -->

    <jsp:include page="partial/game/modifyModal.jsp"></jsp:include>
    <jsp:include page="partial/game/createModal.jsp"></jsp:include>
    <jsp:include page="partial/game/resultModal.jsp"></jsp:include>

    <div class="content-body">
        <!-- 게임관리 -->
        <section id="configuration">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-content collpase show">
                            <div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped table-bordered zero-configuration" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">
                                        <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>제목</th>
                                            <th>최대참여수</th>
                                            <th>재참여(시간)</th>
                                            <th>url</th>
                                            <th>노출시작시간</th>
                                            <th>노출종료시간</th>
                                            <th>상태</th>
                                            <th>결과조회</th>
                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- 게임 관리 -->
    </div>
</div>


