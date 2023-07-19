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

	#sortable, #sortable2 {
		height: 40px;
	}

	.home-title {
		font-weight: bold;
		font-size: 14px;
	}

	.home-title {

	}

	.home-title.add {
		color: rgba(0, 100, 255, 0.82);
	}

	.home-title.remove {
		color: rgba(255, 0, 0, 0.82);;
	}

	tbody:after {
		content: "";
	}

    </style>
    <!-- END: Custom CSS-->

        <!-- BEGIN: Content-->
        <div class="content-wrapper">

            <div class="content-body">
                <section id="configuration">
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-content collpase show">
									<div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
										<div class="fixed-table-body" style="padding-top:15px">

											<div class="fixed-table-toolbar" style="height: 45px">
												<div class="bs-bars float-left">
													<div class="dt-buttons btn-group" style=";">
														<button class="btn btn-secondary btn-custom-info First" tabindex="0" aria-controls="postingtable" type="button" id="initBtn" disabled="disabled"><span>취소</span></button>
													</div>
													<div class="dt-buttons btn-group" style="margin-right:10px;">
														<button class="btn btn-secondary btn-custom-info First" tabindex="0" aria-controls="postingtable" type="button" id="orderBtn" disabled="disabled"><span>저장</span></button>
													</div>
												</div>
												<div class="bars pull-left">
													<div id="toolbar">

													</div>
												</div>
												<div class="columns columns-right btn-group float-right" style="margin-left: 20px">

												</div>
												<div class="float-right search btn-group">
													<span>모아보기에 등록하거나 제외할 컨텐츠를 드래그&드롭으로 이동해주세요.</span>
												</div>
											</div>

											<div class="row">
												<div class="col-6 col-sm-6 col-md-6">
													<div class="home-title add">등록할 컨텐츠</div>
													<!-- filter -->
													<table id="table" data-pagination="true" data-search="true" data-show-toggle="true" data-use-row-attr-func="true" data-reorderable-rows="true" data-url="json/data1.json" class="table table-bordered table-hover ">
														<thead>
														<tr>
															<th style="" data-field="name">
																<div class="th-inner sortable both">제목</div><div class="fht-cell"></div>
															</th>
														</tr>
														</thead>
														<tbody class="connected" id="sortable" data-sortable-id="0" aria-dropeffect="move">
														</tbody>
													</table>
												</div>
												<div class="col-6 col-sm-6 col-md-6">
													<div class="home-title remove">제외할 컨텐츠</div>
													<table id="table2" data-pagination="true" data-search="true" data-show-toggle="true" data-use-row-attr-func="true" data-reorderable-rows="true" data-url="json/data1.json" class="table table-bordered table-hover ">
														<thead>
														<tr>
															<th style="" data-field="name">
																<div class="th-inner sortable both">제목</div><div class="fht-cell"></div>
															</th>
														</tr>
														</thead>

														<tbody class="connected" id="sortable2" data-sortable-id="0" aria-dropeffect="move">

														</tbody>
													</table>
												</div>
											</div>
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

	var genres = {
		"magazine" : "매거진",
		"question" : "이름이모야",
		"photo" : "포토",
		"banner" : "배너",
		"television" : "모야모TV",
		"clinic" : "클리닉",
		"goods" : "오늘의 추천상품",
		"free" : "자유수다",
		"guidebook" : "가이드북",
		"boast" : "자랑하기"
	};

	$(document).ready(function(){
		$( "#sortable, #sortable2" ).sortable({
			connectWith: '.connected',

			create: function(event, ui) {
				//console.log('create : ', event);
			},
			change: function(event, ui) {
				//console.log('change: '+ui.item.index(), 'origin : ' + ui.originalPosition, 'position : ' + ui.position);
			},
			start: function(event, ui) {
				//console.log('start: ' + ui.item.index())
			},
			update: function(event, ui) {
				console.log('update ', 'data-id : ', ui.item.attr('data-id'), ', index : ' + ui.item.index())
				if(ui.item.attr('data-index') != ui.item.index() || $(event.target).attr('id') != ui.item.attr('data-status')) {
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
					$('#initBtn').prop('disabled', false);
				} else {
					console.log('변경안됨')
					$('#orderBtn').prop('disabled', true);
					$('#initBtn').prop('disabled', true);
				}
			}
		});
		$( "#sortable" ).disableSelection();

		/* 상단 타이틀 변경 */
		setMenuName('${menuName}');

		$('[data-toggle="tooltip"]').tooltip({
		    html: true
		});


		getHomeList();
	});

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




	function loadList(data) {
		$("#sortable").loadTemplate("#template", data.map((v, i) => {return {"title" : genres[v], "value" : v, "index" : i, "status" : "sortable"};}));
		$("#sortable2").loadTemplate("#template", Object.keys(genres).filter(v => data.includes(v) === false).map((v, i) => {return {"title" : genres[v], "value" : v, "index" : i, "status" : "sortable2"};}));
	}

	function initBtn() {
		$('#orderBtn').prop('disabled', true);
		$('#initBtn').prop('disabled', true);
	}

	function getHomeList() {

		$.ajax({
			type: "POST",
			url: "/rest/home/getAll",
			processData: false,
			cache: false,
			timeout: 600000,
			success: function (data) {
				loadList(data);
				initBtn();
			},
			error: function (e) {
				alert(e);
			}
		});
	}

	$('#orderBtn').on('click', function() {
		if(confirm('저장하시겠습니까?')) {
			updateOrder();
		}
	});

	$('#initBtn').on('click', function() {
		getHomeList();
	});


	function updateOrder() {
		var list = $('#table tbody tr').map(function(i, e) { return $(e).attr('data-set')}).toArray();
		var json = JSON.stringify(list);
		$.ajax({
			type: "POST",
			url: '/rest/home/update',
			data: json,
			processData: false,
			contentType: "application/json; charset=utf-8",
			cache: false,
			timeout: 600000,
			success: function (data) {
				if(data.resultCode === 9000){
					alert("실패");
					return false;
				} else {
					console.log(data);
					getHomeList();
				}
			},
			error: function (e) {
				alert(e);
			}
		});
	}

	</script>

<!--
http://codepb.github.io/jquery-template/index.html
-->
<script id="template" type="text/html">
	<tr data-template-bind='[{"attribute": "data-index", "value": "index", "formatter": "indexId"}, {"attribute": "data-status", "value": "status", "formatter": "dataId"}, {"attribute": "data-set", "value": "value", "formatter": "encode"}]'  class="list-item" style="">
	<td data-content="title" class="title" style="font-weight: bold;"></td>
</script>



