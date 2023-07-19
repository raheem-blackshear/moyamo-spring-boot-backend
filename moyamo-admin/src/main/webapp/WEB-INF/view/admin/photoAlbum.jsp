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
    .space{
        margin-left: 0px;
    }
</style>

<div class="content-body">

    <jsp:include page="partial/photo/createModal.jsp">
        <jsp:param name="menuName" value='${menuName}' />
    </jsp:include>
    <!-- -->

    <jsp:include page="partial/photoAlbum/createModal.jsp">
        <jsp:param name="menuName" value='${menuName}' />
    </jsp:include>


    <jsp:include page="partial/photoAlbum/modifyModal.jsp">
        <jsp:param name="menuName" value='${menuName}' />
    </jsp:include>

    <!-- -->

    <section id="configuration">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-content collpase show">
                        <div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
                            <table id="postingtable" class="table table-hover table-striped table-bordered zero-configuration" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">
                            <div class="table-responsive">
                                <div class="bs-bars float-right">

                                    <div class="dt-buttons btn-group" style="margin-left:10px">
                                        <button class="btn btn-secondary btn-custom-info First" tabindex="0" aria-controls="postingtable" type="button" id="openRegistPhotoBtn"><span>포토 등록</span></button>
                                    </div>

                                    <div class="dt-buttons btn-group" style="margin-right:10px">
                                        <button class="btn btn-secondary btn-custom-info First" tabindex="0" aria-controls="postingtable" type="button" id="openRegistAlbumBtn"><span>앨범 추가</span></button>
                                    </div>

                                </div>
<%--                                <table id="postingtable" class="table table-hover table-striped table-bordered zero-configuration" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">--%>
                                    <thead>
                                    <tr>
                                        <%--                                                <th><!-- <input type="checkbox" name="select_all" value="1" id="select-all"> --></th>--%>
                                        <th>아이디</th>
                                        <th>썸네일</th>
                                        <th>앨범명</th>
                                        <th>사진 개수</th>
                                        <th>생성 일자</th>
                                        <th>최근 등록 시간</th>
                                        <th>앨범 편집</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>
</div>

<script type="text/javascript">
<%--    var prevCommentId = 0;--%>
<%--    var table = 0;--%>
    function initInput() { // 등록 init
        $("#title").val("");
        $(".form-group textarea").val("");
        $(".view:eq(0)").empty();
    }

    var fileRepeaterDiv;

    function initRepeaterDiv() {
        if(fileRepeaterDiv != null && fileRepeaterDiv.setList !== undefined) {
            fileRepeaterDiv.setList([]);
        }
        $('.add_photo').click();
    }

    $(document).ready(function(){
        setMenuName('${menuName}');

        fileRepeaterDiv = $('.file-repeater').repeater({
            show: function () {
                var count = $(this).parent()[0].childElementCount;
                if(10 < count){
                    $(this).remove();
                    return;
                }

                $(this).slideDown();
                $(this).find('input[name*=files]').off("change").on("change", btnFileAction);
            },
            hide: function(remove) {
                $(this).slideUp(remove);
            },

            ready: function(remove) {
                //initSelectMulti();
                $("form[name=posting_add_form] input[name='repeater-list[0][files]']").off("change").on("change", btnFileAction);
            }
        });


        $("#posting_detail_modal, #posting_add_modal, #posting_modify_modal, #album_add_modal, #album_modify_modal, #album_detail_modal").on("hidden.bs.modal", function (a, b, c) {
            // put your default event here
            changeScroll(false, a.currentTarget);
        });

        $('[data-toggle="tooltip"]').tooltip({
            html: true
        });

        $("textarea.autosize").on('keydown keyup', function () {
            $(this).height(1).height( $(this).prop('scrollHeight')+12 );
        });

<%--        $('#select-all').on('click', function(){--%>
<%--            // Get all rows with search applied--%>
<%--            var rows = table.rows({ 'search': 'applied' }).nodes();--%>
<%--            // Check/uncheck checkboxes for all rows in the table--%>
<%--            $('input[type="checkbox"]', rows).prop('checked', this.checked);--%>
<%--        });--%>

<%--        // Handle click on checkbox to set state of "Select all" control--%>
<%--        $('#postingtable tbody').on('change', 'input[type="checkbox"]', function(){--%>
<%--            // If checkbox is not checked--%>
<%--            if(!this.checked){--%>
<%--                var el = $('#select-all').get(0);--%>
<%--                // If "Select all" control is checked and has 'indeterminate' property--%>
<%--                console.log(el);--%>
<%--                if(el && el.checked && ('indeterminate' in el)){--%>
<%--                    // Set visual state of "Select all" control--%>
<%--                    // as 'indeterminate'--%>
<%--                    el.indeterminate = true;--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>

         table = $('.zero-configuration').DataTable({
            dom:
                // "<'row'<'col-sm-1 text-left'l><'col-sm-4 text-left'f><'col-sm'>>" +
                "<'row space'<'col-sm-0'><'text-left'l><'text-left'f>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-4'i><'col-sm-8'p>>",
            language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
            'ajax' : {
                "url":'/rest/getPhotoAlbums'
            },
            'serverSide' : true,
            "processing" : true,
            "order": [ 0, 'desc'],
            "createdRow": function( row, data, dataIndex){
                $('td', row).eq(1).addClass('boldcolumn');
                $('td', row).eq(2).addClass('boldcolumn');
            },
            columns: [
                { data: "id", searchable: true, orderable: false},
                { data: "representPhoto" ,
                    render: function(data, type, row, meta){
                        if(data == null){
                            return "";
                        }
                        var setting = '?d=50x50';
                        var style = 'width: 50px;height: 50px;padding: 0rem;';
                        var itemEl = getImgSrc(data.attachments[0].photoUrl, setting, style);
                        return itemEl;
                    },
                    searchable: false
                },
                { data: "name",
                    searchable: true, orderable: false
                },
                { data: "photoCnt", searchable: true, orderable: false},
                { data: "createdAt" ,
                    render: function(data, type, row, meta){
                        return moment(data).format('YYYY-MM-DD HH:mm:ss')
                    },
                    searchable: false
                },
                { data: "representPhoto" ,
                    render: function(data, type, row, meta){
                        if(data == null){
                            return "";
                        }
                        return moment(data.createdAt).format('YYYY-MM-DD HH:mm:ss')
                    },
                    searchable: false
                },
                { data: "id",
                    render: function(data, type, row, meta){
                        if(row.name == "전체")
                            return "-";
                        return "<button style='background: grey; color: white;' id='editAlbum' onclick='editAlbum(this)' value="+data+"> 편집 </button>";
                    },
                    orderable: false, searchable: false
                }
                // { data: "data" ,
                //     render: functi n(data, type, row, meta){
                //         var setting = '?d=50x50';
                //         var style = 'width: 50px;height: 50px;padding: 0rem;';
                //         var itemEl = getImgSrc(data.attachments[0].photoUrl, setting, style);
                //         return itemEl;
                //     },
                //     searchable: false
                // }
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
            if('boldcolumn' === $(this)[0].className.trim()){

                var dataSet = table.row( $(this).parent() ).data();
                console.log(dataSet.name);

                init('/admin/photoAlbumDetail?id=' + dataSet.id);
                /*
                $.ajax({
                    url: '/admin/photoAlbumDetail',
                    data:{"id":dataSet.id},
                    type:'GET',
                    success:function(res){
                        // console.log(res)
                        //url Hash 를 변경

                        $('div.app-content.content').html(res);
                    }
                });*/
            }
        });


        $('#openRegistAlbumBtn', 'body').on('click', function() {
            openRegistAlbumModal();
        });

        $('#openRegistPhotoBtn', 'body').on('click', function() {
            openRegistPhotoModal();
        });


        $('#registAlbum', 'body').on('click', function () {
            if (confirm('앨범 등록하시겠습니까?')) {
                var callback = (function() {
                    //var repeater = fileRepeaterDiv;
                    return function fn() {
                        // initInput();
                        // initRepeaterDiv();
                        // posting_wait_reload();
                        load(document.location.hash.replace('#', ''));
                        closeRegistPhotoModal();
                    };
                })();

                doRestApi('#album_add_form', undefined, callback);
            }
            closeRegistAlbumModal();
        });

        $('#regist', 'body').on('click', function () {
            var isValid = true;
            $('#posting_add_form textarea').each(
                function(index){
                    var input = $(this);
                    if (!checkCustomTag(input.val())) {
                        isValid = false;
                    };
                }
            );
            if (isValid) {
                if (confirm('컨텐츠를 등록하시겠습니까?')) {
                    var callback = (function() {
                        //var repeater = fileRepeaterDiv;
                        return function fn() {
                            //repeater.setList([]);
                            initRepeaterDiv();
                            closeRegistPhotoModal();
                            //TODO 초기화 library 영역에서 처리할 수는 없나?
                            // $("form[name=posting_add_form] input[name='title']").val("");
                            // $("form[name=posting_add_form] textarea[name='text']").val("");
                            // $("form[name=posting_add_form] input[name='goodsNo']").val("");
                            // $("form[name=posting_add_form] div[data-repeater-item]").remove();
                            // $("form[name=posting_add_form] button[data-repeater-create]").click();

                            posting_wait_reload();
                        };
                    })();

                    doRestApi('#posting_add_form', undefined, callback);
                }
            } else {
                alert("TAG 를 확인하시기 바랍니다.");
                return false;
            }
            closeRegistPhotoModal();
        });

        $('#modify', 'body').on('click', function () {
            // TODO : description custom tag validation
            if (confirm('수정하시겠습니까?')) {
                var postId = $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').val();
                //$('#posting_modify_form').submit();
                var callback = (function() {
                    return function fn() {
                        posting_wait_reload();
                    };
                })();

                doRestApi('#posting_modify_form', undefined, callback);
            }
            closeModifyPhotoModal();
        });

        $('#modifyAlbum', 'body').on('click', function () {
            // TODO : description custom tag validation
            if (confirm('수정하시겠습니까?')) {
                var albumId = $('#album_modify_modal form[name=album_modify_form] input[name=albumId]').val();
                //$('#posting_modify_form').submit();
                var callback = (function() {
                    return function fn() {
                        //posting_wait_reload();
                        load(document.location.hash.replace('#', ''));
                    };
                })();

                doRestApi('#album_modify_form', undefined, callback);
            }
            closeModifyAlbumModal();
        });

        $('#deleteAlbum', 'body').on('click', function () {
            var albumId = $('#album_modify_modal form[name=album_modify_form] input[name=albumId]').val();
            deleteAlbum(albumId);
            closeModifyAlbumModal();
        });

        function getDisplayItem(item, type){
            var itemEl;
            if(type == "img") { // selected file
                itemEl = '<img style="width: 100%;margin-top: 10px;"'
                    +'src="'+item+'" alt="">';
            }
            return itemEl;
        }

        function btnFileAction(e){
            //파일 선택후 element 만들기
            var itemEl = getDisplayItem(URL.createObjectURL(this.files[0]), "img");
            $(this).parent().find("#modify_id").val("");
            $(this).parent().find(".view:eq(0)").empty().prepend(itemEl);
        }

        function getImgSrc(data, setting, style){
            if (data == null) {
                return '<img style="'+style+'" src="/static/img/noimg.png" alt="">';
            } else {
                return '<img class="img-thumbnail" style="'+style+'" src="'+data+setting+'" alt="">';
            }
        }

        function posting_wait_reload(){
            setTimeout(function() {
                $('.zero-configuration').DataTable().ajax.reload();
            }, 1000);
        }

        function deleteAlbum(albumId) {

            if(!confirm('삭제하시겠습니까?')) {
                return;
            }

            $.ajax({
                type: "POST",
                url: "/rest/photoAlbum/"+albumId+"/delete",
                dataType: "json",
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    if(data.resultCode && data.resultCode == 9000) {
                        alert(data.resultMsg);
                        return;
                    }
                    setTimeout(function(){
                        alert('삭제처리 되었습니다.');
                        load(document.location.hash.replace('#', ''));
                    }, 500);
                },
                error: function (e) {
                    alert(e);
                }
            }).done(function() {

            });
        }

    });

    function changeScroll(isBody, target) {
        console.log('changeScroll', isBody);
        if(target) {
            if (isBody) {
                $("body").css({"overflow":"hidden"});
                $(target).css({"overflow-y":"auto"});
            } else {
                $("body").css({"overflow":"auto"});
                $(target).css({"overflow-y":"hidden"});
            }
        } else {
            if (isBody) {
                $("body").css({"overflow":"hidden"});
                $('#album_add_modal').css({"overflow-y":"auto"});
                $('#album_modify_modal').css({"overflow-y":"auto"});
                $('#album_detail_modal').css({"overflow-y":"auto"});
                $('#posting_modify_modal').css({"overflow-y":"auto"});
            } else {
                $("body").css({"overflow":"auto"});
                $('#album_add_modal').css({"overflow-y":"hidden"});
                $('#album_modify_modal').css({"overflow-y":"hidden"});
                $('#album_detail_modal').css({"overflow-y":"hidden"});
                $('#posting_modify_modal').css({"overflow-y":"hidden"});
            }
        }
    }

    function openRegistAlbumModal() {
        $('#album_add_modal').modal('show');
        changeScroll(true);
        initRepeaterDiv();
        initInput();
    }

    function closeModifyAlbumModal() {
        $('#album_modify_modal').modal('hide');
        changeScroll(false);
    }


    //포토 등록 모달 열기
    function openRegistPhotoModal() {
        $('#posting_add_modal').modal('show');
        changeScroll(true);
        initRepeaterDiv();
        initSelectAlbum([]);
        initInput();
    }

    function closeRegistAlbumModal() {
        $('#album_add_modal').modal('hide');
        changeScroll(false);
    }

    function closeRegistPhotoModal() {
        $('#posting_add_modal').modal('hide');
        changeScroll(false);
    }

    function closeModifyPhotoModal() {
        $('#posting_modify_modal').modal('hide');
        changeScroll(false);
    }



//포토 등록 모달 열기
    function openEditAlbumModal(dataSet) {
        $('#album_modify_modal').modal('show');
        changeScroll(true);
        initInput();
        $("#album_modify_modal_dialog form[name=album_modify_form] input[name='albumId']").val(dataSet.id);
        $("#album_modify_modal_dialog form[name=album_modify_form] textarea[name='name']").val(dataSet.name);
    }


    function editAlbum(e){
        var dataSet = table.row( $(e).parent().parent() ).data();
        openEditAlbumModal(dataSet);
    }


</script>
