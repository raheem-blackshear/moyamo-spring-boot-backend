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
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/icheck/custom.css">
	<link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/toggle/switchery.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/selects/select2.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css">
<!--     <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/dragula.min.css"> -->
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/components.css">
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
    	font-size: 15px;
   	    font-weight: 1000;
    }		
    .redhighlight{
    	background-color: #79c09b !important;
    	font-size: 15px;
   	    font-weight: 1000;  
   	    cursor: move;  	
    }	

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
            <!-- Modal -->
                <div class="modal fade text-left" id="posting_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                                <div class="modal-header bg-success">
                                    <h3 class="modal-title white" style="font-size: 1.1rem;"><b> 매거진 등록</b></h3>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true" style="color:white;">&times;</span>
                                    </button>
                                </div>
								<form name="posting_add_form" id="posting_add_form" action="/admin/registPosting" method="post" enctype="multipart/form-data">
								<input type="hidden" name="postingType" value="magazine">
								<div class="modal-body" style="padding:0;">
					                    <div class="card-body">
				                      		<fieldset class="form-group" id="fieldsethospital_name_kr" style="display:block;">
				                      			<label for="projectinput4">제목</label>
		                                        <input type="text" class="form-control" id="title" name="title">
		                                    </fieldset>
				                      		<fieldset class="form-group">
			                                      	  <label>내용</label>
			                                      	  <textarea rows="3" class="form-control" name="text"></textarea>
											</fieldset>
		                                    <fieldset class="form-group">
		                                        <div class="row">
		                                        	<div class="col-lg-12">
 	                                                    <div class="form-group file-repeater">
				                                            
				                                            <div data-repeater-list='repeater-list' id='repeatedFileElement0'>
				                                                <div data-repeater-item>
					                                                <div class='row mb-1'>
						                                                <div class='col-10 col-xl-11'>
						                                                    <div class='custom-file' style='height: 100%; width: 100%;margin-bottom: 15px;'>
							                                                    <input type='file' accept='image/*' class='custom-file-input' name='files'/>
							                                                    <label class='custom-file-label' aria-describedby='inputGroupFileAddon02'>사진 선택</label>
							                                                    <input type='hidden' name='id'>
								                                                <div class='view'></div>
							                                                </div>
							                                            </div>
						                                                <div class='col-2 col-xl-1' style='float: right;padding-left: 0px;'>
																			<button type='button' style='float: right;' data-repeater-delete='' class='btn btn-icon btn-danger mr-1'><i class='ft-x'></i></button>						                                                
					                                               	 	</div>							                                            
											                      		<div class='col-10 col-xl-11'>
											                      			<fieldset class='form-group'>
										                                    	<textarea rows='2' class='form-control' name='descriptions' placeholder='사진설명'></textarea>
																			</fieldset>
																		</div>
						                                            </div>
						                                            <hr size='3'/>
				                                                </div>
			                                                </div>

			                                                <div class="col-12 col-xl-3" style="float: right;padding-left: 0px;">
																<button type="button" onclick="additem(0);" style="float: right;" data-repeater-create class="btn btn-primary"><i class="ft-plus"></i> 사진추가</button>						                                                
		                                               	 	</div>		                                                
							                    		</div>
							                    		
                                                    </div>
		                                        </div>

	                                         </fieldset>
		                                </div>
                                    </div>
                                    <div class="modal-footer">
                                       <button id="regist" class="btn btn-success" type="button"><i class="la la-save"></i> 등록</button>
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
<!--                                 <div class="card-header">
                                    <a class="heading-elements-toggle"><i class="la la-ellipsis-v font-medium-3"></i></a>
                                    <div class="heading-elements">
                                        <ul class="list-inline mb-0">
                                            <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                            <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                                            <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                                        </ul>
                                    </div>
                                </div> -->
                                <div class="card-content collpase show">
                                    <div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-striped table-bordered zero-configuration" style="cursor:pointer;text-align:center;vertical-align:middle;width:100%;">
                                                <thead>
                                                    <tr>
                                                        <!-- <th>NO</th> -->
                                                        <th>썸네일</th>
                                                        <th>제목</th>
                                                        <th>닉네임</th>
                                                        <th>내용</th>
                                                        <th>조회수</th>
                                                        <th>좋아요</th>
                                                        <th>댓글</th>
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
<!--     <script src="/static/app-assets/js/core/libraries/jquery_ui/jquery-ui.min.js"></script> -->
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/static/app-assets/js/core/app-menu.js"></script>
    <script src="/static/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="/static/app-assets/js/scripts/tables/components/table-components.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/dragula.min.js"></script>
    <!-- END: Page JS-->
    
    <!-- Validation -->
    <script src="/static/js/validation/jquery.validate.min.js"></script>
	<script src="/static/js/validation/additional-methods.min.js"></script>
	<script src="/static/js/validation/messages_ko.min.js"></script>
    
    
    <script type="text/javascript">
	$(document).ready(function(){
		//메뉴 열린 모양
		$('.la-file-text').parent().parent().addClass('open active');

		
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
	            	text: '매거진 등록',
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
					"posting_type":"magazine"					
				}
			},
			'serverSide' : true,
			"processing" : true,
			"order": [[ 0, "desc" ], [ 1, "desc" ]],
			"drawCallback": function (oSettings, json) {
	            $('[data-toggle="tooltip"]').tooltip();
	        },
	
	        columns: [
	        	{ data: "attachments", render: function(data, type, row, meta){
            		var setting = '?d=50x50';
            		var style = 'width: 50px;height: 50px;';
            		var itemEl = getImgSrc(data[0].photoUrl, setting, style);
            		return itemEl;
            		} , 
            		orderable: false
            	},
	        	{ data: "title", orderable: false},
	        	{ data: "owner.nickname", orderable: false},
	        	{ data: "text", orderable: false},
	        	{ data: "readCount", orderable: false},
	        	{ data: "likeCount", orderable: false},
	        	{ data: "commentCount", orderable: false},
	        	{ data: "createdAt", orderable: false},
	        	{ data: "postingType", orderable: false}
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
	
		
		
// 		$('.badge-danger').tooltip();
// 	$('[data-toggle="tooltip"]').tooltip();
		
	});
	
	
	/* aws s3에서 가져오는 데이터 element 생성 */
	function getS3Data(data, setting, style){
		var httpName = '${httpName}';
		var itemEl = '<img style="'+style+'" src="'+httpName+data+setting+'" alt="">';
		return itemEl;
	}
	
	function getImgSrc(data, setting, style){
		//var httpName = '${httpName}';
		var itemEl = '<img style="'+style+'" src="'+data+setting+'" alt="">';
		return itemEl;
	}
	/* detail view content 만들기*/
	function makeContent(data){
		var httpName = '${httpName}';
		
		var html = '';
		
		//후기 사진
		var afterHtml = '';
		var beforeHtml = '';
		for(var i=0; i<data.reviewResource.length; i++){
			if(!data.reviewResource[i].imgUrl){
				continue;	
			}
			if(data.reviewResource[i].kind.indexOf('after') != -1){
				afterHtml += '<div class="product-img d-flex align-items-center" style="min-height: unset;"><div class="badge badge-dark" style="top:unset;bottom: 0px;left: 0px;opacity: 0.6;padding: 0.35em 0.4em;">after</div>'
							+'<br><img src="'+ httpName + data.reviewResource[i].imgUrl +'" alt="Card image cap" class="img-fluid mb-1"></div>';
			}else{
				beforeHtml += '<div class="product-img d-flex align-items-center" style="min-height: unset;"><div class="badge badge-dark" style="top:unset;bottom: 0px;left: 0px;opacity: 0.6;padding: 0.35em 0.4em;">before</div>'
							+'<br><img src="'+ httpName + data.reviewResource[i].imgUrl +'" alt="Card image cap" class="img-fluid mb-1"></div>';
			}
		}
		html += afterHtml + beforeHtml;
		
		//수술부위 카테고리
		var categoryData = '';
		for(var i=0; i<data.category.length; i++){
			categoryData += data.category[i].name;
			if(i != data.category.length -1){
				categoryData += ", ";
			}
		}
		
		html +='<img style="width: 15px;margin-top: -5px;" src="/static/img/ic_check.png"><span style="font-weight: 1000;color:red;"> ' + categoryData
		
		//별점
		+ '<span style="float:right;color:black;">'
		+ getStarsHtmlByEvaluationScore(data.evaluationScore) + '&nbsp;'+data.evaluationScore+'</span></span>';
		
		//내용
		html += '<br><br>' + data.content;
		
		//수술날짜
		html += '<br><br><span style="font-weight: 1000;">- 수술 날짜  &nbsp;</span><span style="color:red;">'+data.surgeryDate+'</span>';
		//수술병원
		html += '<br><span style="font-weight: 1000;">- 수술 병원  &nbsp;</span><span style="color:red;">'+data.clinicName +'</span><br><span style="font-weight: 1000;">- 수술 원장  &nbsp;</span><span style="color:red;">'+data.doctorName+'</span>';
		
		return html;
	}
	
	//스코어(10점만점)로 별점 별이미지 가져오기
	function getStarsHtmlByEvaluationScore(evaluationScore){
		var starsHtml = '';
		var score = Number(evaluationScore);
		var star = Math.floor(score/2);
		var halfstarORemptystar = score%2;
		
		var isHalfstar = false;
		
		for(var i=0; i<5; i++ ){
			if(i < star){
				starsHtml += '<img style="width: 15px;margin-top: -5px;" src="/static/img/ic_star_01.png"> ';	
			}else{
				if(!isHalfstar && halfstarORemptystar == 1){
					starsHtml += '<img style="width: 15px;margin-top: -5px;" src="/static/img/ic_star_02.png"> ';
					isHalfstar = true;
				}else{
					starsHtml += '<img style="width: 15px;margin-top: -5px;" src="/static/img/ic_star_03.png"> ';
				}
			}
		}
		return starsHtml;
	}
	
	//댓글,대댓글 가져오기
	function getCommentHtmlByData(data){
		var returnHtml = '';
		
		//댓글
		for(var i=0; i<data.length; i++){
			returnHtml += '<div class="px-0 py-0" style="border-top: 1px solid rgba(0, 0, 0, 0.1);">'
						 	+'<div class="card-body" style="padding-bottom: 0;">'
								+'<div class="media">'
									+ makeComment(data[i]);
			//대댓글
			for(var j=0; j<data[i].reCommentInfo.length; j++){
				returnHtml +='       <div class="media">'
									 + makeComment(data[i].reCommentInfo[j])+'</div></div>';
			}
			returnHtml +='</div></div></div>';
		}
		
		return returnHtml;
	}
	
	//코멘트html만들기
	function makeComment(data){
		//기본이미지 삽입
		var httpName = '${httpName}';
		var profileImage = data.userInfo.profileImg;
		if(profileImage == "" || profileImage == null){
			profileImage = '/static/img/noimg.png';
		}else{
			profileImage = httpName + data.userInfo.profileImg;
		}
		
		var returnHtml='';
		//차단된 것 중간줄, 빨간색 처리
		if(data.isBlock){
			data.content = '<span style="color:red;">(차단)</span><span style="text-decoration: line-through;">'+data.contentOriginal+'</span>';
		}else if(data.isBlind){
			data.content = '<span style="color:red;">(탈퇴)</span><span style="text-decoration: line-through;">'+data.contentOriginal+'</span>';
		}else if(data.isDeleted){
			data.content = '<span style="color:red;">(삭제)</span><span style="text-decoration: line-through;">'+data.contentOriginal+'</span>';
		}
		returnHtml += '<div class="media-left pr-1">'
					 +'	<a href="#">'
					 +'		<span class="avatar avatar-online"><img src="'+profileImage+'" alt="avatar" width="30px" height="30px"></span>'
					 +'	</a>'
					 +'</div>'
					 +'<div class="media-body">'
					 +'	<p class="text-bold-700 mb-0">'+data.userInfo.name +'</p>'
					 +'	<p class="m-0">'+ data.content+'</p>'
					 +'	<ul class="list-inline mb-1">'
					 +'		<li class="pr-1 commentTime">'+moment(data.createdAt).format('YYYY-MM-DD HH:mm:ss') +'</li>'
					 +'	</ul>';
					 //마지막 div 는 대댓글을 위해 펑션 실행후 꼭 닫아줘야함
		 return returnHtml;
	}
	function getDisplayItem(item, type){
		var itemEl;
		if(type == "img") { // selected file
			itemEl = '<img style="width: 50%;margin-top: 10px;"'
				+'src="'+item+'" alt="">';
		}
		return itemEl;
	}
	function initSelectMulti(){
		//셀렉트박스 로딩
	    var $selectMulti = $(".js-example-programmatic-multi").select2();
	    $selectMulti.select2({
	      placeholder: "클릭하여 선택하세요."
	    });
	}
	function btnFileAction(e){
		//파일 선택후 element 만들기
    	var itemEl = getDisplayItem(URL.createObjectURL(this.files[0]), "img");
		//파일 미리보기
    	$(this).parent().find(".view:eq(0)").empty().prepend(itemEl);
	}

    $('#regist').on('click', '', function () {
        
/* 		if($.trim($('#posting_add_form [name="createPostVo.title"]').val()) == ''){
			alert("제목을 입력하세요!");
			$('#title').focus();
			return false;
		} */
/*  		$('#posting_add_form input, #posting_add_form select , #posting_add_form textarea').each(
			    function(index){
			        var input = $(this);
			        alert('Type: ' + input.attr('type') + ' Name: ' + input.attr('name') + ' Value: ' + input.val());
			    }
		);
		alert($('.file-repeater').repeaterVal()); */
    	if (confirm('매거진을 등록하시겠습니까?')) {
	    	$('#posting_add_form').submit();
    	}
    });	
	function additem(idx) {
		if (idx == "undefined") {
			idx = 0;
		}
		alert(idx);
		var item =""+
		"  <div data-repeater-list='repeater-list' id='repeatedFileElement"+(idx+1)+"'>                                      "+
		"  <div data-repeater-item>                                                 "+
		"    <div class='row mb-1'>                                                 "+
		"      <div class='col-10 col-xl-11'>                                             "+
		"        <div class='custom-file' style='height: 100%; width: 100%;margin-bottom: 15px;'>                               "+
		"          <input type='file' accept='image/*' class='custom-file-input' name='files'/>                             "+
		"          <label class='custom-file-label' aria-describedby='inputGroupFileAddon02'>사진 선택</label>                           "+
		"          <input type='hidden' name='id'>                                         "+
		"          <div class='view'></div>                                         "+
		"        </div>                                                 "+
		"        </div>                                                 "+
		"      <div class='col-2 col-xl-1' style='float: right;padding-left: 0px;'>                                   "+
		"                    <button type='button' style='float: right;' data-repeater-delete='' class='btn btn-icon btn-danger mr-1'><i class='ft-x'></i></button>    "+                                
		"      </div>                                                               "+
		"            <div class='col-10 col-xl-11'>                                       "+
		"              <fieldset class='form-group'>                                     "+
		"            <textarea rows='2' class='form-control' name='descriptions' placeholder='사진설명'></textarea>                       "+
		"                    </fieldset>                                   "+
		"                  </div>                                       "+
		"      </div>                                                   "+
		"      <hr size='3'/>                                                 "+
		"  </div>                                                       "+
		"</div>";			
		$('#repeatedFileElement'+idx+'').append(item);
		
	}
	</script>
    
</body>
<script src="/static/app-assets/vendors/js/extensions/toastr.min.js"></script>
<script src="/static/app-assets/js/scripts/extensions/toastr.js"></script>
<!-- END: Body-->
</html>
