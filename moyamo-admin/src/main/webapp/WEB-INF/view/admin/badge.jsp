<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    .btn-catetory{
        background-color: #79c09b !important;
        color: #FFFFFF !important;
        width: 110px !important;
        height: 30px !important;
        border-color: #79c09b !important;
        border-radius: 0.25rem;
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
    <div class="modal fade text-left" id="posting_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success">
                    <h3 class="modal-title white" style="font-size: 1.1rem;">
                        <b> 뱃지 발급</b>
                    </h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" style="color: white;">&times;</span>
                    </button>
                </div>
                <form name="posting_add_form" id="posting_add_form" action="<c:url value="/admin/registBadge"/>" method="post">
                    <div class="modal-body" style="padding: 0;">
                        <div class="card-body">
                            <fieldset class="form-group">
                                <label>뱃지 종류 : </label>
                                <label>
                                    <select id="badgeCategory" name="badgeName" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
                                        <c:forEach var= "badge" items="${allBadges}" >
                                            <option value="${badge.title}"> ${badge.title} </option>
                                        </c:forEach>
                                    </select>
                                </label>
                                <textarea rows="5" class="form-control autosize" name="userList"></textarea>
                            </fieldset>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="regist" class="btn btn-success" type="button">
                            <i class="la la-save"></i> 발급
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 게시물 상세보기모달 -->
    <div class="modal fade text-left" id="posting_detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success">
                    <h3 class="modal-title white" style="font-size: 1.1rem;">
                        <b> 뱃지 발급 상세</b>
                    </h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(false);">
                        <span aria-hidden="true" style="color: white;">&times;</span>
                    </button>
                </div>
                <form name="posting_detail_form" id="posting_detail_form" action="/admin/badge" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="postingId" value="">
                    <%--                    <input type="hidden" name="postingType" value="clinic">--%>
                    <div class="modal-body" style="padding: 0;">
                        <div class="card-body" style="padding-top: 1.0rem;padding-right: 1.0rem;padding-bottom: 0.5rem;padding-left: 1.0rem;">
                            <!-- 개인정보 영역 -->
                            <div class="media">

                                <a class="media-left">
                                    <h3 id="detail_badge_title"></h3>
                                </a>
                                <div class="media-body" style="margin-left: 10px;">
                                    <h6 class="media-heading" id="detail_user_nick"></h6>
                                    작성일 : <span class="text-muted" id="detail_createdAt"></span></br>
                                </div>

                            </div>
                            <hr size="100%"/>
                            <!-- 컨텐츠 영역 본문 -->
                            <div class="row" style="margin-bottom: 20px;">
                                <b><div class="col" id="detail_text"></div></b>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="content-body">
        <!-- 뱃지 -->
        <%--        <form name="posting_category_form" id="posting_category_form" action="/admin/switchPosting" method="post" >--%>
        <%--            <input type="hidden" name="postingType" value="clinic">--%>
        <section id="configuration">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-content collpase show">
                            <div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
                                <div class="table-responsive">
                                    <table id="postingtable" class="table table-hover table-striped table-bordered zero-configuration" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">
                                        <thead>
                                        <tr>
                                            <%--                                                <th><!-- <input type="checkbox" name="select_all" value="1" id="select-all"> --></th>--%>
                                            <th>아이디</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>상태</th>
                                        </tr>
                                        </thead>
                                    </table>
                                </div>

<%--                                <div class="row">--%>
<%--                                    <div class="col-sm-0 text-left">--%>
<%--                                        <div class="dataTables_length" id="postingtable_length">--%>
<%--                                            <label>--%>
<%--                                                <select id="targetCategory" name="targetCategory" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">--%>
<%--                                                    <option value="question">이름이모야</option>--%>
<%--                                                    <option value="free">자유수다</option>--%>
<%--                                                </select>--%>
<%--                                            </label>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-sm-2 text-left">--%>
<%--                                        <div class="btn-group">--%>
<%--                                            <button class="btn btn-catetory btn-sm" type="button" id="moveCategory">--%>
<%--                                                <span>카테고리 이동</span>--%>
<%--                                            </button>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="col-sm"></div>--%>
<%--                                </div>--%>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%--        </form>--%>
        <!-- 가이드북 관리 -->
    </div>
</div>
<!-- END: Content-->

<script type="text/javascript">
    var prevCommentId = 0;
    var table = 0;
    $(document).ready(function(){
        setMenuName('${menuName}');

        $('[data-toggle="tooltip"]').tooltip({
            html: true
        });

        $("textarea.autosize").on('keydown keyup', function () {
            $(this).height(1).height( $(this).prop('scrollHeight')+12 );
        });

        $('#select-all').on('click', function(){
            // Get all rows with search applied
            var rows = table.rows({ 'search': 'applied' }).nodes();
            // Check/uncheck checkboxes for all rows in the table
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
        });

        // Handle click on checkbox to set state of "Select all" control
        $('#postingtable tbody').on('change', 'input[type="checkbox"]', function(){
            // If checkbox is not checked
            if(!this.checked){
                var el = $('#select-all').get(0);
                // If "Select all" control is checked and has 'indeterminate' property
                console.log(el);
                if(el && el.checked && ('indeterminate' in el)){
                    // Set visual state of "Select all" control
                    // as 'indeterminate'
                    el.indeterminate = true;
                }
            }
        });

         table = $('.zero-configuration').DataTable({
            dom:
                "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'><'col-sm-2'B>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-4'i><'col-sm-8'p>>",
            buttons: [
                {
                    text: '뱃지 발급',
                    className: 'btn btn-custom-info First',
                    action: function ( e, dt, node, config ) {
                        $("textarea.autosize").val("");
                        $('#badgeCategory > option[value="금손"]').prop("selected", "selected").change();
                        $('#posting_add_modal').modal("show");
                    }
                },
            ],
            language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
            'ajax' : {
                "url":'/rest/getBadges'
            },
            'serverSide' : true,
            "processing" : true,
            "order": [ 0, 'desc'],
            "createdRow": function( row, data, dataIndex){
                $('td', row).eq(1).addClass('boldcolumn');
            },
            columns: [
                { data: "id", searchable: true, orderable: false},
                { data: "title", searchable: true, orderable: false},
                { data: "writer", searchable: true, orderable: false},
                { data: "createdAt" ,
                    render: function(data, type, row, meta){
                        return moment(data).format('YYYY-MM-DD HH:mm:ss')
                    },
                    searchable: false
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
                if(this.value.length >= 1 || e.keyCode == 13) {
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
                $('#posting_detail_modal').modal('show');
                var dataSet = table.row( $(this).parent() ).data();
                detailView(dataSet);

            }
        });

    });

    function detailView(dataSet) {
        changeScroll(true);
        //$('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);
        $('#detail_text').html("<span style='font-size: 110%;background-color: white;'>" +dataSet.content + "</span>");
        $('#detail_user_nick').html(dataSet.writer);
        $('#detail_createdAt').html(moment(dataSet.createdAt).format('YYYY-MM-DD HH:mm:ss'));
        $("#detail_badge_title").html(dataSet.title);
    }


    $('#regist').on('click', '', function () {
        if (confirm('뱃지를 발급하시겠습니까?')) {
            //$('#posting_add_form').submit();
            doRestApi('#posting_add_form');
        }
    });

    $('#detail_to_modify').on('click', '', function () {
        changeScroll(true);
        $('#posting_detail_modal').modal('hide');
        $('#posting_modify_modal').modal('show');
        return false;
    });

    $('#modify').on('click', '', function () {
        // TODO : description custom tag validation
        if (confirm('수정하시겠습니까?')) {
            var postId = $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').val();
            //$('#posting_modify_form').submit();
            doRestApi('#posting_modify_form');
        }
    });

    $('#delete').on('click', '', function () {
        if (confirm('삭제하시겠습니까?')) {
            var postId = $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').val();
            $('#posting_modify_form').attr('action', "/admin/deletePosting").submit();
            doRestApi('#posting_modify_form', '/admin/deletePosting');
        }
    });

    function changeScroll(isBody) {
        if (isBody) {
            $("body").css({"overflow-y":"hidden"});
            $('#posting_modify_modal').css({"overflow-y":"auto"});
        } else {
            $("body").css({"overflow-y":"auto"});
            $('#posting_modify_modal').css({"overflow-y":"hidden"});
        }
    }

</script>