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
<!-- Content -->

<!-- BEGIN: Content-->
<div class="content-wrapper">
    <!-- Add Modal -->
    <!-- alarm Modal -->
    <div class="modal animated pulse text-left show" id="notification_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true" style="z-index:10000;">
        <div class="modal-dialog" id="notification_modal_content" role="document">
            <jsp:include page="template/view_notification_modal_content.jsp"></jsp:include>
        </div>
    </div>
    <%--
    <div class="modal animated pulse text-left show" id="write_notification_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true" style="z-index:10000;">
        <div class="modal-dialog" id="write_notification_modal_content" role="document">
            <jsp:include page="template/write_notification_modal_content.jsp"></jsp:include>
        </div>
    </div> --%>

    <div class="content-body">
        <!-- 매거진 -->
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
                                            <th>카테고리</th>
                                            <th>썸네일</th>
                                            <th>컨텐츠 제목</th>
                                            <!--                                                         <th>컨텐츠 내용</th> -->
                                            <th>닉네임</th>
                                            <th>알림 작성일</th>
                                            <th>알림 대상</th>
                                            <th>알림 예약시간</th>
                                            <th>알림 발송시간</th>
                                            <th>알림 제목</th>
                                            <th>알림 내용</th>
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

    $(document).on('change', '.custom-file-input', function (event) {
        $(this).next('.custom-file-label').html(event.target.files[0].name);
    })

    $(document).ready(function(){
        setMenuName('${menuName}');

        $('[data-toggle="tooltip"]').tooltip({
            html: true
        });

        var table = $('.zero-configuration').DataTable({
            dom:
                "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'><'col-sm-2'B>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-4'i><'col-sm-8'p>>",
            buttons: [
                {
                    text: '알림 등록',
                    className: 'btn btn-custom-info First',
                    action: function ( e, dt, node, config ) {
                        $('#notification_modal').modal("show");
                        $('#test_noti').show();
                        $('#regist_noti').show();
                        $('#modify_noti').hide();
                        $('#remove_noti').hide();
                        $('#modal_posting_name').text(' 알림 등록');

                        $('#notification_modal form[name=notification_form] input:checkbox[name="notiType"]').prop('disabled', false);
                        $('#notification_modal form[name=notification_form] input:radio[name="deviceGroup"]').prop('disabled', false);
                        $('#notification_modal form[name=notification_form] input:radio[name="expertGroup"]').prop('disabled', false);
                        $('#notification_modal form[name=notification_form] input:file[name="files"]').prop('disabled', false);
                        $('#notification_form #notificationDatepicker').prop('disabled', false);
                        $('#notification_form #time').prop('disabled', false);
                        $('#notification_form #minute').prop('disabled', false);
                        $('#title').prop('disabled', false);
                        $('#text').prop('disabled', false);
                        $('#link').prop('disabled', false);
                        notificationInit();
                    }
                },
            ],
            language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
            'ajax' : {
                "url":'/rest/notification/getList'
            },
            'serverSide' : true,
            "processing" : true,
            //"order": [[ 0, "desc" ]],
            "drawCallback": function (oSettings, json) {
                $('[data-toggle="tooltip"]').tooltip();
            },
            "createdRow": function( row, data, dataIndex){
                $('td', row).eq(3).addClass('boldcolumn');
            },
            columns:
                [
                    { data: "id", orderable: true },
                    { data: "posting",
                        render: function(data, type, row, meta){
                            if(data) {
                                return data.postingType;
                            } else {
                                return 'web';
                            }
                        },
                        orderable: false
                    },
                    { data: "posting",
                        render: function(data, type, row, meta){
                            if(row.photoUrl) {
                                var setting = '?d=50x50';
                                var style = 'width: 50px;height: 50px;padding: 0rem;';
                                var itemEl = getImgSrc(row.photoUrl, setting, style);
                                return itemEl;
                            } else if(data && data.orgAttachments && data.orgAttachments.length > 0) {
                                var setting = '?d=50x50';
                                var style = 'width: 50px;height: 50px;padding: 0rem;';
                                var itemEl = getImgSrc(data.orgAttachments[0].photoUrl, setting, style);
                                return itemEl;
                            } else {
                                return '-';
                            }
                        },
                        orderable: false
                    },
                    { data: "posting",
                        render: function(data, type, row, meta){
                            if(data) {
                                return data.title;
                            } else {
                                return '<a href="' + row.link+'" target="_blank">링크</a>';
                            }
                        },
                        orderable: false
                    },
                    /* { data: "relation",
                        render: function(data, type, row, meta){
                            return data.posting.orgText;
                        },
                        orderable: false
                    }, */
                    { data: "owner",
                        render: function(data, type, row, meta){
                            return data.nickname;
                        },
                        orderable: false
                    },
                    { data: "createdAt" ,
                        render: function(data, type, row, meta){
                            return moment(data).format('YYYY-MM-DD HH:mm:ss')
                        },
                        searchable: false
                    },
                    { data: "targetGroup",
                        render: function (data, type, row, meta) {
                            var result = '';
                            if (data != undefined || data!= 'undefined') {
                                result = Moyamo.expertGroup.view(data);
                            }
                            return result;
                        },
                        orderable: false},
                    { data: "reservedTime" ,
                        render: function(data, type, row, meta){
                            return moment(data).format('YYYY-MM-DD HH:mm:ss')
                        },
                        searchable: false
                    },
                    { data: "sendTime" ,
                        render: function(data, type, row, meta){
                            if(data) {
                                return moment(data).format('YYYY-MM-DD HH:mm:ss');
                            } else {
                                return '-';
                            }
                        },
                        searchable: false
                    },
                    { data: "title", orderable: false },
                    { data: "text", orderable: false }
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
                $('#notification_modal').modal('show');
                var dataSet = table.row( $(this).parent() ).data();
                console.log(dataSet);
                $('#test_noti').show();
                $('#regist_noti').hide();
                $('#modify_noti').show();
                $('#remove_noti').show();

                detailView(dataSet);
            }
        });

        $('#regist_noti').on('click', function(e){
            var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
            resitNotification(postingId);
        });

    });

    $('#test_noti').on('click', function(e){
        var postingId =$('#notification_modal form[name=notification_form] input[name=postingId]').val();
        sendTestNotification(postingId);
    });

    $('#modify_noti').on('click', function(e){
        var postingId =$('#notification_modal form[name=notification_form] input[name=postingId]').val();
        var notificationId =$('#notification_modal form[name=notification_form] input[name=notificationId]').val();
        modifyNotification(notificationId, postingId);
    });

    $('#remove_noti').on('click', function(e){
        var postingId =$('#notification_modal form[name=notification_form] input[name=postingId]').val();
        var notificationId =$('#notification_modal form[name=notification_form] input[name=notificationId]').val();
        removeNotification(notificationId, postingId);
    });


    function detailView(dataSet) {
        console.log('detail view', JSON.stringify(dataSet));
        $('#notification_modal form[name=notification_form] input[name=notificationId]').empty().val(dataSet.id);
        var postingElem = $('#notification_modal form[name=notification_form] input[name=postingId]');
        var postingTypeElem = $('#notification_modal form[name=notification_form] input[name=postingType]');
        postingElem.empty();
        postingTypeElem.empty();

        if(dataSet.posting) {
            postingElem.val(dataSet.posting.id);
            postingTypeElem.val(dataSet.posting.postingType);

            //타이틀
            $('#modal_posting_name').text(dataSet.id + ". " + dataSet.posting.title);
            $('#link').hide();

        } else {
            $('#modal_posting_name').text('');
            $('#link').show();
        }
        $('#test_noti').show();
        //TODO : 이거 주석 풀기
        $('#modify_noti').show().prop('disabled', true);
        //TODO : 이거 주석 하기
        //$('#modify_noti').show().prop('disabled', false);

        $('#remove_noti').show();

        if(dataSet.sendTime){
            $('#modify_noti').hide();
            $('#remove_noti').hide();

            $('#notification_modal form[name=notification_form] input:checkbox[name="notiType"]').prop('disabled', true);
            $('#notification_modal form[name=notification_form] input:radio[name="deviceGroup"]').prop('disabled', true);
            $('#notification_modal form[name=notification_form] input:radio[name="expertGroup"]').prop('disabled', true);
            $('#notification_modal form[name=notification_form] input:file[name="files"]').prop('disabled', true);
            $('#notification_form #notificationDatepicker').prop('disabled', true);
            $('#notification_form #time').prop('disabled', true);
            $('#notification_form #minute').prop('disabled', true);
            $('#title').prop('disabled', true);
            $('#text').prop('disabled', true);
            $('#link').prop('disabled', true);
        }else{
            $('#notification_modal form[name=notification_form] input:checkbox[name="notiType"]').prop('disabled', false);
            $('#notification_modal form[name=notification_form] input:radio[name="deviceGroup"]').prop('disabled', false);
            $('#notification_modal form[name=notification_form] input:radio[name="expertGroup"]').prop('disabled', false);
            $('#notification_modal form[name=notification_form] input:file[name="files"]').prop('disabled', false);
            $('#notification_form #notificationDatepicker').prop('disabled', false);
            $('#notification_form #time').prop('disabled', false);
            $('#notification_form #minute').prop('disabled', false);
            $('#title').prop('disabled', false);
            $('#text').prop('disabled', false);
            $('#link').prop('disabled', false);
        }


        //$('#remove_noti').hide();

        //예약 발송 여부
        var reservedTime = moment(dataSet.reservedTime).format('YYYY-MM-DD HH:mm:ss');
        reservedTime = new Date(reservedTime);

        $('#notification_form #reserved').prop('checked', dataSet.reserved);

        if(dataSet.reserved){
            $('#notificationDatepicker').datepicker().datepicker("option", "minDate", new Date(0));

            $('#notificationDatepicker').datepicker().datepicker("setDate", reservedTime);

            /* 알림 등록 시간, 현재 시간으로 설정 */
            var reservedHour = getDisit(reservedTime.getHours());
            $('#notification_form #time').val(reservedHour);
            var reservedMinute = getDisit(reservedTime.getMinutes());
            $('#notification_form #minute').val(reservedMinute);


            $('#notification_modal form[name=notification_form] input:checkbox[name="notiType"]').attr('checked', true);
            $('#reservedFieldset').show();
        }else{
            $('#notification_modal form[name=notification_form] input:checkbox[name="notiType"]').attr('checked', false);
            $('#reservedFieldset').hide();
        }

        $('#notification_modal form[name=notification_form] input:radio[name="deviceGroup"]').each(function() {
            if(this.value == dataSet.deviceGroup){ //값 비교
                this.checked = true; //checked 처리
                return false;
            }
        });
        //대상 사용자 그룹
        $('#notification_modal form[name=notification_form] input:radio[name="expertGroup"]').each(function() {
            if(this.value == dataSet.targetGroup){ //값 비교
                this.checked = true; //checked 처리
                return false;
            }
        });

        //??
        $('#id').val(dataSet.id);
        $('#name').val(dataSet.name);
        $('#url').val(dataSet.url);
        $('#visibility').val(dataSet.visibility).trigger('change');
        $('#tagType').val(dataSet.tagType).trigger('change');

        //알림 정보
        $('#title').val(dataSet.title);
        $('#text').val(dataSet.text);
        $('#link').val(dataSet.link);



        //썸네일
        if(dataSet.thumbnail){
            $('.custom-file-label').html(dataSet.thumbnail.filename);

            var setting = '';
            var style = 'width: 100%;margin-top: 10px;';
            var imgSrc = getS3Data(dataSet.photoUrl, setting, style);
            $("#notification_modal form[name=notification_form] input[name='files'").parent().parent().find(".view:eq(0)").empty().prepend(imgSrc);

        }

    }

    function initInput() {
        $('#id').val("");
        $('#name').val("");
        $('#url').val("");
        $('#link').val("");
        $('#visibility').val("visible").trigger('change');
        $('#tagType').val("none").trigger('change');
    }

    function saveComment() {

        event.preventDefault();
        var form = $('#posting_detail_form')[0];
        var data = new FormData(form);
        //$("#btnSubmit").prop("disabled", true);
        var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/"+postingId+"/createComments",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                setTimeout(function(){
                    getComments(postingId, 0)
                }, 500);
            },
            error: function (e) {

                alert(e);
            }
        });
    }

    function getProfileImage(url, defaultImg) {
        if(url == "" || url == null || (typeof(url) == 'undefined')){
            profileImage = '/static/img/'+defaultImg;
        }else{
            profileImage = url;
        }
        return 	profileImage;
    }


    /* aws s3에서 가져오는 데이터 element 생성 */
    function getS3Data(data, setting, style){
        var httpName = '${httpName}';
        var itemEl = '<img style="'+style+'" src="'+httpName+data+setting+'" alt="">';
        return itemEl;
    }

    function getImgSrc(data, setting, style){
        var itemEl = '<img class="img-thumbnail" style="'+style+'" src="'+data+setting+'" alt="">';
        return itemEl;
    }

    function getDisplayItem(item, type){
        var itemEl;
        if(type == "img") { // selected file
            itemEl = '<img style="width: 100%;margin-top: 10px;"'
                +'src="'+item+'" alt="">';
        }
        return itemEl;
    }

    function findLastChild(parentNode) {
        lastNode = parentNode.lastChild;
        while (lastNode.nodeType != 1) {
            lastNode = lastNode.previousSibling;
        }
        return lastNode;
    }

    $('#regist').on('click', '', function () {
        if (confirm('태그를 등록/수정 하시겠습니까?')) {
            event.preventDefault();
            var form = $('#tag_form')[0];
            var data = new FormData(form);
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/rest/tag/registTag",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    if(data.resultCode == 9000){
                        alert("이미 등록되어있는 태그가 존재합니다.");
                        return false;
                    } else {
                        window.location.reload();
                    }
                },
                error: function (e) {
                    alert(e);
                }
            });

        }
    });



</script>

