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
			<div class="modal fade text-left" id="posting_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header bg-success">
							<h3 class="modal-title white" style="font-size: 1.1rem;">
								<b> 가이드북 등록</b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true" style="color: white;">&times;</span>
							</button>
						</div>
						<form name="posting_add_form" id="posting_add_form" action="/admin/registPosting" method="post" enctype="multipart/form-data">
							<input type="hidden" name="postingType" value="guidebook">
							<div class="modal-body" style="padding: 0;">
								<div class="card-body">
<!-- 									<fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
										<label for="projectinput4">제목</label> <input type="text" class="form-control" id="title" name="title">
									</fieldset> -->
									<div class="custom-file" style="height: 100%; width: 100%; margin-bottom: 15px;">
										<input type="file" accept="image/*" class="custom-file-input" name="poster" /> 
										<label class="custom-file-label" aria-describedby="inputGroupFileAddon02">포스터 사진 선택</label>
										<div class="viewPoster"></div>
									</div>									
									<fieldset class="form-group">
										<label>내용</label>
										<textarea rows="3" class="form-control autosize" name="text"></textarea>
									</fieldset>
									<hr size="3" />
									<fieldset class="form-group">
										<div class="row">
											<div class="col-lg-12">
												<div class="form-group file-repeater">
													<!-- <div data-repeater-list="repeater-list"> -->
													<div data-repeater-list="repeater-list">
														<div data-repeater-item>
															<div class="row mb-1">
																<div class="col-10 col-xl-11">
																	<div class="custom-file" style="height: 100%; width: 90%; margin-bottom: 15px;">
																		<input type="file" accept="image/*" class="custom-file-input" name="files" /> 
																		<label class="custom-file-label" aria-describedby="inputGroupFileAddon02">사진 선택</label> 
																		<input type="hidden" name="id">
																		<div class="view"></div>
																	</div>
																</div>
																<div class="col-2 col-xl-1" style="float: right; padding-left: 0px;">
																	<button type="button" style="float: right;" data-repeater-delete="" class="btn btn-icon btn-danger mr-1">
																		<i class="ft-x"></i>
																	</button>
																</div>
																<div class="col-10 col-xl-11">
																	<fieldset class="form-group">
																		<textarea rows="2" class="form-control autosize" name="descriptions" placeholder="사진설명"></textarea>
																	</fieldset>
																</div>
															</div>
															<hr size="3" />
														</div>
													</div>
													<div class="col-12 col-xl-4" style="float: right; padding-left: 0px;">
														<button type="button" style="float: right;" data-repeater-create class="btn btn-primary">
															<i class="ft-plus"></i> 사진추가
														</button>
													</div>
												</div>

											</div>
										</div>

									</fieldset>
								</div>
							</div>
							<div class="modal-footer">
								<button id="regist" class="btn btn-success" type="button">
									<i class="la la-save"></i> 등록
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>

			<!-- Modify Modal -->
			<div class="modal fade text-left" id="posting_modify_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header bg-success">
							<h3 class="modal-title white" style="font-size: 1.1rem;">
								<b> 가이드북 수정</b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true" style="color: white;">&times;</span>
							</button>
						</div>
						<form name="posting_modify_form" id="posting_modify_form" action="/admin/modifyPosting" method="post" enctype="multipart/form-data">
							<input type="hidden" name="postingId" value="">
							<input type="hidden" name="postingType" value="guidebook">
							<div class="modal-body" style="padding: 0;">
								<div class="card-body">
									<div class="custom-file" style="height: 100%; width: 100%; margin-bottom: 0px;">
										<input type="file" accept="image/*" class="custom-file-input" name="poster" /> 
										<label class="custom-file-label" aria-describedby="inputGroupFileAddon02">포스터 사진 선택</label>
										<div class="viewPoster"></div>
									</div>										
<!-- 									<fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
										<label for="projectinput4">제목</label> <input type="text" class="form-control" id="title" name="title">
									</fieldset> -->
									<fieldset class="form-group">
										<label>내용</label>
										<textarea rows="3" class="form-control" autosize name="text"></textarea>
									</fieldset>
									<hr size="3" />
									<fieldset class="form-group">
										<div class="row">
											<div class="col-lg-12">
												<div class="form-group file-repeater">
													<div data-repeater-list="repeater-list">
														<div data-repeater-item>
															<div class="row mb-1">
																<div class="col-10 col-xl-11">
																	<div class="custom-file" style="height: 100%; width: 90%; margin-bottom: 15px;">
																		<input type="file" accept="image/*" class="custom-file-input" name="files" /> 
																		<label class="custom-file-label" aria-describedby="inputGroupFileAddon02">사진 선택</label> 
																		<input type="hidden" name="id" id="modify_id">
																		<div class="view"></div>
																	</div>
																</div>
																<div class="col-2 col-xl-1" style="float: right; padding-left: 0px;">
																	<button type="button" style="float: right;" data-repeater-delete="" class="btn btn-icon btn-danger mr-1 delete_photo">
																		<i class="ft-x"></i>
																	</button>
																</div>
																<div class="col-10 col-xl-11">
																	<fieldset class="form-group">
																		<textarea rows="2" class="form-control autosize" name="descriptions" placeholder="사진설명"></textarea>
																	</fieldset>
																</div>
															</div>
															<hr size="3" />
														</div>
													</div>
													<div class="col-12 col-xl-4" style="float: right; padding-left: 0px;">
														<button type="button" style="float: right;" data-repeater-create class="btn btn-primary add_photo">
															<i class="ft-plus"></i> 사진추가
														</button>
													</div>
												</div>

											</div>
										</div>

									</fieldset>
								</div>
							</div>
							<div class="modal-footer">
								<button id="delete" class="btn btn-danger" type="button">
									<i class="la ft-x"></i> 삭제
								</button>
								<button id="modify" class="btn btn-success" type="button">
									<i class="la la-save"></i> 저장
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
								<b id="detail_title"> 가이드북 상세</b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(false);">
								<span aria-hidden="true" style="color: white;">&times;</span>
							</button>
						</div>
						<form name="posting_detail_form" id="posting_detail_form" action="/admin/modifyPosting" method="post" enctype="multipart/form-data">
							<input type="hidden" name="postingId" value="">
							<input type="hidden" name="postingType" value="guidebook">
							<div class="modal-body" style="padding: 0;">
								<div class="card-body" style="padding-top: 1.0rem;padding-right: 1.0rem;padding-bottom: 0.5rem;padding-left: 1.0rem;">
									<!-- 포스터 이미지 -->
									<div class="row" style="margin-bottom: 10px;">
										<div class="col" style="text-align: right;"><b><font color="red">포스터 이미지</font></b></div>
									</div>									
									<div class="row" style="margin-bottom: 0px;">
										<div class="col" id="detail_poster"></div>
									</div>										
									<!-- 개인정보 영역 -->
									<div class="media">
	                                    <a class="media-left" href="#">
	                                        <img class="media-object" src="" id="detail_user_photo" src="" onerror="this.src='/static/img/noimg.png';" style="width: 64px;height: 64px;border-radius: 10%;">
	                                    </a>
	                                    <div class="media-body" style="margin-left: 10px;">
	                                        <h5 class="media-heading" id="detail_user_nick"></h5>
	                                        작성일 : <span class="text-muted" id="detail_createdAt"></span></br>
	                                        수정일 : <span class="text-muted" id="detail_modifiedAt"></span>
	                                    </div>
									</div>
									<hr size="100%"/>
							
									<!-- 컨텐츠 영역 본문 -->
									<div class="row" style="margin-bottom: 20px;">
										<b><div class="col" id="detail_text"></div></b>
									</div>									
									<!-- 컨텐츠 영역 파일/설명 -->
									<div id="detail_attach_view"></div>
								</div>
								
								<!-- 좋아요/댓글수 -->
								<!-- <div class="media-right" style="margin-left: 10px;margin-top:0px;margin-bottom:20px;"> -->
<!-- 								<div class="media-right text-right"  style="margin-right: 20px;margin-top:0px;margin-bottom:20px;font-style: italic;color: coral;">
                                    좋아요 : <span id="detail_likecnt"></span>,&nbsp; 스크랩 : <span id="detail_scrapcnt"></span>,&nbsp; 조회 : <span id="detail_viewcnt"></span>,&nbsp; 댓글 : <span id="detail_commentcnt"></span>
								</div>	 -->				
							</div>

							<!--  모달 푸터 -->		
							<div class="modal-footer" style="background: lightgray;">
								<button id="detail_to_modify" class="btn btn-success" type="button">
									<i class="la la-save"></i> 컨텐츠 수정
								</button>
							</div>								
						</form>
					</div>
				</div>
			</div>
                
            <div class="content-body">
                <!-- 가이드북 -->
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
                                                        <!-- <th>NO</th> -->
                                                        <th>썸네일</th>
                                                        <!-- <th>제목</th> -->
                                                        <th>닉네임</th>
                                                        <th>내용</th>
                                                        <th>조회수</th>
                                                        <th>좋아요</th>
                                                        <!-- <th>댓글</th> -->
                                                        <th>작성일</th>
                                                        <th>신고</th>
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
                <!-- 가이드북 관리 -->
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
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-checkbox.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-switch.min.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/datedropper.min.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/timedropper.min.js"></script>

    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/static/app-assets/js/core/app-menu.js"></script>
    <script src="/static/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="/static/app-assets/js/scripts/tables/components/table-components.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/dragula.min.js"></script>
    <script src="/static/app-assets/js/scripts/forms/switch.js"></script>
    <script src="/static/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="/static/app-assets/js/scripts/tables/jquery.spring-friendly.js"></script>    
    <!-- END: Page JS-->
    
    <!-- Validation -->
    <script src="/static/js/validation/jquery.validate.min.js"></script>
	<script src="/static/js/validation/additional-methods.min.js"></script>
	<script src="/static/js/validation/messages_ko.min.js"></script>
	<script src="/static/js/moyamo-util.js"></script>
    
    
    <script type="text/javascript">
	$(document).ready(function(){
		//메뉴 열린 모양
		$('.la-file-text').parent().parent().addClass('open active');
		$('#post-guide').addClass('active');
		
		$('[data-toggle="tooltip"]').tooltip({
		    html: true
		});

		$(document).on('change', '.custom-file-input', function (event) {
		    $(this).next('.custom-file-label').html(event.target.files[0].name);
		})
		
		$("textarea.autosize").on('keydown keyup', function () {
		  $(this).height(1).height( $(this).prop('scrollHeight')+12 );	
		});	
				
		$("form[name=posting_add_form] input[name='poster").off("change").on("change", btnFileActionPoster);
		$("form[name=posting_modify_form] input[name='poster").off("change").on("change", btnFileActionPoster);
		
		var fileRepeaterDiv = $('.file-repeater').repeater({
			show: function () {
				var count = $(this).parent()[0].childElementCount;
				if(10 < count){
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
		
		
		var table = $('.zero-configuration').DataTable({
			dom:
				"<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'><'col-sm-2'B>>" +
			    "<'row'<'col-sm-12'tr>>" +
			    "<'row'<'col-sm-4'i><'col-sm-8'p>>",
	        buttons: [
	            {
	            	text: '가이드북 등록',
	            	className: 'btn btn-custom-info First',
	                action: function ( e, dt, node, config ) {
	                	$('#posting_add_modal').modal("show");
	                }
	            },		
	        ],	    
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},			
			'ajax' : {
				"url":'/rest/getPostingList',
				"data":{
					"posting_type":"guidebook"					
				}
			},
			'serverSide' : true,
			"processing" : true,
			//"order": [[ 0, "desc" ]],
			"drawCallback": function (oSettings, json) {
	            $('[data-toggle="tooltip"]').tooltip();
	        },
            "createdRow": function( row, data, dataIndex){
            	$('td', row).eq(2).addClass('boldcolumn');
            }, 	  
	        columns: [
	        	{ data: "orgAttachments", render: function(data, type, row, meta){
	            		var setting = '?d=50x50';
	            		var style = 'width: 50px;height: 50px;padding: 0rem;';
	            		var itemEl = getImgSrc(data[0].photoUrl, setting, style);
	            		return itemEl;
            		}, 
            		orderable: false
            	},
	        	/* { data: "title", orderable: false}, */
	        	{ data: "owner.nickname", orderable: false},
                { data: "orgText"  , render: function ( data, type, row ) {
                	return data.length < 30 ? data : data.substr( 0, 30 ) + " ...";
                	},
                	orderable: false         
                },
	        	{ data: "readCount", orderable: false},
	        	{ data: "likeCount", orderable: false},
                { data: "createdAt" , 
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	},
                searchable: false
                },
                { data: "isBlind", render: function(data, type, row, meta){
	        		if (data == true) {
	        			return '<span class="badge badge-danger" style="cursor: unset;width: 48px;">차 단</span>';
		        	} else {
        				return "";
		        	} 
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
	    $('.zero-configuration tbody').on('click', 'td', function () {
	    	
	    	if('boldcolumn' == $(this)[0].className.trim()){	    		
	    		fileRepeaterDiv.setList(); // reapeater 초기화
	    		$('#posting_detail_modal').modal('show');
	        	//var data = table.row( $(this) ).data(); 
	        	var dataSet = table.row( $(this).parent() ).data();

	        	//modifyView(dataSet);
	        	detailView(dataSet);
	    	}
	    });
	    
	});


	function detailView(dataSet) {
		changeScroll(true);
		//$('#detail_title').html(dataSet.title);
    	//$('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);
    	$('#detail_text').html("<span style='font-size: 110%;background-color: white;'>" +dataSet.orgText + "</span>");
    	$('#detail_user_nick').html(dataSet.owner.nickname);
    	$('#detail_createdAt').html(moment(dataSet.createdAt).format('YYYY-MM-DD HH:mm:ss'));
    	$('#detail_modifiedAt').html(moment(dataSet.modifiedAt).format('YYYY-MM-DD HH:mm:ss'));
    	
	
    	$("#detail_user_photo").attr("src", getProfileImage(dataSet.owner.photoUrl, 'noimg.png'));

        $('#posting_detail_modal form[name=posting_modify_form] input[name=postingId]').empty().val(dataSet.id);
        $('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').empty().val(dataSet.id);
        
        $('#detail_poster').html("<img class='img-thumbnail' src='" + dataSet.posters[0].photoUrl+ "' style='width:100%;padding: 0rem;'/><hr>");
        /* var count = $(this).parent()[0].childElementCount;
        console.log($("#posting_modify_modal form[name=posting_modify_form] input[name^='repeater-list'").parent()[0].childElementCount); */
        //$('.delete_photo').click();
        var contentsHtml = "";
        for(var i=0; i < dataSet.orgAttachments.length; i++){
            var imgUrl = dataSet.orgAttachments[i].photoUrl;
            var description = dataSet.orgAttachments[i].description;
            
        	contentsHtml += "<div class='media'>";
			contentsHtml += "<div class='media-body' style='margin-left: 0px;'>";
			contentsHtml += "<img src='" + imgUrl + "' style='width:100%;'/>";
			contentsHtml += "</div>";
			contentsHtml += "</div>";
				contentsHtml += "<div class='media'>";
				contentsHtml += "<div class='media-body' style='margin-left: 10px;margin-top:10px;margin-bottom:20px;'>";
				if(typeof description != "undefined"){
					contentsHtml += "<span class='text-muted'><span style='font-size: 110%;background-color: white;'><span style='font-size: 110%;background-color: white;'><pre style='font-size: 110%;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;'>" + description + "</pre></span></span>";
				}			
				contentsHtml += "</div>";
				contentsHtml += "</div>";
   		}
        $('#detail_attach_view').html(contentsHtml);
        $('#detail_likecnt').html(dataSet.likeCount);
        $('#detail_scrapcnt').html(dataSet.scrapCount);
        $('#detail_viewcnt').html(dataSet.readCount);
        $('#detail_commentcnt').html(dataSet.commentCount);
        modifyView(dataSet);
		//getComments(dataSet.id, 0);
        
	}	
	function modifyView(dataSet) {
    	//$('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);
    	$('#posting_modify_modal form[name=posting_modify_form] textarea[name=text]').empty().val(dataSet.orgText);
        $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').empty().val(dataSet.id);
        var imgHtml = "<img class='img-thumbnail' src='" + dataSet.orgPosters[0].photoUrl+ "' style='width:100%;padding: 0rem;margin-top: 20px;margin-bottom: 10px;'/>";
        $("#posting_modify_modal form[name=posting_modify_form]").parent().find(".viewPoster:eq(0)").empty().prepend(imgHtml);
        /* var count = $(this).parent()[0].childElementCount;
        console.log($("#posting_modify_modal form[name=posting_modify_form] input[name^='repeater-list'").parent()[0].childElementCount); */
        //$('.delete_photo').click();
        for(var i=0; i < dataSet.orgAttachments.length; i++){
        	$('.add_photo').click();
			var setting = '';
			var style = 'width: 100%;margin-top: 10px;padding: 0rem;';
			var imgSrc = getImgSrc(dataSet.orgAttachments[i].photoUrl, setting, style);
			//console.log(imgSrc);
    		$("#posting_modify_modal form[name=posting_modify_form] input[name='repeater-list["+i+"][files]'").parent().find(".view:eq(0)").empty().prepend(imgSrc);
    		$("#posting_modify_modal form[name=posting_modify_form] textarea[name='repeater-list["+i+"][descriptions]'").val(dataSet.orgAttachments[i].description);
    		$("#posting_modify_modal form[name=posting_modify_form] input[name='repeater-list["+i+"][id]'").val(dataSet.orgAttachments[i].id);
   		}
        $('#posting_modify_modal').modal('handleUpdate');
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
/* 	function initSelectMulti(){
		//셀렉트박스 로딩
	    var $selectMulti = $(".js-example-programmatic-multi").select2();
	    $selectMulti.select2({
	      placeholder: "클릭하여 선택하세요."
	    });
	} */
	function btnFileAction(e){
		//파일 선택후 element 만들기
    	var itemEl = getDisplayItem(URL.createObjectURL(this.files[0]), "img");
    	$(this).parent().find("#modify_id").val("");
		//파일 미리보기
    	$(this).parent().find(".view:eq(0)").empty().prepend(itemEl);
	}
	
	function btnFileActionPoster(e){
		//파일 선택후 element 만들기
    	var itemEl = getDisplayItem(URL.createObjectURL(this.files[0]), "img");
		//파일 미리보기
    	$(this).parent().find(".viewPoster:eq(0)").empty().prepend(itemEl);
	}

    $('#regist').on('click', '', function () {
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
		    	$('#posting_add_form').submit();
	    	}
		} else {
			alert("TAG 를 확인하시기 바랍니다.");
			return false;
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
	    	$('#posting_modify_form').submit();
    	}
    });
    	
    $('#delete').on('click', '', function () {
    	if (confirm('삭제하시겠습니까?')) {
	    	var postId = $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').val();
	    	$('#posting_modify_form').attr('action', "/admin/deletePosting").submit();
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
    
</body>
<script src="/static/app-assets/vendors/js/extensions/toastr.min.js"></script>
<script src="/static/app-assets/js/scripts/extensions/toastr.js"></script>
<!-- END: Body-->
</html>
