<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!-- END: Custom CSS-->

<!-- BEGIN: Content-->
<div class="content-wrapper">
    <!-- Add Modal -->
    <!-- view Modal -->
    <div class="modal fade text-left" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-modal="true">
        <!-- <div class="modal fade text-left" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true"> -->
        <div class="modal-dialog modal-lg" role="document">
            <jsp:include page="template/view_bestGoods_modal_content.jsp"></jsp:include>
        </div>
    </div>

    <div class="modal fade text-left" id="regist_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-modal="true">
        <!-- <div class="modal fade text-left" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true"> -->
        <div class="modal-dialog modal-lg" role="document">
            <jsp:include page="template/write_bestGoods_modal_content.jsp"></jsp:include>
        </div>
    </div>



    <div class="content-body">
        <!-- 인기상품 -->
        <section id="configuration">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-content collpase show">
                            <div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
                                <div class="table-responsive">
                                    <p>인기상품 (모야모샵)</p>
                                    <table class="table table-hover table-striped table-bordered zero-configuration" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">
                                        <thead>
                                        <tr>
<%--                                            <th></th>--%>
                                            <th>아이디</th>
                                            <th>모야모샵 인기상품</th>
<%--                                            <th>닉네임</th>--%>
                                            <!-- <th>이미지</th> -->
                                            <th>시작일</th>
                                            <th>종료일</th>
<%--                                            <th>interval</th>--%>
                                            <th>상태</th>
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
        <!-- 매거진 관리 -->
    </div>
</div>
<!-- END: Content-->


<script type="text/javascript">
    var prevCommentId = 0;
    var noticeType = '${type}';

    $(document).ready(function(){
        /* 상단 타이틀 변경 */
        setMenuName('${menuName}');

        $('[data-toggle="tooltip"]').tooltip({
            html: true
        });

        var table = $('.zero-configuration').DataTable({
            dom:
                "<'row'<'col-sm-0 text-left'l> <'col-sm'><'col-sm-2'B>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-4'i><'col-sm-8'p>>",
            buttons: [
                {
                    text: "인기상품 등록",
                    className: 'btn btn-custom-info First',
                    action: function ( e, dt, node, config ) {
                        initInput();

                        $('#regist_modal b').text("인기상품 등록");
                        $('#regist_modal').modal("show");

                    }
                },
            ],
            language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
            'ajax' : {
                "url": "/rest/getBestGoods",
                "rankingType": "best_goods"
            },
            'serverSide' : true,
            "processing" : true,
            "drawCallback": function (oSettings, json) {
                $('[data-toggle="tooltip"]').tooltip();
            },
            "createdRow": function( row, data, dataIndex){
                $('td', row).eq(1).addClass('boldcolumn');
            },
            columns: [
                { data: "id", orderable: false },
                { data: "items",
                    render: function (items){
                        var goods = [];
                        for(var i=0;i<items.length;i++){
                            goods.push(items[i].goodsCd);
                        }
                        return goods.join();
                    },orderable: false},
                { data: "start",
                    render: function(data, type, row, meta){
                        return moment(data).format('YYYY-MM-DD HH:mm:ss');
                    },
                    orderable: false
                },
                { data: "end",
                    render: function(data, type, row, meta){
                        return moment(data).format('YYYY-MM-DD HH:mm:ss');
                    },
                    orderable: false
                },

                {data: "active",
                    render: function (active) {
                        if(active)
                            return "개시";
                        else
                            return "";
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

            if('boldcolumn' == $(this)[0].className.trim()){
                $('#detail_modal').modal('show');

                $('#detail_modal b').text("인기상품 수정/삭제");

                var dataSet = table.row( $(this).parent() ).data();

                detailView(dataSet);
            }
        });

    });

    /* 달력, 시간 2disit 맞추기 */
    function getDisit(target){
        return ("0" + target).slice(-2);
    }

    function init_notice(target){
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

    function detailSetDatepicker(data, form, targetPicker, targetTime, targetMinute){
        var start = new Date(moment(data).format('YYYY-MM-DD HH:mm:ss'));
        $(form + ' ' + targetPicker).datepicker().datepicker("option", "minDate", new Date(0));
        $(form + ' ' + targetPicker).datepicker().datepicker("setDate", start);

        var startHour = getDisit(start.getHours());
        var startMinute = getDisit(start.getMinutes());

        $(form + ' ' + targetTime).val(startHour);
        $(form + ' ' + targetMinute).val(startMinute);
    }

    function detailView(dataSet) {
        // console.log(dataSet);
        // console.log('detailView 부분 나옴' + $('#detail_form input[name=code]').length+", "+dataSet.items.length);
        for(var i=0;i<dataSet.items.length;i++){
            $('#detail_form input[name=code]').eq(i).val(dataSet.items[i].goodsCd);
        }
        for(var i=$('#detail_form input[name=code]').length;i>dataSet.items.length;i--){
            $('#detail_form input[name=code]').eq(i-1).val('');
        }


        //예약 발송 여부
        detailSetDatepicker(dataSet.start, '#detail_form', '#startDatepicker', '#startTime', '#startMinute');
        detailSetDatepicker(dataSet.end, '#detail_form', '#endDatepicker', '#endTime', '#endMinute');

        $('#bestGoodsId').val(dataSet.id);


        if(dataSet.active){
            $('#detail_modal form[name=detail_form] input:radio[name="status"]:input[value="open"]').prop("checked", true);
        }
        else{
            $('#detail_modal form[name=detail_form] input:radio[name="status"]:input[value="close"]').prop("checked", true);
        }
    }

    function initInput() {
        $('input[name="id"]').val('')
        $('input[name="writetitle"]').val('')
    }


    $('#detail_form #modify_noti').on('click', '', function () {
        if (confirm('수정 하시겠습니까?')) {
            event.preventDefault();

            var form = $('#detail_form')[0];
            var data = new FormData(form);

            var codeValue = $("#detail_form input[name='code']").length;
            var codesData = new Array(codeValue);
            for(var i=0; i<codeValue; i++) {
                codesData.push($("#detail_form input[name='code']")[i].value);
            }
            data.append("codes", codesData);

            var split_startDatepicker = data.get("startDatepicker").split("-");
            var startDate = new Date(split_startDatepicker[0], split_startDatepicker[1]-1, split_startDatepicker[2], data.get("startTime"), data.get("startMinute"));
            data.append("start", startDate.toUTCString());

            var split_endDatepicker = data.get("endDatepicker").split("-");
            var endDate = new Date(split_endDatepicker[0], split_endDatepicker[1]-1, split_endDatepicker[2], data.get("endTime"), data.get("endMinute"));
            data.append("end", endDate.toUTCString());

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/rest/bestGoods/modify/"+data.get('bestGoodsId'),
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

    $('#detail_form #remove_noti').on('click', '', function () {
        if (confirm('삭제 하시겠습니까?')) {
            event.preventDefault();

            var form = $('#detail_form')[0];
            var data = new FormData(form);
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/rest/bestGoods/remove/"+data.get('bestGoodsId'),
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

    $('#regist_form #regist_noti').on('click', '', function () {
        if (confirm('등록 하시겠습니까?')) {
            event.preventDefault();
            doRestApi('#regist_form');
            //
            // var titleValue = $("#regist_form input[name='title']").length;
            // var titleData = new Array(titleValue);
            // for(var i=0; i<titleValue; i++) {
            //     titleData.push($("#regist_form input[name='title']")[i].value);
            // }
            //
            // var form = $('#regist_form')[0];
            // var data = new FormData(form);
            //
            // var split_startDatepicker = data.get("writeStartDatepicker").split("-");
            // var startDate = new Date(split_startDatepicker[0], split_startDatepicker[1]-1, split_startDatepicker[2], data.get("startTime"), data.get("startMinute"));
            // data.append("start", startDate.toUTCString());
            // console.log(startDate);
            //
            // var split_endDatepicker = data.get("writeEndDatepicker").split("-");
            // var endDate = new Date(split_endDatepicker[0], split_endDatepicker[1]-1, split_endDatepicker[2], data.get("endTime"), data.get("endMinute"));
            // data.append("end", endDate.toUTCString());
            // console.log(endDate);
            //
            // var allData = {"titles": titleData, "startDate": startDate.toUTCString(), "endDate": endDate.toUTCString()};
            // console.log(allData);
            //
            // $.ajax({
            //     type: "POST",
            //     ContentType:"application/json",
            //     // enctype: 'multipart/form-data',
            //     dataType    :   "json",
            //     url: "/rest/bestGoods/regist",
            //     data: {
            //        // allData,
            //
            //         titles:titleData
            //     },
            //     processData: false,
            //     contentType: false,
            //     cache: false,
            //     timeout: 600000,
            //     success: function (data) {
            //         if(data.resultCode == 9000){
            //             alert("실패");
            //             return false;
            //         } else {
            //             console.log(data);
            //             $('.zero-configuration').DataTable().ajax.reload();
            //             $('.modal').modal('hide');
            //             //window.location.reload();
            //         }
            //     },
            //     error: function (e) {
            //         alert(e);
            //     }
            // });
            // $.ajax({
            //     type: "POST",
            //     enctype: 'multipart/form-data',
            //     url: "/rest/notice/regist/",
            //     data: data,
            //     processData: false,
            //     contentType: false,
            //     cache: false,
            //     timeout: 600000,
            //     success: function (data) {
            //         if(data.resultCode == 9000){
            //             alert("실패");
            //             return false;
            //         } else {
            //             console.log(data);
            //             $('.zero-configuration').DataTable().ajax.reload();
            //             $('.modal').modal('hide');
            //             //window.location.reload();
            //         }
            //     },
            //     error: function (e) {
            //         alert(e);
            //     }
            // });

        }
    });

</script>

