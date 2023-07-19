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

    <jsp:include page="partial/photo/createModal.jsp" flush="false">
        <jsp:param name="menuName" value='${menuName}' />
        <jsp:param name="albums" value='${albums}' />
        <jsp:param name="album" value='${album}' />
        <jsp:param name="postingType" value='${postingType.name()}' />
    </jsp:include>
    <!-- -->

    <!-- Modify Modal -->
    <jsp:include page="partial/photo/modifyModal.jsp" flush="false">
        <jsp:param name="menuName" value='${menuName}' />
        <jsp:param name="postingType" value='${postingType.name()}' />
    </jsp:include>

    <section id="configuration">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-content collpase show">
                        <div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
                            <table id="postingtable" class="table table-hover table-striped table-bordered zero-configuration" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">
                            <div class="table-responsive">
                                <div class="bs-bars float-left">
                                    <div style="background: teal;">
                                        <button class="btn" tabindex="0" aria-controls="postingtable" type="button" id="albumHomeBtn"><span style="color: white">내 앨범 리스트 보러가기</span></button>
                                    </div>
                                </div>
                                <div class="bs-bars float-right">

                                    <div class="dt-buttons btn-group" style="margin-left:10px; width: 1%">
                                        <button class="btn" style="background: grey; color: white;" tabindex="0" aria-controls="postingtable" type="button" id="deleteBtn"><span>삭제</span></button>
                                    </div>

                                    <div class="dt-buttons btn-group" style="margin-right:10px">
                                        <button class="btn btn-secondary btn-custom-info First" tabindex="0" aria-controls="postingtable" type="button" id="openRegistPhotoBtn"><span>포토 등록</span></button>
                                    </div>

                                </div>
                                <br><br><br>

                                    <thead>
                                    <tr>
                                        <th><input type="checkbox" name="select_all" value="1" id="select-all"></th>
                                        <th>아이디</th>
                                        <th>썸네일</th>
                                        <th>내용</th>
                                        <th>닉네임</th>
                                        <th>좋아요</th>
                                        <th>등록 시간</th>
                                        <th>상태</th>
                                    </tr>
                                    </thead>

                            </div>
                        </table>
                            <div class="row" style="margin-top:10px; margin-left: 2px">
                                <div class="col-sm-0 text-left">
                                    <div class="dataTables_length" id="postingtable_length">
                                        <label>
                                            <select id="targetPhotoAlbum" name="targetPhotoAlbum" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
                                                <c:forEach var= "photoAlbum" items="${photoAlbums}" >
                                                    <c:if test="${photoAlbum.name != '전체'}">
                                                    <option value="${photoAlbum.id}"> ${photoAlbum.name} </option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                </div>

                                <div class="bs-bars float-left">

                                    <div class="dt-buttons btn-group" style="margin-left:10px">
                                        <button class="btn btn-catetory btn-sm" type="button" id="copyPhotoAlbum">
                                            <span>앨범으로 복사</span>
                                        </button>
                                    </div>

                                    <div class="dt-buttons btn-group" style="margin-right:10px; margin-left:10px">
                                        <button class="btn btn-catetory btn-sm" type="button" id="movePhotoAlbum">
                                            <span>앨범으로 이동</span>
                                        </button>
                                    </div>

                                </div>
                                <div class="col-sm"></div>
                            </div>
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

    var fileRepeaterDiv, fileRepeaterDiv2;

    function initRepeaterDiv(addPhoto) {

        if(addPhoto == undefined) {
            addPhoto = true;
        }

        if(fileRepeaterDiv != null && fileRepeaterDiv.setList !== undefined) {
            fileRepeaterDiv.setList([]);
        }

        if(fileRepeaterDiv2 != null && fileRepeaterDiv2.setList !== undefined) {
            fileRepeaterDiv2.setList([]);
        }

        if(addPhoto) {
            $('.add_photo').click();
        }
    }

    $(document).ready(function(){
        setMenuName('${menuName}');

        fileRepeaterDiv = $('#posting_add_form .file-repeater').repeater({
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

        fileRepeaterDiv2 = $('#posting_modify_form .file-repeater').repeater({
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
                $("form[name=posting_modify_form] input[name='repeater-list[0][files]']").off("change").on("change", btnFileAction);
            }
        });


        <%--        $('[data-toggle="tooltip"]').tooltip({--%>
        <%--            html: true--%>
        <%--        });--%>

        <%--        $("textarea.autosize").on('keydown keyup', function () {--%>
        <%--            $(this).height(1).height( $(this).prop('scrollHeight')+12 );--%>
        <%--        });--%>

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
                // "<'row'<'col-sm-1 text-left'l><'col-sm-2 toolbar'f><'col-sm-4 text-left'f><'col-sm'>>" +
                "<'row space'<'col-sm-0'><'text-left'l><'toolbar'f><'text-left'f><'col-sm'>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-4'i><'col-sm-8'p>>",
            // buttons: [
            //     {
            //         text: '포토 등록',
            //         className: 'btn btn-custom-info First',
            //         action: function ( e, dt, node, config ) {
            //             $("textarea.autosize").val("");
            //             $('#badgeCategory > option[value="금손"]').prop("selected", "selected").change();
            //             $('#posting_add_modal').modal("show");
            //         }
            //     },
            // ],
            language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
            'ajax' : {
                "url":'/rest/getPhotoAlbumDetail',
                "data":{
                    "id": "${albumId}"
                }
            },
            'serverSide' : true,
            "processing" : true,
            "order": [ 0, 'desc'],
            "createdRow": function( row, data, dataIndex){
                $('td', row).eq(2).addClass('boldcolumn');
                $('td', row).eq(3).addClass('boldcolumn');
            },
            columns: [
                { data : "id",
                    render: function (data, type, row, meta){

                        return '<input type="checkbox" name="postingId" value="' + data + '">';
                    },
                    searchable: false, orderable: false,
                    className: 'dt-body-center'
                },
                { data: "id", searchable: true, orderable: false},
                { data: "attachments[0].photoUrl" ,
                    render: function(data, type, row, meta){
                        var setting = '?d=50x50';
                        var style = 'width: 50px;height: 50px;padding: 0rem;';
                        var itemEl = getImgSrc(data, setting, style);
                        return itemEl;
                    },
                    searchable: false
                },
                { data: "text", searchable: true, orderable: false},
                { data: "owner.nickname", searchable: true, orderable: false},
                { data: "likeCount", searchable: true, orderable: false},
                { data: "createdAt" ,
                    render: function(data, type, row, meta){
                        return moment(data).format('YYYY-MM-DD HH:mm:ss')
                    },
                    searchable: false
                },
                { data: "createdAt" ,
                    render: function(data, type, row, meta){
                        return "-";
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
                initRepeaterDiv(false); // reapeater 초기화
                $('#posting_modify_modal').modal('show');
                var dataSet = table.row( $(this).parent() ).data();
                modifyView(dataSet);
            }
        });


        var options = '';
        <c:forEach var= "photoAlbum" items="${photoAlbums}">
            options += '<option name="${photoAlbum.name}" value="${photoAlbum.id}">${photoAlbum.name.replace("'", "\\'")}</option>';
        </c:forEach>


        $("div.toolbar").html('<select id="searchType" class="custom-select custom-select-sm form-control form-control-sm">'+options+'</select>');
        <%--$("div.toolbar").html('<select id="searchType" class="custom-select custom-select-sm form-control form-control-sm"><c:forEach var= "photoAlbum" items="${photoAlbums}"><option name="${photoAlbum.name}" value="${photoAlbum.id}">${photoAlbum.name}</option></c:forEach></select>');--%>
        $("#searchType option[value='${albumId}']").prop("selected",true);
        $("#searchType").change(function (){
            var tartgetAlbumId = $(this).val();
            init('/admin/photoAlbumDetail?id=' + tartgetAlbumId);
        })
    });

    $('#movePhotoAlbum').on('click', function(e){

        if("${albumName}" == "전체"){
            confirm('전체에서 이동은 불가합니다.');
            return ;
        }
        const query = 'input[type="checkbox"]:checked';
        const selectedEls = document.querySelectorAll(query);
        let length = selectedEls.length;
        if($('#select-all').prop("checked")){
            // console.log("선택 됨");
            $('#select-all').prop("checked", false);
            length = length-1;
        }
        if(length==0){
            confirm('사진을 선택해 주세요.');
        }

        if (confirm('앨범으로 이동하시겠습니까?')) {

            const query = 'input[type="checkbox"]:checked';
            const selectedEls = document.querySelectorAll(query);
            // console.log(selectedEls.length);
            const photoIds = [];
            for( let i=0;i<selectedEls.length;i++){
                photoIds.push(selectedEls[i].value);
            }
            // console.log("포토 id : "+ photoIds);
            <%--console.log("현재 : ${albumName}");--%>
            let targetPhotoAlbum = document.getElementById("targetPhotoAlbum").value;
            // console.log("선택된 것 : "+ targetPhotoAlbum);

            var allData = {
                "photoIds" : photoIds,
                "beforeAlbumId" : '${albumId}',
                "afterAlbumId" : targetPhotoAlbum
            };
            // console.log(allData);



            $.ajax({
                url:"/rest/movePhotos",
                type: 'PUT',
                data        : allData,
                success: function (data) {
                    <%--$(".content-body").load("/admin/photoAlbumDetail?id=${albumId}");--%>
                    $.ajax({
                        url: '/admin/photoAlbumDetail',
                        data:{"id":"${albumId}"},
                        type:'GET',
                        success:function(res){
                            // console.log(res)
                            $('div.app-content.content').html(res);
                        }
                    });
                    alert("완료!");
                    // window.opener.location.reload();
                    self.close();
                },
                error:function(jqXHR, textStatus, errorThrown){
                    alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
                    self.close();
                }

            });

            e.preventDefault();
        } else {
            return false;
        }
    });

    $('#copyPhotoAlbum').on('click', function(e){

        const query = 'input[type="checkbox"]:checked';
        const selectedEls = document.querySelectorAll(query);
        let length = selectedEls.length;
        if($('#select-all').prop("checked")){
            // console.log("선택 됨");
            $('#select-all').prop("checked", false);
            length = length-1;
        }
        if(length==0){
            confirm('사진을 선택해 주세요.');
        }

        if (confirm('앨범으로 복사하시겠습니까?')) {
            const query = 'input[type="checkbox"]:checked';
            const selectedEls = document.querySelectorAll(query);
            // console.log(selectedEls.length);
            const photoIds = [];
            for( let i=0;i<selectedEls.length;i++){
                photoIds.push(selectedEls[i].value);
            }
            // console.log("포토 id : "+ photoIds);
            <%--console.log("현재 : ${albumName}");--%>
            let targetPhotoAlbum = document.getElementById("targetPhotoAlbum").value;
            // console.log("선택된 것 : "+ targetPhotoAlbum);

            var allData = {
                "photoIds" : photoIds,
                "afterAlbumId" : targetPhotoAlbum
            };
            // console.log(allData);



            $.ajax({
                url:"/rest/copyPhotos",
                type: 'PUT',
                data: allData,
                success: function (data) {
                    <%--$(".content-body").load("/admin/photoAlbumDetail?id=${albumId}");--%>
                    $.ajax({
                        url: '/admin/photoAlbumDetail',
                        data:{"id":"${albumId}"},
                        type:'GET',
                        success:function(res){
                            // console.log(res)
                            $('div.app-content.content').html(res);
                        }
                    });
                    alert("완료!");
                    // window.opener.location.reload();
                    self.close();
                },
                error:function(jqXHR, textStatus, errorThrown){
                    alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
                    self.close();
                }

            });

            e.preventDefault();
        } else {
            return false;
        }
    });

    function posting_wait_reload(){
        setTimeout(function() {
            $('.zero-configuration').DataTable().ajax.reload();
        }, 1000);
    }

    $('#openRegistPhotoBtn', 'body').on('click', function() {
        openRegistPhotoModal();
    });

    function modifyView(dataSet) {
        changeScroll(true);
        $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').empty().val(dataSet.id);
        var user = dataSet.owner.nickname + ' (ID:' + dataSet.owner.id + ')';
        $('#detail_user_nick').html(user);
        $('#detail_createdAt').html(moment(dataSet.createdAt).format('YYYY-MM-DD HH:mm:ss'));
        $('#detail_modifiedAt').html(moment(dataSet.modifiedAt).format('YYYY-MM-DD HH:mm:ss'));

        for(var i=0; i < dataSet.orgAttachments.length; i++){

            $('.add_photo').click();
            var setting = '';
            var style = 'width: 100%;margin-top: 10px;';
            var imgSrc = getImgSrc(dataSet.orgAttachments[i].photoUrl, setting, style);

            <%--            }--%>
            <%--        });--%>

            $("#posting_modify_modal form[name=posting_modify_form] input[name='repeater-list["+i+"][files]'").parent().find(".view:eq(0)").empty().prepend(imgSrc);
            //포토는 사진설명에 posting.text
            $("#posting_modify_modal form[name=posting_modify_form] textarea[name='repeater-list["+i+"][descriptions]'").val(dataSet.text);
            $("#posting_modify_modal form[name=posting_modify_form] input[name='repeater-list["+i+"][id]'").val(dataSet.orgAttachments[i].id);
        }
        $('#posting_modify_modal').modal('handleUpdate');
    }

    //포토 등록 모달 열기
    function openRegistPhotoModal() {
        $('#posting_add_modal').modal('show');

        initSelectAlbum('${albumName}');
        /*$('#posting_add_modal').unbind('shown.bs.modal').on('shown.bs.modal', function (e) {
            // do something here...

        });*/

        initRepeaterDiv();
        changeScroll(true);
        initInput();
    }

    function changeScroll(isBody, target) {
        console.log('changeScroll ', isBody);

        if(target) {
            if (isBody) {
                $("body").css({"overflow-y":"hidden"});
                $(target).css({"overflow-y":"auto"});
            } else {
                $("body").css({"overflow-y":"auto"});
                $(target).css({"overflow-y":"hidden"});
            }
        } else {
            if (isBody) {
                $('body').css("overflow","hidden");
                $('#album_add_modal').css({"overflow-y":"auto"});
                $('#album_modify_modal').css({"overflow-y":"auto"});
                $('#album_detail_modal').css({"overflow-y":"auto"});
                $('#posting_add_modal').css({"overflow-y":"auto"});
                $('#posting_detail_modal').css({"overflow-y":"auto"});
                $('#posting_modify_modal').css({"overflow-y":"auto"});
            } else {
                $('body').css("overflow","auto");
                $('#album_add_modal').css({"overflow-y":"hidden"});
                $('#album_modify_modal').css({"overflow-y":"hidden"});
                $('#album_detail_modal').css({"overflow-y":"hidden"});
                $('#posting_add_modal').css({"overflow-y":"hidden"});
                $('#posting_detail_modal').css({"overflow-y":"hidden"});
                $('#posting_modify_modal').css({"overflow-y":"hidden"});
            }
        }
    }

    $("#posting_detail_modal, #posting_add_modal, #posting_modify_modal, #album_add_modal, #album_modify_modal, #album_detail_modal").on("hidden.bs.modal", function (a, b, c) {
        // put your default event here
        changeScroll(false, a.currentTarget);
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
                        initInput();
                        //TODO 초기화 library 영역에서 처리할 수는 없나?
                        // $("form[name=posting_add_form] input[name='title']").val("");
                        // $("form[name=posting_add_form] textarea[name='text']").val("");
                        // $("form[name=posting_add_form] input[name='goodsNo']").val("");
                        // $("form[name=posting_add_form] div[data-repeater-item]").remove();
                        // $("form[name=posting_add_form] button[data-repeater-create]").click();

                        posting_wait_reload();
                        closeRegistPhotoModal();
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
                    closeModifyPhotoModal();
                };
            })();

            doRestApi('#posting_modify_form', undefined, callback);

        }
        closeModifyPhotoModal();
    });

    function deletePosting(postingId) {
        if ("${albumName}" == "전체" ? !confirm('삭제하시겠습니까?\n(모든 앨범에서 사진이 삭제됩니다.)') : !confirm('삭제하시겠습니까?')) {
            return;
        }

        const photoIds = [];
        photoIds.push(postingId);

        $.ajax({
            url:"/rest/deletePhotos",
            type: 'PUT',
            data        : {
                "photoIds" : photoIds,
                "currentAlbumId" : '${albumId}'
            },
            success: function (data) {
                <%--$(".content-body").load("/admin/photoAlbumDetail?id=${albumId}");--%>
                $.ajax({
                    url: '/admin/photoAlbumDetail',
                    data:{"id":"${albumId}"},
                    type:'GET',
                    success:function(res){
                        // console.log(res)
                        $('.zero-configuration').DataTable().ajax.reload(null, false);
                        closeModifyPhotoModal()
                        // $('div.app-content.content').html(res);
                    }
                });

                alert('삭제처리 되었습니다.');
                // window.opener.location.reload();
                self.close();
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
                self.close();
            }

        }).done(function() {
            $('div.app-content.content').html(res);
        });
    }

    $('#delete').on('click', function(e){
        var postingId =$('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').val();
        deletePosting(postingId);
        closeModifyPhotoModal();
    });


    $('#deleteBtn').on('click', function(e){
        const query = 'input[type="checkbox"]:checked';
        const selectedEls = document.querySelectorAll(query);
        let length = selectedEls.length;
        if($('#select-all').prop("checked")){
            // console.log("선택 됨");
            $('#select-all').prop("checked", false);
            length = length-1;
        }
        if(length==0){
            confirm('사진을 선택해 주세요.');
        }
        else {
            if ( "${albumName}" == "전체" ? confirm(length+'장의 사진을 삭제하시겠습니까?\n(모든 앨범에서 사진이 삭제됩니다.)') : confirm(length+'장의 사진을 삭제하시겠습니까?')) {

            const query = 'input[type="checkbox"]:checked';
            const selectedEls = document.querySelectorAll(query);
            // console.log(selectedEls.length);
            const photoIds = [];
            for( let i=0;i<selectedEls.length;i++){
                photoIds.push(selectedEls[i].value);
            }
            // console.log("포토 id : "+ photoIds);
            <%--console.log("현재 : ${albumName}");--%>
            let targetPhotoAlbum = document.getElementById("targetPhotoAlbum").value;
            // console.log("선택된 것 : "+ targetPhotoAlbum);

            var allData = {
                "photoIds" : photoIds,
                "currentAlbumId" : '${albumId}'
            };
            // console.log(allData);



            $.ajax({
                url:"/rest/deletePhotos",
                type: 'PUT',
                data        : allData,
                success: function (data) {
                    <%--$(".content-body").load("/admin/photoAlbumDetail?id=${albumId}");--%>
                    $.ajax({
                        url: '/admin/photoAlbumDetail',
                        data:{"id":"${albumId}"},
                        type:'GET',
                        success:function(res){
                            // console.log(res)
                            $('div.app-content.content').html(res);
                        }
                    });

                    alert("완료!");
                    // window.opener.location.reload();
                    self.close();
                },
                error:function(jqXHR, textStatus, errorThrown){
                    alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
                    self.close();
                }

            });

                e.preventDefault();
            } else {
                return false;
            }
        }
    });

    $('#albumHomeBtn').on('click', function(e){
        init('/admin/photoAlbum');
        /*
        $.ajax({
            url:"/admin/photoAlbum",
            success: function (res) {
                init('/admin/photoAlbum');
                // $('div.app-content.content').html(res);
            }
        });
        */
    });

    function btnFileAction(e){
        //파일 선택후 element 만들기
        var itemEl = getDisplayItem(URL.createObjectURL(this.files[0]), "img");
        $(this).parent().find("#modify_id").val("");
        $(this).parent().find(".view:eq(0)").empty().prepend(itemEl);
    }

    function getDisplayItem(item, type){
        var itemEl;
        if(type == "img") { // selected file
            itemEl = '<img style="width: 100%;margin-top: 10px;"'
                +'src="'+item+'" alt="">';
        }
        return itemEl;
    }

    function getImgSrc(data, setting, style){
        if (data == null) {
            return '<img style="'+style+'" src="/static/img/noimg.png" alt="">';
        } else {
            return '<img class="img-thumbnail" style="'+style+'" src="'+data+setting+'" alt="">';
        }
    }
</script>
