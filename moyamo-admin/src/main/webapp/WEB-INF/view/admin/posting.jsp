<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.String" %>
<%@ page import="java.util.*" %>
<%@ page import="net.infobank.moyamo.enumeration.PostingType" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


    <sec:authorize access="hasAnyAuthority('ADMIN')" var="isAdmin"></sec:authorize>

    <c:if test="${postingType ne PostingType.magazine && postingType ne PostingType.guidebook && isAdmin}" var="moveCategoryAllowed"></c:if>

    <sec:authorize access="hasAnyAuthority('ADMIN')" var="contentsAccessAllowed"></sec:authorize>
    <c:if test="${isAdmin || (!isAdmin && postingType ne PostingType.magazine && postingType ne PostingType.guidebook)}" var="contentWriteAllowed" scope="request"></c:if>
    <c:if test="${isAdmin}" var="contentsEditAllowed" scope="request"></c:if>


    <c:if test="${needy}" var="needyPosting" scope="request"></c:if>

    <%
        String strPostingType = request.getParameter("postingType");
        System.out.println("strPostingType : " + strPostingType);
    %>

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

	.btn-catetory{
		background-color: #79c09b !important;
		color: #FFFFFF !important;
		width: 110px !important;
		height: 30px !important;
		border-color: #79c09b !important;
		border-radius: 0.25rem;
	}

	.btn-blind{
		background-color: #79c09b !important;
		color: #FFFFFF !important;
		width: 78px !important;
		height: 30px !important;
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
    }
	textarea.autosize { min-height: 50px; }

    #detail_youtube_view {
        position: relative;
        padding-bottom: 56.25%; /* 16:9 */
        height: 0;
    }
    #detail_youtube_view iframe {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
    }
    </style>
	<link rel="stylesheet" href="/static/assets/css/jquery.mentiony.css" >

    <!-- END: Custom CSS-->
        <!-- BEGIN: Content-->
        <div class="content-wrapper">
			<!-- Add Modal -->
			<jsp:include page="partial/createModal.jsp" flush="false">
				<jsp:param name="menuName" value='${menuName}' />
				<jsp:param name="postingType" value='${postingType.name()}' />
			</jsp:include>
			<!-- -->

			<!-- Modify Modal -->
			<jsp:include page="partial/modifyModal.jsp" flush="false">
				<jsp:param name="menuName" value='${menuName}' />
				<jsp:param name="postingType" value='${postingType.name()}' />
			</jsp:include>
			<!-- -->

			<!-- alarm Modal -->
			<div class="modal animated pulse text-left show" id="notification_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true" style="z-index:10000;">
				<div class="modal-dialog" id="notification_modal_content" role="document">
					<jsp:include page="template/view_notification_modal_content.jsp"></jsp:include>
				</div>
			</div>
			<!-- -->

			<!-- 게시물 상세보기모달 -->
			<jsp:include page="partial/detailModal.jsp" flush="false">
				<jsp:param name="menuName" value='${menuName}' />
                <jsp:param name="user" value='${user}' />
				<jsp:param name="postingType" value='${postingType.name()}' />
			</jsp:include>
			<!-- -->

            <div class="content-body">
                <!-- 매거진 -->
                <form name="posting_category_form" id="posting_category_form" action="/admin/switchPosting" method="post" >
                <input type="hidden" name="postingType" value="magazine">
                <section id="configuration">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-content collpase show">
                                    <div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
                                        <div class="table-responsive" id="table-responsive-wait" style="display: none;">
                                        	<table id="postingtable_wait" class="table table-hover table-striped table-bordered zero-configuration-wait" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">
                                                <thead>
                                                    <tr>
                                                        <c:if test="${moveCategoryAllowed}">
                                                        <th><input type="checkbox" name="select_all" value="1" id="select-all">
                                                        </th>
                                                        </c:if>
                                                        <th>아이디</th>
                                                        <th>썸네일</th>
                                                        <c:if test="${postingType.allowTitle eq true}">
                                                            <th>제목</th>
                                                        </c:if>
                                                        <th>내용</th>
                                                        <th>닉네임</th>
                                                        <th>작성일</th>
                                                        <th>상태</th>
                                                    </tr>
                                                </thead>
                                            </table>
	                                        <hr>
                                        </div>
                                        <div class="table-responsive">
                                            <table id="postingtable" class="table table-hover table-striped table-bordered zero-configuration" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">
                                                <thead>
                                                    <tr>
                                                        <c:if test="${moveCategoryAllowed}">
                                                        <th><input type="checkbox" name="select_all" value="1" id="select-all">
                                                        </th>
                                                        </c:if>
                                                        <th>아이디</th>
                                                        <th>썸네일</th>
                                                        <c:if test="${postingType.allowTitle eq true}">
                                                            <th>제목</th>
                                                        </c:if>
                                                        <th>내용</th>
                                                        <th>닉네임</th>
                                                        <th>조회수</th>
                                                        <th>좋아요</th>
                                                        <th>댓글</th>
                                                        <th>작성일</th>
                                                        <th>상태</th>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>
                                    <c:if test="${moveCategoryAllowed}">
 										<div class="row">
											<div class="col-sm-0 text-left">
												<div class="dataTables_length" id="postingtable_length">
													<label>
														<select id="targetCategory" name="targetCategory" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
                                                            <c:forEach var="pType" items="${PostingType.values()}" >

                                                                ${postingType.allowTitle}, ${postingType.allowDescription}, ${pType.allowTitle}, ${pType.allowDescription}
                                                                <c:if test="${pType ne PostingType.magazine && pType ne PostingType.guidebook &&  postingType ne pType
                                                                    && (
                                                                         (pType.allowTitle eq postingType.allowTitle && pType.allowDescription eq postingType.allowDescription)
                                                                                || ((postingType.allowTitle && pType.allowTitle != false ) && (postingType.allowDescription  && pType.allowDescription != false  )))
                                                                    }">
                                                                    <option value="<c:out value="${pType.name()}" />"><c:out value="${pType.getName()}" /></option>
                                                                </c:if>
                                                            </c:forEach>
															<%--<option value="guidebook">가이드북</option>
															<option value="question">이름이 모야</option>
															<option value="clinic">식물 클리닉</option>
															<option value="bragging">자랑하기</option>--%>
														</select>
													</label>
												</div>
											</div>
											<div class="col-sm-2 text-left">
												<div class="btn-group">
													<button class="btn btn-catetory btn-sm" type="button" id="moveCategory">
														<span>카테고리 이동 </span>
													</button>
												</div>
											</div>
											<div class="col-sm"></div>
										</div>
                                    </c:if>

									</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                </form>
                <!-- 매거진 관리 -->
            </div>
        </div>

    <script src="/static/assets/js/jquery.mentiony.js"></script>
	<script type="text/javascript">
    setMenuName('${menuName}');

    $("form[name=posting_add_form] input[name='poster").off("change").on("change", btnFileActionPoster);
    $("form[name=posting_modify_form] input[name='poster").off("change").on("change", btnFileActionPoster);

    var fileRepeaterDiv;
    function bindMentiony() {
        $('textarea#commentText').mentiony({
            onDataRequest: function (mode, keyword, onDataRequestCompleteCallback) {

                var postingId = $('#posting_detail_modal_dialog input[name="postingId"]').val();
                var filterParam = postingId + (keyword) ? '&q='+keyword : '';
                $.ajax({
                    method: 'GET',
                    url: 'rest/getMentions?posting_id='+ postingId + filterParam,
                    dataType: 'json',
                    success: function (response) {
                        var result = response;
                        if(result.resultCode != 1000) {
                            alert(result.resultMsg);
                        }

                        var data = result.resultData;
                        // NOTE: Assuming this filter process was done on server-side
                        data = jQuery.grep(data, function( item ) {
                            return item.nickname.toLowerCase().indexOf(keyword.toLowerCase()) > -1;
                        });
                        // End server-side
                        // Call this to populate mention.
                        onDataRequestCompleteCallback.call(this, data);
                    }
                });
            },
            timeOut: 500,
            debug: 1
        });
    }



    var needyPosting = '${needyPosting}';
    var requestUrl = needyPosting == 'true' ? '/rest/getNeedyPostingList' : '/rest/getPostingList';

    var prevCommentId = 0;
    $(document).ready(function(){

        //READY START > END

        $('[data-toggle="tooltip"]').tooltip({
            html: true
        });

        $(document).on('change', '.custom-file-input', function (event) {
            $(this).next('.custom-file-label').html(event.target.files[0].name);
        })

        $("textarea.autosize").on('keydown keyup', function () {
            $(this).height(1).height( $(this).prop('scrollHeight')+12 );
        });

        fileRepeaterDiv = $('.file-repeater').repeater({
            show: function () {
                var count = $(this).parent()[0].childElementCount;
                if(15 < count){
                    $(this).remove();
                    return;
                }
                //alert('add');
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

        $('#btn-blind-posting').on('click', function(e){
            //alert('blink');
            var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
            var blind =$('#posting_detail_modal form[name=posting_detail_form] input[name=blind]').val();
            var btnText = (blind == true) ? '숨김해제' : '숨김';
            $(this).text(btnText);
            console.log('btn blind', blind);
            blindPosting(postingId, blind != 'true');
        });

        $('#btn-delete-posting').on('click', function(e){
            //alert('blink');
            var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
            deletePosting(postingId);
        });

        $('#btn-copy-posting').on('click', function(e){
            //alert('blink');
            var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
            copyPosting(postingId);
        });

        $('#test_noti').on('click', function(e){
            var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
            sendTestNotification(postingId);
        });

        $('#regist_noti').on('click', function(e){
            var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
            resitNotification(postingId);
        });


        var table = $('.zero-configuration').DataTable({
            dom:
                "<'row'<'col-sm-0 text-left'l><'col-sm-8 text-left'f><'col-sm'><'col-sm-2'B>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-4'i><'col-sm-8'p>>",
            buttons: [
                <c:if test="${contentWriteAllowed}">
                {
                    text: '${menuName} 등록',
                    className: 'btn First',
                    action: function ( e, dt, node, config ) {
                        $('#posting_add_modal').modal('show');
                        changeScroll(true);

                        initInput();
                    }
                }
                </c:if>
            ],
            language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
            ajax : {
                "url": requestUrl,
                "data": function(d) {
                    d.posting_type = '${postingType.name()}'
                    //사용자 필터 조건
                    d.user = $('#postingtable_filter input[name="user"]').val();
                    d.target = $('#postingtable_filter select[name="target"]').val();
                },
                "dataSrc": function ( json ) {
                    if(json.resultCode && json.resultCode == 9000) {
                        alert('에러가 발생했습니다 (' + json.resultMsg + ')');
                        return [];
                    }
                    return json.data;
                }
            },
            'serverSide' : true,
            "processing" : true,
            // "createdRow": function( row, data, dataIndex){
            // 	$('td', row).eq(1).addClass('boldcolumn');
            // },
            columns: [
                <c:if test="${moveCategoryAllowed}">
                { data : "id",
                    render: function (data, type, row, meta){

                        return '<input type="checkbox" name="postingId" value="' + data + '">';
                    },
                    searchable: false, orderable: false,
                    className: 'dt-body-center'
                },
                </c:if>
                { data : "id",
                	searchable: false, orderable: false
                },
                { data: "orgAttachments", render: function(data, type, row){
                        var setting = '?d=50x50';
                        var style = 'width: 50px;height: 50px;padding: 0rem;';
                        if(row.orgPosters && row.orgPosters.length > 0) {
                            var itemEl = getImgSrc(row.orgPosters[0].photoUrl , setting, style);
                            return itemEl;
                        } else {
                            var itemEl = getImgSrc((data && data.length > 0) ? data[0].photoUrl : "static/img/moyamo-logo.png", setting, style);
                            return itemEl;
                        }
                    },
                    searchable: false, orderable: false
                },
                <c:if test="${postingType.allowTitle eq true}">
                { data: "title", orderable: false},
                </c:if>

                { data: "orgText"  , render: function ( data, type, row ) {
                        return (data && data.length < 30) ? data : data.substr( 0, 30 ) + " ...";
                    },
                    searchable: false, orderable: false
                },
                { data: "owner.nickname", render: function(data, type, row, meta) {

                    var text = '사용자ID:' + row.owner.id;

                    return '<span alt="'+ text + '" title="'+ text +'">' + data + '</span>';

                    },orderable: false},
                { data: "readCount", searchable: false, orderable: false},
                { data: "likeCount", searchable: false, orderable: false},
                { data: "commentCount", searchable: false, orderable: false},
                { data: "createdAt" ,
                    render: function(data, type, row, meta){
                        return moment(data).format('YYYY-MM-DD HH:mm:ss')
                    },
                    searchable: false, orderable: false
                },
                { data: "isBlind", render: function(data, type, row, meta){
                        if (data == true) {
                            return '<span class="badge badge-danger" style="cursor: unset;width: 48px;">차 단</span>';
                        } else {
                            return (row.reportCount == 0) ? "-" : row.reportCount;
                        }
                    },
                    searchable: false, orderable: false
                }
            ]
        });

        //사용자 입력 input / 검색버튼 추가.
        if($('#postingtable_filter label:first input[name="user"]').length == 0) {

            var queryTargets = '<select style="width:120px;float:left;"  class="form-control form-control-sm" name="target">' +
                '<option value="">일반</option><option value="title_not_analyzed_text">제목</option>' +
                '<option value="posting_text">내용</option>' +
                '<option value="comments.comment_not_analyzed_text,comments.children.comment_not_analyzed_text">댓글</option>' +
                '<option value="attachments.attachment_korean_description">사진설명</option>' +
                '</select>'

            $("#postingtable_filter label:first").prepend(queryTargets);

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
        $('#postingtable_filter input[name!="user"]')
            .unbind() // leave empty here
            .bind('input', function(e){ //leave input
                var item = $(this);
                searchWait = 0;
                if(this.value.length >= 3 || e.keyCode == 13) {
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
        $('.zero-configuration tbody').on('click', 'td', function (e) {
            console.log('target', e.currentTarget);
            if($(e.currentTarget).hasClass("sorting_1")) {
                //e.preventDefault();
                return;
            }

            //if('boldcolumn' == $(this)[0].className.trim()){
            fileRepeaterDiv.setList([]); // reapeater 초기화
            $('#posting_detail_modal').modal('show');
            //var data = table.row( $(this) ).data();
            var dataSet = table.row( $(this).parent() ).data();
            //modifyView(dataSet);
            detailView(dataSet);
            //}
        });

        function initInput() { // 등록 init
            $(".custom-file label").empty().html("파일을 선택해주세요.");
            $(".custom-file .poster-label").empty().html("포스터 사진 선택");
            $(".viewPoster:eq(0)").empty();
            $("#youtubeUrl").val("");
            $("#title").val("");
            $(".form-group textarea").val("");
            $("#goodsNo").val("");

            //매거진까지 init
            $(".view:eq(0)").empty();
        }


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
                        var repeater = fileRepeaterDiv;
                        return function fn() {
                            repeater.setList([]);
                            //TODO 초기화 library 영역에서 처리할 수는 없나?
                            $("form[name=posting_add_form] input[name='title']").val("");
                            $("form[name=posting_add_form] textarea[name='text']").val("");
                            $("form[name=posting_add_form] input[name='goodsNo']").val("");
                            $("form[name=posting_add_form] div[data-repeater-item]").remove();
                            $("form[name=posting_add_form] button[data-repeater-create]").click();

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

        $('#moveCategory').on('click', function(e){
            if (confirm('컨텐츠를 이동하시겠습니까?')) {
                var form = $('#posting_category_form')[0];
                table.$('input[type="checkbox"]').each(function(){
                    if(!$.contains(document, this)){
                        if(this.checked){
                            $(form).append($('<input>').attr('type', 'hidden').attr('name', this.name).val(this.value));
                        }
                    }
                });
                console.log("Form submission", $(form).serialize());
                //$('#posting_category_form').submit();
                doRestApi('#posting_category_form');
                e.preventDefault();
            } else {
                return false;
            }
        });


        $('#select-all').on('click', function(){
            // Get all rows with search applied
            var rows = table.rows({ 'search': 'applied' }).nodes();
            // Check/uncheck checkboxes for all rows in the table
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
        });

        $('#youtube-meta-btn').on('click', function(e) {
            var url = $('#youtubeUrl').val();
            loadYoutubeMeta(url);
        });

        //READY END
    });

    function makereply(postingId, commentId) {
        $('#comment-'+commentId).toggle();
    }

    function blindComment(postingId, commentId, blind) {
        event.preventDefault();
        //var form = $('#posting_detail_form')[0];
        var data = new FormData();
        //$("#btnSubmit").prop("disabled", true);
        data.append("commentId", commentId);
        data.append("blind", blind);
        var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/"+postingId+"/blindComments",
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

    function blindPosting(postingId, blind) {
        console.log('blindPosting', blind);
        var message = (blind == true) ? '숨김처리하시겠습니까?' : '숨김해제하시겠습니까?';
        if(!confirm(message)) {
            return;
        }

        var data = new FormData();
        //$("#btnSubmit").prop("disabled", true);
        data.append("blind", blind);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/"+postingId+"/blindPosting",
            data: data,
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
                    $('#posting_detail_modal form[name=posting_detail_form] input[name=blind]').val(blind);
                    var btnText;
                    var resultMessage;
                    if(blind == true) {
                        btnText = '숨김해제';
                        resultMessage = '숨김처리되었습니다';
                    } else {
                        btnText = '숨김';
                        resultMessage = '숨김해제되었습니다';
                    }
                    alert(resultMessage);
                    $('#btn-blind-posting').text(btnText);
                }, 500);
            },
            error: function (e) {
                alert(e);
            }
        }).done(function() {
            console.log('blindPosting done' + postingId);
        });
    }

    function deletePosting(postingId) {

        if(!confirm('삭제하시겠습니까?')) {
            return;
        }

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/"+postingId+"/deletePosting",
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

    function copyPosting(postingId) {

        if(!confirm('복사하시겠습니까?')) {
            return;
        }

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/"+postingId+"/copyPosting",
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
                    $('.zero-configuration-wait').DataTable().ajax.reload(null, false);
                    alert('복사되었습니다. 목록에 보이지 않을 경우 새로고침 해보세요.');
                }, 3000);
            },
            error: function (e) {
                alert(e);
            }
        }).done(function() {
            console.log('copyPosting done' + postingId);
        });
    }

    // function mentionContentToText(commentId) {
    //     var selector = (commentId) ? '#comment-' + commentId : '#comment';
    //     var html = $('.mentiony-content', selector).html();
    //     var $html = $(html);
    //     var mentionLinks = $html.find('.mentiony-link');
    //     if(mentionLinks.length) {
    //         for(var i = 0 ; i < mentionLinks.length ; i++) {
    //             var id = $(mentionLinks[i]).attr('data-item-id');
    //             $(mentionLinks[i]).text('@[' + id + ']');
    //         }
    //         return $html.text();
    //     } else {
    //         var text = $html.text();
    //         if(text) {
    //             return text;
    //         } else {
    //             return html;
    //         }
    //     }
    //     //console.log('text : ', $('.mentiony-content', selector).text());
    // }

    var workCreateReply = false;
    function createReply(postingId, commentId) {
        event.preventDefault();
        if(workCreateReply) {
            alert('처리중 입니다. 잠시만 기다려주세요.');
            return;
        }

        var form = $('#posting_detail_form')[0];
        //var data = new FormData(form);
        workCreateReply = true;
        var data = new FormData();

        data.append('replyFile', $('#replyFile', '#comment-' + commentId)[0].files[0])
        data.append('commentText', mentionContentToText(commentId));
        data.append("commentId", commentId);

        //$("#btnSubmit").prop("disabled", true);
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
                if(data.resultCode && data.resultCode == 9000) {
                    alert(data.resultMsg);

                    return;
                }

                setTimeout(function(){
                    getComments(postingId, 0);
                    if(needyPosting == 'true') {
                        $('.zero-configuration').DataTable().ajax.reload(null, false);
                    }
                }, 500);
            },
            error: function (e) {
                alert(e);
            }
        }).done(function() {
            console.log('createReply done');
            workCreateReply = false;
        });
    }

    var workCreateComment = false;
    function saveComment() {

        event.preventDefault();
        if(workCreateComment) {
            alert('처리중 입니다. 잠시만 기다려주세요.');
            return;
        }


        workCreateComment = true;
        var form = $('#posting_detail_form')[0];
        //var data = new FormData(form);

        var data = new FormData();

        data.append('commentFile', $('#commentFile', '#comment')[0].files[0])
        data.append('commentText', mentionContentToText());
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

                if(data.resultCode && data.resultCode == 9000) {
                    alert(data.resultMsg);
                    return;
                }

                setTimeout(function(){
                    getComments(postingId, 0)
                    if(needyPosting == 'true') {
                        $('.zero-configuration').DataTable().ajax.reload(null, false);
                    }
                }, 500);
            },
            error: function (e) {
                alert(e);
            }
        }).done(function() {
            console.log('saveComment done');
            workCreateComment = false;
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

    function modifyView(dataSet) {
        changeScroll(true);
        $('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);
        $('#posting_modify_modal form[name=posting_modify_form] textarea[name=text]').empty().val(dataSet.orgText);
        $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').empty().val(dataSet.id);

        if(dataSet.goodses != null && dataSet.goodses.length > 0) {
            $('#posting_modify_modal form[name=posting_modify_form] input[name=goodsNo]').empty().val(dataSet.goodses[0].goodsNo);
        }
        //$('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);

        if(dataSet.orgPosters && dataSet.orgPosters.length > 0) {
            var setting = '';
            var style = 'width: 100%;margin-top: 10px;';
            var itemEl = getImgSrc(dataSet.orgPosters[0].photoUrl , setting, style);
            $('#posting_modify_modal form[name=posting_modify_form]').parent().find(".viewPoster:eq(0)").empty().prepend(itemEl);
        }

        if(dataSet.youtubeUrl) {
            $('#posting_modify_modal form[name=posting_modify_form] input[name=youtubeUrl]').val(dataSet.youtubeUrl);
        }

        /* var count = $(this).parent()[0].childElementCount;
        console.log($("#posting_modify_modal form[name=posting_modify_form] input[name^='repeater-list'").parent()[0].childElementCount); */
        //$('.delete_photo').click();
        for(var i=0; i < dataSet.orgAttachments.length; i++){
            $('.add_photo').click();
            var setting = '';
            var style = 'width: 100%;margin-top: 10px;';
            var imgSrc = getImgSrc(dataSet.orgAttachments[i].photoUrl, setting, style);
            //console.log(imgSrc);
            $("#posting_modify_modal form[name=posting_modify_form] input[name='repeater-list["+i+"][files]'").parent().find(".view:eq(0)").empty().prepend(imgSrc);
            $("#posting_modify_modal form[name=posting_modify_form] textarea[name='repeater-list["+i+"][descriptions]'").val(dataSet.orgAttachments[i].description);
            $("#posting_modify_modal form[name=posting_modify_form] input[name='repeater-list["+i+"][id]'").val(dataSet.orgAttachments[i].id);
        }
        $('#posting_modify_modal').modal('handleUpdate');
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

    function btnFileAction(e){
        //파일 선택후 element 만들기
        var itemEl = getDisplayItem(URL.createObjectURL(this.files[0]), "img");
        $(this).parent().find("#modify_id").val("");
        $(this).parent().find(".view:eq(0)").empty().prepend(itemEl);
    }


    function btnFileActionPoster(e){
        //파일 선택후 element 만들기
        var itemEl = getDisplayItem(URL.createObjectURL(this.files[0]), "img");
        //파일 미리보기
        $(this).parent().find(".viewPoster:eq(0)").empty().prepend(itemEl);
        $(this).parent().parent().find("#thunbnailUrl").val('');
    }

    function findLastChild(parentNode) {
        lastNode = parentNode.lastChild;
        while (lastNode.nodeType != 1) {
            lastNode = lastNode.previousSibling;
        }
        return lastNode;
    }

    $('#detail_to_modify', 'body').on('click', function () {
        changeScroll(true);
        $('#posting_detail_modal').modal('hide');
        $('#posting_modify_modal').modal('show');
        return false;
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

    $('#delete', 'body').on('click', function () {
        if (confirm('삭제하시겠습니까?')) {
            var postId = $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').val();
            // $('#posting_modify_form').attr('action', "/admin/deletePosting").submit();

            var callback = (function() {
                return function fn() {
                    posting_wait_reload();
                };
            })();

            doRestApi('#posting_modify_form', '/admin/deletePosting', callback);
        }
    });

    function changeScroll(isBody, target) {
        console.log('changeScroll', isBody);
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
                $('#posting_add_modal').css({"overflow-y":"auto"});
                $('#posting_modify_modal').css({"overflow-y":"auto"});
                $('#posting_detail_modal').css({"overflow-y":"auto"});
            } else {
                $("body").css({"overflow-y":"auto"});
                $('#posting_add_modal').css({"overflow-y":"hidden"});
                $('#posting_modify_modal').css({"overflow-y":"hidden"});
                $('#posting_detail_modal').css({"overflow-y":"hidden"});
            }
        }



    }
    // $("#notification_modal").draggable();
    // $("#posting_detail_modal_dialog").draggable();
    // $("#posting_modify_modal_dialog").draggable();
    // $("#posting_add_modal_dialog").draggable();
    function sendTestNotification() {
        event.preventDefault();
        var form = $('#notification_form')[0];
        var data = new FormData(form);
        //$("#btnSubmit").prop("disabled", true);
        var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
        var dateTime = data.get("year") + data.get("month") + data.get("day") + data.get("time") + data.get("minute");
        data.append("dateTime", dateTime);
        if (confirm('테스트 발송하시겠습니까?')) {
            data.append("postingId", postingId);
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/rest/notification/testSend",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    $('#regist_noti').prop('disabled', false);
                    $('#modify_noti').prop('disabled', false);
                },
                error: function (e) {
                    alert(e);
                }
            });
        }
    }

    function findGoods(o) {
        var input = $(o).parent().parent().parent().find('input[name=goodsNo]');
        var goodsNo = input.val();
        if(goodsNo == '') {
            alert('상품번호를 입력해주세요.');
            input.focus();
            return ;
        }


        var data = new FormData();
        data.append("id", goodsNo);
        $.ajax({
            type: "POST",
            url: "/rest/goods/detail",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                if(data.status == 'ok') {
                    alert(data.detail.name + '(' + data.detail.discountedPrice + '원)');
                } else {
                    alert('등록되지 않은 상품입니다. 조회는 쇼핑몰 등록 후 최대 10분 소요됩니다.')
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }


    /* 알림 등록 버튼 클릭, 동작 */
    function resitNotification(postingId){
        event.preventDefault();

        var form = $('#notification_form')[0];
        var data = new FormData(form);
        //var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();

        //new date(year, month....) month = 0 -> 1월, 11 -> 12월
        var split_datepicker = data.get("notificationDatepicker").split("-");
        var date = new Date(split_datepicker[0], split_datepicker[1]-1, split_datepicker[2], data.get("time"), data.get("minute"));

        if (confirm('알림을 등록 하시겠습니까?')) {
            data.append("reserved", $('#reserved').is(":checked"));
            data.append("reservedTime", $('#reserved').is(":checked") == true ? date.toUTCString() : (new Date()).toUTCString());
            data.append("postingId", postingId);

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/rest/notification/regist",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    $('.zero-configuration').DataTable().ajax.reload(null, false);
                    $('#notification_modal').modal('hide');
                    alert('알림 등록이 완료되었습니다');
                },
                error: function (e) {
                    console.log(e);
                }
            });
        }
    }




</script>

<script type="text/javascript">

function posting_wait_reload(){
	setTimeout(function() {
		if(posting_wait_view){
	    	//대기 상태 허용한 postingType만
	        $('.zero-configuration-wait').DataTable().ajax.reload(null, false);
	    }
		$('.zero-configuration').DataTable().ajax.reload();
   }, 1000);


}

function posting_show(postingId){
	var showFlag = confirm('해당 게시물이 노출 됩니다.');
	if(!showFlag){
		return;
	}

	console.log("postingId : " + postingId)
	$.ajax({
        type: "POST",
        url: '/rest/showPosting/${postingType.name()}_wait/'+postingId,
        data: null,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
			console.log(data);
			posting_wait_reload();

        },
        error: function (e) {
        	alert('실패');
            console.log(e);
        }
    });
}


function posterAction(url, callback) {
    var itemEl = getDisplayItem(url, "img");
    callback(itemEl);
}

//글 등록 전 대기 활성화
var posting_wait_list = ['magazine', 'television', 'free', 'boast'];
var posting_wait_view = false;

for(var index in posting_wait_list){
	var postingTypeName = '${postingType.name()}';
	if(postingTypeName == posting_wait_list[index]){
		posting_wait_view = true;
		$('#table-responsive-wait').show();
		$('input[name="postingType"]').val(postingTypeName + '_wait');
	}
}

if(posting_wait_view){
	var table_wait = $('.zero-configuration-wait').DataTable({
		lengthMenu: [3, 5, 10, 25, 50, 75, 100 ],
	    dom:
	        "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'><'col-sm-2'B>>" +
	        "<'row'<'col-sm-12'tr>>" +
	        "<'row'<'col-sm-4'i><'col-sm-8'p>>",
	    buttons: [],
	    searching: false,
	    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
	    ajax : {
	        "url":'/rest/getPostingList',
	        "data":{
	            "posting_type":'${postingType.name()}' + '_wait'
	        },
	        "dataSrc": function ( json ) {
	            if(json.resultCode && json.resultCode == 9000) {
	                alert('에러가 발생했습니다 (' + json.resultMsg + ')');
	                return [];
	            }
	            return json.data;
	        }
	    },
	    'serverSide' : true,
	    "processing" : true,
	    // "createdRow": function( row, data, dataIndex){
	    // 	$('td', row).eq(1).addClass('boldcolumn');
	    // },
	    columns: [
                <c:if test="${moveCategoryAllowed}">
                { data : "id",
                    render: function (data, type, row, meta){

                        return '<input type="checkbox" name="postingId" value="' + data + '">';
                    },
                    orderable: false,
                    className: 'dt-body-center'
                },
                </c:if>
                { data : "id",
                    orderable: false
                },
                { data: "orgAttachments", render: function(data, type, row){
                        var setting = '?d=50x50';
                        var style = 'width: 50px;height: 50px;padding: 0rem;';
                        if(row.orgPosters && row.orgPosters.length > 0) {
                            var itemEl = getImgSrc(row.orgPosters[0].photoUrl , setting, style);
                            return itemEl;
                        } else {
                            var itemEl = getImgSrc((data && data.length > 0) ? data[0].photoUrl : "static/img/moyamo-logo.png", setting, style);
                            return itemEl;
                        }
                    },
                    orderable: false
                },
                <c:if test="${postingType.allowTitle eq true}">
                { data: "title", orderable: false},
                </c:if>

                { data: "orgText"  , render: function ( data, type, row ) {
                        return (data && data.length < 30) ? data : data.substr( 0, 30 ) + " ...";
                    },
                    orderable: false
                },
                { data: "owner.nickname", orderable: false},
                { data: "createdAt" ,
                    render: function(data, type, row, meta){
                        return moment(data).format('YYYY-MM-DD HH:mm:ss')
                    },
                    searchable: false, orderable: false
                },
                { data: "isDelete", render: function(data, type, row, meta){
                    	return '<span id="posting_show" onClick="javascript:posting_show('+row.id+');" class="badge badge-primary ignoreClick" style="cursor: unset;width: 48px;">개시</span>';
                    },
                    orderable: false
                }
            ]
	});

	//** Row 클릭 **//
    $('.zero-configuration-wait tbody').on('click', 'td', function (e) {
        if($(e.currentTarget).find('#posting_show').hasClass("ignoreClick")) {
            return;
        }

        fileRepeaterDiv.setList([]); // reapeater 초기화
        $('#posting_detail_modal').modal('show');
        var dataSet = table_wait.row( $(this).parent() ).data();
        detailView(dataSet);
    });
}

function loadYoutubeMeta(url){

    $.ajax({
        type: "GET",
        url: '/rest/postings/youtube?url=' + encodeURI(url),
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
            console.log(data);
            if(data.resultCode === 1000) {
                posterAction(data.resultData.thumbnail_url, function(el) {
                    $('#posting_add_modal').find(".viewPoster:eq(0)").empty().prepend(el);
                });
                //
                $('#posting_add_form').find('.custom-file-label').html('파일을 선택해주세요.');
                $('#posting_add_form #thunbnailUrl').val(data.resultData.thumbnail_url);
                $('#posting_add_form #title').val(data.resultData.title);

            } else {
                alert( '동영상 정보를 가져올 수 없습니다. ');
            }
        },
        error: function (e) {
            alert('실패');
            console.log(e);
        }
    });
}

</script>
