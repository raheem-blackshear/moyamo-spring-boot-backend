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

<div class="content-body">

    <jsp:include page="partial/photo/createModal.jsp">
        <jsp:param name="postingType" value='${postingType.name()}' />
    </jsp:include>
    <!-- -->

    <!-- Modify Modal -->
    <jsp:include page="partial/photo/modifyModal.jsp">
        <jsp:param name="postingType" value='${postingType.name()}' />
    </jsp:include>
    <!-- -->

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
                                        <th>썸네일</th>
                                        <th>내용</th>
                                        <th>닉네임</th>
                                        <th>좋아요</th>
                                        <th>등록 시간</th>
<%--                                        <th>상태</th>--%>
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
</div>
    <script type="text/javascript">

        var fileRepeaterDiv;

        function initRepeaterDiv() {
            if(fileRepeaterDiv != null && fileRepeaterDiv.setList !== undefined) {
                fileRepeaterDiv.setList([]);
            }
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
                    $("body").css({"overflow-y":"hidden"});
                    $('#album_add_modal').css({"overflow-y":"auto"});
                    $('#album_modify_modal').css({"overflow-y":"auto"});
                    $('#album_detail_modal').css({"overflow-y":"auto"});
                    $('#posting_add_modal').css({"overflow-y":"auto"});
                    $('#posting_detail_modal').css({"overflow-y":"auto"});
                    $('#posting_modify_modal').css({"overflow-y":"auto"});
                } else {
                    $("body").css({"overflow-y":"auto"});
                    $('#album_add_modal').css({"overflow-y":"hidden"});
                    $('#album_modify_modal').css({"overflow-y":"hidden"});
                    $('#album_detail_modal').css({"overflow-y":"hidden"});
                    $('#posting_add_modal').css({"overflow-y":"hidden"});
                    $('#posting_detail_modal').css({"overflow-y":"hidden"});
                    $('#posting_modify_modal').css({"overflow-y":"hidden"});
                }
            }
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

        function initInput() { // 등록 init
            $(".custom-file label").empty().html("파일을 선택해주세요.");
            $("#title").val("");
            $(".form-group textarea").val("");
            //매거진까지 init
            $(".view:eq(0)").empty();
        }

            <%--    var prevCommentId = 0;--%>
        <%--    var table = 0;--%>
        $(document).ready(function(){
            setMenuName('${menuName}');

            var table = $('.zero-configuration').DataTable({
                dom:
                    "<'row'<'col-sm-0 text-left'l><'col-sm-8 text-left'f><'col-sm'><'col-sm-2'>>" +
                    "<'row'<'col-sm-12'tr>>" +
                    "<'row'<'col-sm-4'i><'col-sm-8'p>>",
                buttons: [
                    <c:if test="${isPhotoEnable}">
                    {
                        text: '포토 등록',
                        className: 'btn 록 First',
                        action: function ( e, dt, node, config ) {
                            //openWriteModal();
                        }
                    }
                    </c:if>
                ],
                language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
                'ajax' : {
                    "url":'/rest/getPostingList',
                    "data": function(d) {
                        d.posting_type = 'photo'
                        //사용자 필터 조건
                        d.user = $('#postingtable_filter input[name="user"]').val();
                    },
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
                    }
                ]
            });

    if($('#postingtable_filter label:first input[name="user"]').length == 0) {
        $("#postingtable_filter label:first").append('<input name="user" placeholder="사용자ID(숫자)" type="text" class="form-control form-control-sm" />' + '<button class="btn" id="searchBtn" style="height: 27px;padding: 0 10px 0 10px; margin: 0 10px 0 10px; background: #e2e2e2;">검색</button>');
        $("#postingtable_filter #searchBtn").unbind('click').on('click', function (e) {
            e.preventDefault();
            var searchTerm = $('#postingtable_filter input[type="search"]').val()
            table.search(searchTerm).draw();
        });
    }


    //검색창 3글자 이내는 검색안되게 딜레이 600ms
    var searchWait = 0;
    var searchWaitInterval;
    $('.dataTables_filter input[name!="user"]')
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

        //포토 등록 모달 열기
        function openRegistPhotoModal() {
            $('#posting_add_modal').modal('show');
            changeScroll(true);
            initInput();
        }

        //포토 등록 모달 닫기
        function closeRegistPhotoModal() {
            $('#posting_add_modal').modal('hide');
            changeScroll(false);
            initInput();
        }

        function closeModifyPhotoModal() {
            $('#posting_modify_modal').modal('hide');
            changeScroll(false);
        }

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

            if('${user}' == dataSet.owner.id || '${role}' == 'ADMIN') {
                $('.modal-footer').css('visibility', "visible");
            } else {
                $('.modal-footer').css('visibility', "hidden");
                $("#posting_modify_modal form[name=posting_modify_form] textarea").attr('disabled', 'disabled');
            }
            $('#posting_modify_modal').modal('handleUpdate');
        }

        function deletePosting(postingId) {

            if(!confirm('삭제하시겠습니까? (모든 앨범에서 사진이 삭제됩니다.)')) {
                return;
            }

            $.ajax({
                type: "POST",
                url: "/rest/photo/"+postingId+"/deletePosting?album=전체",
                dataType: "json",
                data : JSON.stringify({
                    album : "전체"
                }),
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
                        $('.zero-configuration').DataTable().ajax.reload(null, false);
                        closeModifyPhotoModal()
                        alert('삭제처리 되었습니다.');
                    }, 500);
                },
                error: function (e) {
                    alert(e);
                }
            }).done(function() {
                console.log('deletePosting done' + postingId);
            });
        }

        $(document).on('change', '.custom-file-input', function (event) {
            $(this).next('.custom-file-label').html(event.target.files[0].name);
            $(this).next('.custom-file-label').attr('file-size', event.target.files[0].size);
        });

        $("textarea.autosize").on('keydown keyup', function () {
            $(this).height(1).height( $(this).prop('scrollHeight')+12 );
        });

        // $('.file-repeater').repeater({
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

        $('#delete').on('click', function(e){
            var postingId =$('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').val();
            deletePosting(postingId);
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
                        };
                    })();

                    doRestApi('#posting_add_form', undefined, callback);

                }
            } else {
                alert("TAG 를 확인하시기 바랍니다.");
                return false;
            }
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
        });

        //** Row 클릭 **//
        $('.zero-configuration tbody').on('click', 'td', function (e) {
            console.log('target', e.currentTarget);
            if($(e.currentTarget).hasClass("sorting_1")) {
                //e.preventDefault();
                return;
            }

            //if('boldcolumn' == $(this)[0].className.trim()){
            initRepeaterDiv(); // reapeater 초기화
            $('#posting_modify_modal').modal('show');
            var dataSet = table.row( $(this).parent() ).data();
            modifyView(dataSet);
        });


    });

        $('#nickname').on('click', function () {
            console.log("aaa");
            let value = document.getElementById("nickname").value;
            console.log(value);
        });
    </script>
