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
					<jsp:include page="template/view_notice_modal_content.jsp"></jsp:include>
				</div>
			</div>

			<div class="modal fade text-left" id="regist_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-modal="true">
			<!-- <div class="modal fade text-left" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true"> -->
				<div class="modal-dialog modal-lg" role="document">
					<jsp:include page="template/write_notice_modal_content.jsp"></jsp:include>
				</div>
			</div>



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
                                                        <th>제목</th>
                                                        <th>내용</th>
                                                        <th>url</th>
                                                        <!-- <th>이미지</th> -->
                                                        <th>노출시작시간</th>
                                                        <th>노출종료시간</th>
                                                        <th>interval</th>
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
    var requestListUrl = (noticeType == 'event') ? '/rest/notice/getEventList' : '/rest/notice/getNoticeList';
    var registBtnName = (noticeType == 'event') ? '이벤트 등록' : '공지 등록';


	$(document).ready(function(){
		/* 상단 타이틀 변경 */
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
	            	text: registBtnName,
	            	className: 'btn btn-custom-info First',
	                action: function ( e, dt, node, config ) {
	                	initInput();
                        var modalName = (noticeType === 'event') ? '이벤트 등록' : '공지 등록';
                        $('#regist_modal b').text(modalName);
	                	$('#regist_modal').modal("show");

	                	/* var reservedHour = getDisit((new Date()).getHours());
	            		$('#regist_form #startTime').val(reservedHour);
	            		var reservedMinute = getDisit((new Date()).getMinutes());
	            		$('#regist_form #startMinute').val(reservedMinute);

	            		$('#regist_form #title').val('');
	            		$('#regist_form #text').val('');

            			if($('#regist_form input:checkbox[name=popup_view_status]').is(":checked") == true) {
           				  $("#regist_form #popup_view").show();
           				}else{
           				  $("#regist_form #popup_view").hide();
           				} */
	                }
	            },
	        ],
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
			'ajax' : {
				"url": requestListUrl
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
	        	{ data: "description",
	        		render: function(data, type, row, meta){
	        			if($(data).text().length >= 74){
		        			return $(data).text().substring(44,74) + '...';

	        			}
	        			return $(data).text().substring(44,74);
	       			},
	       			orderable: false
        		},
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
	        	/* { data: "photoUrl",
	        		render: function(data, type, row, meta){
	        			if(!row.popup || data == undefined){
	        				return '-';
	        			}

	        			var setting = '?d=50x50';
	            		var style = 'width: 50px;height: 50px;padding: 0rem;';
	            		var itemEl = getImgSrc(data, setting, style);
	            		return itemEl;
	       			},
	       			orderable: false
        		}, */
	        	{ data: "start",
	        		render: function(data, type, row, meta){
	        			if(!row.popup){
	        				return '-';
	        			}
	        			return moment(data).format('YYYY-MM-DD HH:mm:ss');
	       			},
	       			orderable: false
        		},
	        	{ data: "end",
	        		render: function(data, type, row, meta){
	        			if(!row.popup){
	        				return '-';
	        			}
	        			return moment(data).format('YYYY-MM-DD HH:mm:ss');
	       			},
	       			orderable: false
        		},
	        	{ data: "interval",
	        		render: function(data, type, row, meta){
	        			if(!row.popup){
	        				return '-';
	        			}
		        		return data;
	       			},
	       			orderable: false
        		},
	        	{ data: "status",
	        		render: function(data, type, row, meta){
		        		return data;
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

                var modalName = (noticeType === 'event') ? '이벤트 수정/삭제' : '공지 수정/삭제';
                $('#detail_modal b').text(modalName);

                if(noticeType === 'event') {
                    $('input:checkbox[name="popup"]').each(function(i, b) {
                        b.disabled = false;
                        if (b.checked === false) {
                            b.click();
                        }
                        b.disabled = true;
                    });

                } else {
                    $('input:checkbox[name="popup"]').each(function(i, b) {
                        b.disabled = false;
                        if(b.checked === true) {
                            b.click();
                        }
                    });
                }

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
		console.log(dataSet);
		/*
    	$('#id')popup_view.val(dataSet.id);
    	$('#name').val(dataSet.name);
    	$('#url').val(dataSet.url);
    	$('#visibility').val(dataSet.visibility).trigger('change');
    	$('#tagType').val(dataSet.tagType).trigger('change'); */

		//예약 발송 여부
		detailSetDatepicker(dataSet.start, '#detail_form', '#startDatepicker', '#startTime', '#startMinute');
		detailSetDatepicker(dataSet.end, '#detail_form', '#endDatepicker', '#endTime', '#endMinute');
		/* var start = new Date(moment(dataSet.start).format('YYYY-MM-DD HH:mm:ss'));
		$('#startDatepicker').datepicker().datepicker("option", "minDate", new Date(0));
		$('#startDatepicker').datepicker().datepicker("setDate", start);

		var startHour = getDisit(start.getHours());
		var startMinute = getDisit(start.getMinutes());

		$('#detail_form #startTime').val(startHour);
		$('#detail_form #startMinute').val(startMinute);
		 */


		//대상 사용자 그룹
		$('#detail_modal form[name=detail_form] input:radio[name="status"]').each(function() {
			if(this.value == dataSet.status){ //값 비교
				this.checked = true; //checked 처리
				return false;
			}
		});

		//??
    	$('#detail_modal #noticeId').val(dataSet.id);
    	$('#detail_modal #url').val(dataSet.url);
    	$('#detail_modal #interval').val(dataSet.interval);
    	//$('#visibility').val(dataSet.visibility).trigger('change');
    	//$('#tagType').val(dataSet.tagType).trigger('change');

    	//알림 정보
    	$('#detail_modal #title').val(dataSet.title);
    	$('#detail_modal #text').val(dataSet.description);

    	if(dataSet.popup){
	    	$('#detail_modal input:checkbox[name=popup]').prop('checked', true);
            $('#detail_modal input:checkbox[name=popup]').val(true);
	    	$("#detail_form #popup_view").show();
    	}else{
    		$('#detail_modal input:checkbox[name=popup]').prop('checked', false);
            $('#detail_modal input:checkbox[name=popup]').val(false);
    		$("#detail_form #popup_view").hide();
    	}

    	$('#detail_modal #summernote').summernote('code', dataSet.description);


		//$('#summernote').summernote('destroy');
    	//타이틀
    	//$('#modal_posting_name').text(dataSet.id + ". " + dataSet.relation.posting.title);

    	//썸네일
    	/* if(dataSet.photoUrl){
	    	$('#detail_modal .custom-file-label').html(dataSet.fileName);

	    	var setting = '';
	    	var style = 'width: 100%;margin-top: 10px;';
			var imgSrc = getS3Data(dataSet.photoUrl, setting, style);
			$("#detail_modal form[name=detail_form] input[name='files'").parent().parent().find(".view:eq(0)").empty().prepend(imgSrc);

    	} */
	}

	function initInput() {
        $('input[name="id"]').val('')
        $('input[name="title"]').val('')
        $('input[name="name"]').val('')
        $('input[name="url"]').val('')

        $('.summernote').each(function(i, note) {console.log(note); $(note).summernote('code', '')});

        if(noticeType === 'event') {
            $('input:checkbox[name="popup"]').each(function(i, b) {
                b.disabled = false;
                if (b.checked === false) {
                    b.click();
                }
                b.disabled = true;
            });
        } else {
            $('input:checkbox[name="popup"]').each(function(i, b) {
                b.disabled = false;
                if(b.checked === true) {
                    b.click();
                }
            });
        }

        $('#modal_posting_name').val('menu')

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
	    if(getImgSrc) {
            var itemEl = '<img class="img-thumbnail" style="'+style+'" src="'+data+setting+'" alt="">';
            return itemEl;
        } else {
	        return "";
        }
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

	$('#detail_form #modify_noti').on('click', '', function () {
    	if (confirm('수정 하시겠습니까?')) {
	        event.preventDefault();
	        var form = $('#detail_form')[0];
	        var data = new FormData(form);
	        data.append("description", $('#detail_form #summernote').summernote('code'));

	        var split_startDatepicker = data.get("startDatepicker").split("-");
	        var startDate = new Date(split_startDatepicker[0], split_startDatepicker[1]-1, split_startDatepicker[2], data.get("startTime"), data.get("startMinute"));
            data.append("start", startDate.toUTCString());

            var split_endDatepicker = data.get("endDatepicker").split("-");
	        var endDate = new Date(split_endDatepicker[0], split_endDatepicker[1]-1, split_endDatepicker[2], data.get("endTime"), data.get("endMinute"));
            data.append("end", endDate.toUTCString());

            data.append("type", noticeType);
            data.append("popup", $('#detail_form #popup').val());

	        $.ajax({
	            type: "POST",
	            enctype: 'multipart/form-data',
	            url: "/rest/notice/modify/"+data.get('noticeId'),
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
	            url: "/rest/notice/remove/"+data.get('noticeId'),
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
	        var form = $('#regist_form')[0];
	        var data = new FormData(form);
	        data.append("description", $('#regist_form #summernote').summernote('code'));

	        var split_startDatepicker = data.get("writeStartDatepicker").split("-");
	        var startDate = new Date(split_startDatepicker[0], split_startDatepicker[1]-1, split_startDatepicker[2], data.get("startTime"), data.get("startMinute"));
            data.append("start", startDate.toUTCString());

            var split_endDatepicker = data.get("writeEndDatepicker").split("-");
	        var endDate = new Date(split_endDatepicker[0], split_endDatepicker[1]-1, split_endDatepicker[2], data.get("endTime"), data.get("endMinute"));
            data.append("end", endDate.toUTCString());

            data.append("type", noticeType);

	        $.ajax({
	            type: "POST",
	            enctype: 'multipart/form-data',
	            url: "/rest/notice/regist/",
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
	            		$('.zero-configuration').DataTable().ajax.reload();
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

	</script>

