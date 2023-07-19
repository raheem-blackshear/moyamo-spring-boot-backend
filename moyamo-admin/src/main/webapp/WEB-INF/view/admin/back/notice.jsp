<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/view/admin/common/header.jsp"%>
	 <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/ui/jquery-ui.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/tables/datatable/datatables.min.css">
    
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/toggle/bootstrap-switch.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/toggle/switchery.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/selects/select2.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/datedropper.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/timedropper.min.css">    
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/icheck/custom.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css">
<!--     <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/dragula.min.css"> -->
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/fonts/simple-line-icons/style.min.css">
    <!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/core/menu/menu-types/vertical-menu-modern.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/forms/switch.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/core/colors/palette-callout.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/ui/jqueryui.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/pages/ecommerce-shop.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/toastr.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/extensions/toastr.css">     
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/static/assets/css/style.css">
    <!-- END: Custom CSS-->
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
</head>
<body class="vertical-layout vertical-menu-modern 2-columns   fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="2-columns">
	<!-- Top -->
    <%@ include file="/WEB-INF/view/admin/common/top.jsp"%>
    <!-- Top -->

	<!-- MainMenu -->
    <%@ include file="/WEB-INF/view/admin/common/nav.jsp"%>
    <!-- MainMenu -->
    
    <!-- Content -->
    
        <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-wrapper">
			<!-- Add Modal -->
			<div class="modal fade text-left" id="tag_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header bg-success">
							<h3 class="modal-title white" style="font-size: 1.1rem;">
								<b> 태그 등록/수정</b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true" style="color: white;">&times;</span>
							</button>
						</div>
						<form name="tag_form" id="tag_form" action="/admin/tag/registTag" method="post" class="form form-horizontal" style="overflow-x: hidden;">
							<input type="hidden" name="id"  id="id" value="">
							<div class="modal-body" style="padding: 10px;">
								<div class="form-body">
									<br>
									<div class="form-group row">
										<label class="col-md-3 label-control font-medium-2 text-bold-400" for="projectinput1" style="padding: 0px;">이름</label>
										<div class="col-md-9 mx-auto">
											<input type="text" id="name" class="form-control" placeholder="이름" name="name">
										</div>
									</div>
									<div class="form-group row">
										<label class="col-md-3 label-control font-medium-2 text-bold-400" for="projectinput2" style="padding: 0px;">검색가능여부</label>
										<div class="col-md-4">
											<select class="custom-select custom-select-sm form-control form-control-sm" id="visibility" name="visibility">
												<option value="visible">검색가능</option>
												<option value="hidden">검색불가</option>
												<option value="block">검색/입력불가</option>
											</select>
										</div>
										<div class="col-md-4 mx-auto"></div>
									</div>
									<div class="form-group row">
										<label class="col-md-3 label-control font-medium-2 text-bold-400" for="projectinput2" style="padding: 0px;">컨텐츠타입</label>
										<div class="col-md-4">
											<select class="custom-select custom-select-sm form-control form-control-sm" id="tagType" name="tagType">
												<option value="none">없음</option>
												<option value="dictionary">도감</option>
												<option value="location">장소</option>
											</select>
										</div>
										<div class="col-md-4 mx-auto"></div>
									</div>
									<div class="form-group row">
										<label class="col-md-3 label-control font-medium-2 text-bold-400" for="projectinput1" style="padding: 0px;">컨텐트URL</label>
										<div class="col-md-9 mx-auto">
											<input type="text" id="url" class="form-control" placeholder="URL" name="url">
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button id="regist" class="btn btn-success" type="button">
									<i class="la la-save"></i> 저장
								</button>
							</div>
						</form>
					</div>
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
                                                        <th>태그번호</th>
                                                        <th>태그명</th>
                                                        <th>자동완성검색</th>
                                                        <th>도감등록</th>
                                                        <th>링크주소</th>
                                                        <th>등록시간</th>
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
    </div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

	<!-- Footer -->
    <%@ include file="/WEB-INF/view/admin/common/footer.jsp"%>
    <!-- Footer -->
    <!-- BEGIN: Vendor JS-->
    <script src="/static/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="/static/app-assets/vendors/js/tables/datatable/datatables.min.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/moment.min.js"></script>
    <script src="/static/app-assets/js/scripts/tables/jquery.spring-friendly.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/switchery.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/icheck/icheck.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/repeater/jquery.repeater.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jquery.sparkline.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/typeahead/typeahead.bundle.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/typeahead/bloodhound.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/typeahead/handlebars.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/formatter/formatter.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/maxlength/bootstrap-maxlength.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/card/jquery.card.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/switchery.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-switch.min.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/datedropper.min.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/timedropper.min.js"></script>
    <script src="/static/app-assets/js/core/libraries/jquery_ui/jquery-ui.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/select/jquery.selectBoxIt.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/static/app-assets/js/core/app-menu.js"></script>
    <script src="/static/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="/static/app-assets/js/scripts/tables/components/table-components.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/dragula.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="/static/app-assets/js/scripts/tables/jquery.spring-friendly.js"></script>    
    <!-- END: Page JS-->
    
    <!-- Validation -->
    <script src="/static/js/validation/jquery.validate.min.js"></script>
	<script src="/static/js/validation/additional-methods.min.js"></script>
	<script src="/static/js/validation/messages_ko.min.js"></script>
	<script src="/static/js/moyamo-util.js"></script>
    
    
    <script type="text/javascript">
    var prevCommentId = 0;
	$(document).ready(function(){
		//메뉴 열린 모양
		$('.la-bullhorn').parent().parent().addClass('open active');
		//$('#post-magazine').addClass('active');
		
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
	            	text: '태그 등록',
	            	className: 'btn btn-custom-info First',
	                action: function ( e, dt, node, config ) {
	                	initInput();
	                	$('#tag_modal').modal("show");
	                }
	            },		
	        ],	    
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},			
			'ajax' : {
				"url":'/rest/tag/getList'
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
	        	{ data: "name", orderable: false},
	        	{ data: "visibility", render: function(data, type, row, meta){
		        		if (data == 'visible') {
			        		return '<span class="badge badge-success" style="cursor: unset;width: 80px;">검색 가능</span>';
		        		} else if (data == 'block') {
		        			return '<span class="badge badge-secondary" style="cursor: unset;width: 80px;">검색/입력 불가</span>';
		        		} else if (data == 'hidden') {
		        			return '<span class="badge badge-danger" style="cursor: unset;width: 80px;">검색 불가</span>';
			        	} else {
	        				return "";
			        	} 
        			},
        			orderable: false
        		},
	        	{ data: "plantId", render: function(data, type, row, meta){
		        		if (data > 0 ) {
		        			return '<span class="badge badge-success" style="cursor: unset;width: 40px;">등록</span>';
			        	} else {
			        		return '<span class="badge badge-secondary" style="cursor: unset;width: 40px;">미등록</span>';
			        	} 
    				},
    				orderable: false
    			},
                { data: "url", orderable: false},
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
	    		$('#tag_modal').modal('show');
	        	var dataSet = table.row( $(this).parent() ).data();
	        	detailView(dataSet);
	    	}
	    });
	    
	});

	
	
	function detailView(dataSet) {
    	$('#id').val(dataSet.id);
    	$('#name').val(dataSet.name);
    	$('#url').val(dataSet.url);
    	$('#visibility').val(dataSet.visibility).trigger('change');
    	$('#tagType').val(dataSet.tagType).trigger('change');
	}
	
	function initInput() {
    	$('#id').val("");
    	$('#name').val("");
    	$('#url').val("");
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
    
</body>
<script src="/static/app-assets/vendors/js/extensions/toastr.min.js"></script>
<script src="/static/app-assets/js/scripts/extensions/toastr.js"></script>
<!-- END: Body-->
</html>
