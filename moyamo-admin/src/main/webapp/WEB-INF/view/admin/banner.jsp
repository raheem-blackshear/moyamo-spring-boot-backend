<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-app.js"></script>
	<script src="/static/js/jquery.loadTemplate.min.js"></script>
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


	tr.moved {
		background-color: rgba(255,0,0,0.1)
	}

    </style>
    <!-- END: Custom CSS-->

        <!-- BEGIN: Content-->
        <div class="content-wrapper">
			<!-- Add Modal -->
			<!-- view Modal -->
			<div class="modal fade text-left" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-modal="true">
			<!-- <div class="modal fade text-left" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true"> -->
				<div class="modal-dialog modal-lg" role="document">
					<jsp:include page="partial/banner/view_banner_modal_content.jsp"></jsp:include>
				</div>
			</div>

            <div class="content-body">
                <section id="configuration">
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-content collpase show">
									<div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">

										<div class="fixed-table-body" style="padding-top:15px">
											<!-- filter -->
											<form id="badge-list-form" action="/admin" method="post">
												<div class="fixed-table-toolbar" style="height: 45px">
													<div class="bs-bars float-left">

														<div class="dt-buttons btn-group" style="margin-left:10px">
															<button class="btn btn-secondary btn-custom-info First" tabindex="0" aria-controls="postingtable" type="button" id="orderBtn" disabled="disabled"><span>순서 저장</span></button>
														</div>

														<div class="dt-buttons btn-group" style="margin-right:10px">
															<button class="btn btn-secondary btn-custom-info First" tabindex="0" aria-controls="postingtable" type="button" id="registBtn"><span>배너 등록</span></button>
														</div>
														<%--<div id="toolbar">
															<button id="remove" class="btn btn-danger" disabled="">
																<i class="fa fa-trash"></i> Delete
															</button>
														</div>--%>
													</div>
													<div class="bars pull-left">
														<div id="toolbar">

														</div>
													</div>
													<div class="columns columns-right btn-group float-right" style="margin-left: 20px">
														<select name="status" class="form-control">
															<option value="">전체</option>
															<option value="open">open</option>
															<option value="close">close</option>
														</select>
													</div>
													<div class="float-right search btn-group">
														<input class="form-control search-input" type="search" placeholder="Search" autocomplete="off" name="q" id="search">
													</div>
												</div>
											</form>

											<!-- filter -->
											<table id="table" data-pagination="true" data-search="true" data-show-toggle="true" data-use-row-attr-func="true" data-reorderable-rows="true" data-url="json/data1.json" class="table table-bordered table-hover ">
												<thead>
													<tr>
														<th style="" data-field="id">
															<div class="th-inner sortable both">Index</div><div class="fht-cell"></div>
														</th>
														<th style="" data-field="name">
															<div class="th-inner sortable both">ID</div><div class="fht-cell"></div>
														</th>
														<th style="" data-field="price">
															<div class="th-inner sortable both">이미지</div><div class="fht-cell"></div>
														</th>
														<th style="" data-field="price">
															<div class="th-inner sortable both">제목</div><div class="fht-cell"></div>
														</th>
														<th style="" data-field="price">
															<div class="th-inner sortable both">시작</div><div class="fht-cell"></div>
														</th>
														<th style="" data-field="price">
															<div class="th-inner sortable both">종료</div><div class="fht-cell"></div>
														</th>
														<th style="" data-field="price">
															<div class="th-inner sortable both">상태</div><div class="fht-cell"></div>
														</th>
													</tr>
												</thead>
												<tbody id="sortable" data-sortable-id="0" aria-dropeffect="move">
													<%--<c:forEach var="banner" items="${list}"  varStatus="status">
														<tr id="customId_${status.index}" data-index="${status.index}" class="list-item" style=""><td>${status.index}</td><td style="">${banner.title}</td><td>${banner.status}</td></tr>
													</c:forEach>--%>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
                </section>
            </div>


        </div>
    <!-- END: Content-->


    <script type="text/javascript">
    var prevCommentId = 0;
    var requestListUrl = '/rest/banner/getList';
    var registBtnName = '배너 등록'


	var a, b;
	$(document).ready(function(){

		$( "#sortable" ).sortable({
			change: function(event, ui) {
				// a = ui.item;
				// console.log('change: '+ui.item.index(), 'origin : ' + ui.originalPosition, 'position : ' + ui.position);
			},
			start: function(event, ui) {

				// console.log('start: ' + ui.item.attr('data-id'));
				// console.log('start: ' + ui.item.index())
			},
			update: function(event, ui) {
				console.log('update ', 'data-id : ', ui.item.attr('data-id'), ', index : ' + ui.item.index())

				if(ui.item.attr('data-index') != ui.item.index()) {
					console.log('인덱스 변경됨');


					ui.item.addClass('moved');
				} else {
					console.log('인덱스 같음');

					ui.item.removeClass('moved');
				}

				if($('tr.moved').length > 0) {
					//이동된게 있으면 버튼 활성화
					console.log('변경됨')
					$('#orderBtn').prop('disabled', false);
				} else {
					console.log('변경안됨')
					$('#orderBtn').prop('disabled', true);
				}
			}
		});
		$( "#sortable" ).disableSelection();

		$("form").submit(function(e){
			e.preventDefault();
			console.log('submit');
			getBannerList();
		});



		/* 상단 타이틀 변경 */
		setMenuName('${menuName}');

		$('[data-toggle="tooltip"]').tooltip({
		    html: true
		});


		getBannerList();

		 //** Row 클릭 **//
	    $('table tbody').on('click', 'td', function () {

	    	console.log('tr', $(this)[0], $(this).parent()[0]);

	    	if('title' == $(this)[0].className.trim()){
	    		$('#detail_modal').modal('show');

	        	//var dataSet = table.row( $(this).parent() ).data();

				;
				var dataSet = JSON.parse(decodeURI($(this).parent().attr('data-set')));
				console.log('dataSet : ', dataSet);

	        	detailView(dataSet);
	    	}
	    });

	});

	/* 달력, 시간 2disit 맞추기 */
	function getDisit(target){
		return ("0" + target).slice(-2);
	}

	function initBanner(target){
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

	function detailSetDatepicker(data, form, targetPicker){
		var start = new Date(moment(data).format('YYYY-MM-DD HH:mm:ss'));
		$(form + ' ' + targetPicker).datepicker().datepicker("option", "minDate", new Date(0));
		$(form + ' ' + targetPicker).datepicker().datepicker("setDate", start);

		// var startHour = getDisit(start.getHours());
		// var startMinute = getDisit(start.getMinutes());
		//
		// $(form + ' ' + targetTime).val(startHour);
		// $(form + ' ' + targetMinute).val(startMinute);
	}

	function changeViewByResource(resource) {

		changeViewByResourceType(resource.resourceType);
		changeViewByResourceId(resource.resourceId);
	}

	function initResourceView() {
		$('#resourceType').val('magazine').trigger('change');
		$('#resourceSelector').css('display', 'none');
		$('#resourceId').val('');
	}

	function changeViewByResourceId(resourceId) {
		$('#resourceSelector').val(resourceId).trigger('change');
		$('#resourceId').val(resourceId);
	}

	function changeViewByResourceType(resourceType) {

		console.log('resourceType : ', resourceType);
		$('#resourceType').val(resourceType);
		if(resourceType === 'magazine' || resourceType === 'question' || resourceType === 'clinic' ||resourceType === 'boast' || resourceType === 'free') {
			// 2차 select box 감추기
			// input 만 노출하고 게시글 ID 를 입력하도록한다.

			$('#resourceSelector').css('display', 'none');
			$('#resourceId').prop('display', false);
			$('#resourceId').attr('placeholder', '게시글ID 를 입력해주세요.');
			$('#resourceId').val("");

		} else if(resourceType === 'shop') {
			// 2차 select box 보이기
			$('#resourceSelector').css('display', '');
			$('#resourceSelector').val('home').trigger('change');

			// input 만 노출하고 goodsCd 또는 cateCd 입력하도록한다.
			$('#resourceSelector').css('display', '');
			$('#resourceId').val("");
			$('#resourceId').attr('placeholder', 'goodsNo 또는 cateCd 를 입력해주세요.');

		} else if(resourceType === 'web') {
			// 2차 select box 감추기
			$('#resourceSelector').css('display', 'none');

			// input 만 노출하고 URL을 입력하도록한다.
			$('#resourceId').val("");
			$('#resourceId').prop('hidden', false);
			$('#resourceId').attr('placeholder', 'URL을 입력해주세요.');

		} else {

			throw '지원하지 않는 resourceType : (' + resourceType + ')';
		}
	}

	$('#resourceType').on('change', function(e) {
		var resourceTypeEl = e.target;
		changeViewByResourceType(resourceTypeEl.value);
	});

	$('#resourceSelector').on('change', function(e) {
		var resourceSelectorEl = e.target;
		console.log('resourceSelector', resourceSelectorEl, '  ', resourceSelectorEl.value);
		if($('#resourceType').val() === 'shop' && resourceSelectorEl.value === 'home') {
			$('#resourceId').css('display', 'none');
			$('#resourceId').val('home');
		} else if($('#resourceType').val() === 'shop' && resourceSelectorEl.value === 'goodsNo') {
			$('#resourceId').css('display', '');
			$('#resourceId').val('goods/{입력}');
		} else {
			$('#resourceId').css('display', '');
			$('#resourceId').val('');
		}
	});

	function detailView(dataSet) {
		console.log(dataSet);

		changeViewByResource(dataSet.resource)

		$('#resourceType').prop('disabled', true);
		$('#resourceSelector').prop('disabled', true);
		$('#resourceId').prop('disabled', true);


		//예약 발송 여부
		detailSetDatepicker(dataSet.start, '#detail_form', '#startDatepicker', '#startTime', '#startMinute');
		detailSetDatepicker(dataSet.end, '#detail_form', '#endDatepicker', '#endTime', '#endMinute');

		//대상 사용자 그룹
		$('#detail_modal form[name=detail_form] input:radio[name="status"]').each(function() {

			console.log('status : ', this.value, dataSet.status);
			if(this.value == dataSet.status){ //값 비교
				$(this).click();
			}
		});

		//??
    	$('#detail_modal #bannerId').val(dataSet.id);
    	//$('#visibility').val(dataSet.visibility).trigger('change');
    	//$('#tagType').val(dataSet.tagType).trigger('change');

    	//알림 정보
    	$('#detail_modal #title').val(dataSet.title);

		//썸네일
		if(dataSet.imageResource){
			$('.custom-file-label').html(dataSet.imageResource.filename);

			var setting = '';
			var style = 'width: 100%;margin-top: 10px;';
			var imgSrc = getS3Data(dataSet.photoUrl, setting, style);
			$("#detail_modal form[name=detail_form] input[name='file'").parent().parent().find(".view:eq(0)").empty().prepend(imgSrc);
		}

		$('#regist_noti').text('배너 수정');
		$('#remove_noti').prop('disabled', false);
	}

	function initInput() {
        $('input[name="bannerId"]').val('')
        $('input[name="title"]').val('')

		$('#resourceType').prop('disabled', false);
		$('#resourceSelector').prop('disabled', false);
		$('#resourceId').prop('disabled', false);

		initResourceView();


		detailSetDatepicker(moment().format('YYYY-MM-DD'), '#detail_form', '#startDatepicker', '#startTime', '#startMinute');
		detailSetDatepicker(moment().format('YYYY-MM-DD'), '#detail_form', '#endDatepicker', '#endTime', '#endMinute');

		$('.custom-file-label').html('');
		$("#detail_modal form[name=detail_form] input[name='file'").parent().parent().find(".view:eq(0)").empty();
		$('#regist_noti').text('배너 등록');
	}

	/* aws s3에서 가져오는 데이터 element 생성 */
	function getS3Data(data, setting, style){
		var httpName = '${httpName}';
		var itemEl = '<img style="'+style+'" src="'+httpName+data+setting+'" alt="">';
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

	$.addTemplateFormatter({
		indexLink: function (value, template) {
			return "Products/" + value;
		},
		idLink: function (value, template) {
			return "Products/" + value;
		},
		dataId: function (value, template) {
			return value;
		},
		encode: function (value, template) {
			return encodeURI(value);
		},
		date : function(value) {
			return moment(value).format('YYYY-MM-DD HH:mm:ss');
		},
		thumbnail : function(value) {
			return value + '?d=x100';
		}
	});


	function getBannerList() {
		var form = $('#badge-list-form')[0];
		var data = new FormData(form);

		var param = {};
		var status = data.get('status');
		if(status !== '')
			param['status'] = status;

		var q = data.get('q');
		if(q !== '')
			param['q'] = q;


		$.ajax({
			type: "POST",
			url: "/rest/banner/getAll",
			data: "status=" + status + "&q=" + q,
			processData: false,
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			cache: false,
			timeout: 600000,
			success: function (data) {
				console.log(data);
				var index = 0;
				//인덱스 추가.

				data.forEach(l => {
					l.index = index++;
					l.dataSet = JSON.stringify(l);
				});
				$("#sortable").loadTemplate("#template", data);
			},
			error: function (e) {
				alert(e);
			}
		});
	}

	$('#registBtn').on('click', function() {
		initInput();

		$('#remove_noti').prop('disabled', true);
		$('.modal').modal('show');
	});

	$('#orderBtn').on('click', function() {
		if(confirm('순서를 변경하시겠습니까?')) {
			updateOrder();
		}

	});


	$('#detail_form #regist_noti').on('click', '', function () {

		event.preventDefault();
		var form = $('#detail_form')[0];
		var data = new FormData(form);

		var requestUrl;
		var bannerId = data.get("bannerId");
		var confirmMsg;
		if(bannerId !== "") {
			confirmMsg = '수정 하시겠습니까?';
			requestUrl = "/rest/banner/"+bannerId+"/update";
		} else {
			confirmMsg = '등록 하시겠습니까?';
			requestUrl = "/rest/banner/regist";
		}

		if (confirm(confirmMsg)) {
			event.preventDefault();

			data.append("start", data.get("startDatepicker"));
			data.append("end", data.get("endDatepicker"));
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: requestUrl,
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
						$('#search').focus();
						$('.modal').modal('hide');
						getBannerList();

					}
				},
				error: function (e) {
					alert(e);
				}
			});

		}
	});

	$('#detail_form #remove_noti').on('click', '', function () {

		event.preventDefault();
		var form = $('#detail_form')[0];
		var data = new FormData(form);

		var bannerId = data.get("bannerId");

		if (confirm('삭제 하시겠습니까?')) {
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: '/rest/banner/' + bannerId + '/remove',
				data: data,
				processData: false,
				contentType: false,
				cache: false,
				timeout: 600000,
				success: function (data) {
					if (data.resultCode == 9000) {
						alert("실패");
						return false;
					} else {
						$('.modal').modal('hide');
						getBannerList();
					}
				},
				error: function (e) {
					alert(e);
				}
			});
		}

	});

	function changeScroll(isBody) {
		if (isBody) {
			$("body").css({"overflow-y":"hidden"});
			$('#detail_modal').css({"overflow-y":"auto"});
		} else {
			$("body").css({"overflow-y":"auto"});
			$('#detail_modal').css({"overflow-y":"hidden"});
		}
	}

	function updateOrder() {
		var list = $('#table tbody tr');
		var ids = [];
		var indices = [];


		$('#table tbody tr').each(function(i, e) {
			ids.push(e.getAttribute('data-id'));
			indices.push(i);
		});

		var object = {
			"id" : ids,
			"rankOrder" : indices
		};

		var json = JSON.stringify(object);

		$.ajax({
			type: "POST",
			url: '/rest/banner/order',
			data: json,
			processData: false,
			contentType: "application/json; charset=utf-8",
			cache: false,
			timeout: 600000,
			success: function (data) {
				if(data.resultCode == 9000){
					alert("실패");
					return false;
				} else {
					console.log(data);
					getBannerList();
					$('#orderBtn').prop('disabled', true);
				}
			},
			error: function (e) {
				alert(e);
			}
		});
	}

	$('select[name=status]').on('change', function(e) {
		getBannerList();
	});

	//스크롤 전환
	$("#detail_modal").on("hidden.bs.modal", function (a, b, c) {
		// put your default event here
		changeScroll(false, a.currentTarget);
	});

	//스크롤 전환
	$("#detail_modal").on("show.bs.modal", function (a, b, c) {
		// put your default event here
		changeScroll(true, a.currentTarget);
	});

	</script>

<!--
http://codepb.github.io/jquery-template/index.html
-->
<script id="template" type="text/html">
	<tr data-template-bind='[{"attribute": "data-id", "value": "id", "formatter": "dataId"}, {"attribute": "data-index", "value": "index", "formatter": "indexId"}, {"attribute": "data-set", "value": "dataSet", "formatter": "encode"}]'  class="list-item" style="">
	<td data-content="index"<%-- data-link="index" data-format="indexLink" data-format-target="link"--%>></td>
	<td data-content="id"<%-- data-link="id" data-format="idLink" data-format-target="link"--%>></td>
	<td>
	<img data-template-bind='[{"attribute": "src", "value": "photoUrl", "formatter": "thumbnail"}]'  class="list-item" style="height: 50px"/>
	</td>
	<td data-content="title" class="title" style="font-weight: bold;"></td>
	<td data-content="start" class="title" data-format="date" style=""></td>
	<td data-content="end" class="title" data-format="date" style=""></td>
	<td data-content="status" style=""></td>
	</img>
</script>



