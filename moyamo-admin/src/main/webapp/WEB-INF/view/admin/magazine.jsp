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
   	    cursor: move;  	
    }	
	textarea.autosize { min-height: 50px; }
    </style>
    <!-- END: Custom CSS-->
        <!-- BEGIN: Content-->
        <div class="content-wrapper">
			<!-- Add Modal -->
			<div class="modal fade text-left" id="posting_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
				<div class="modal-dialog" role="document" id="posting_add_modal_dialog" style="cursor:move;">
					<div class="modal-content">
						<div class="modal-header bg-success">
							<h3 class="modal-title white" style="font-size: 1.1rem;">
								<b> 매거진 등록</b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"  onclick="javascript:changeScroll(false);">
								<span aria-hidden="true" style="color: white;">&times;</span>
							</button>
						</div>
						<form name="posting_add_form" id="posting_add_form" action="/admin/registPosting" method="post" enctype="multipart/form-data">
							<input type="hidden" name="postingType" value="magazine">
							<div class="modal-body" style="padding: 0;">
								<div class="card-body">
									<fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
										<label for="projectinput4">제목</label> <input type="text" class="form-control" id="title" name="title">
									</fieldset>
									<fieldset class="form-group">
										<label>내용</label>
										<textarea class="form-control autosize" name="text"></textarea>
									</fieldset>
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
				<div class="modal-dialog" role="document" id="posting_modify_modal_dialog" style="cursor:move;">
					<div class="modal-content">
						<div class="modal-header bg-success">
							<h3 class="modal-title white" style="font-size: 1.1rem;">
								<b> 매거진 수정</b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true" style="color: white;">&times;</span>
							</button>
						</div>
						<form name="posting_modify_form" id="posting_modify_form" action="/admin/modifyPosting" method="post" enctype="multipart/form-data">
							<input type="hidden" name="postingId" value="">
							<input type="hidden" name="postingType" value="magazine">
							<div class="modal-body" style="padding: 0;">
								<div class="card-body">
									<fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
										<label for="projectinput4">제목</label> <input type="text" class="form-control" id="title" name="title">
									</fieldset>
									<fieldset class="form-group">
										<label>내용</label>
										<textarea rows="3" class="form-control autosize" name="text"></textarea>
									</fieldset>
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
																		<div class="view"></div>
																		<input type="hidden" name="id" id="modify_id">
																	</div>
																</div>
																<div class="col-2 col-xl-1" style="float: right; padding-left: 0px;">
																	<button type="button" style="float: right;" data-repeater-delete="" class="btn btn-icon btn-danger mr-1 delete_photo">
																		<i class="ft-x"></i>
																	</button>
																</div>
																<div class="col-10 col-xl-11">
																	<fieldset class="form-group">
																		<textarea rows="2" class="autosize form-control" name="descriptions" placeholder="사진설명"></textarea>
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
			
			<!-- alarm Modal -->
			<div class="modal animated pulse text-left show" id="notification_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true" style="z-index:10000;cursor:move;">
				<div class="modal-dialog" id="notification_modal_content" role="document">
					<jsp:include page="template/write_notification_modal_content.jsp"></jsp:include>
				</div>
			</div>

			<!-- 게시물 상세보기모달 -->
			<div class="modal fade text-left" id="posting_detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
				<div class="modal-dialog" role="document" id="posting_detail_modal_dialog" style="cursor: move;">
					<div class="modal-content">
						<div class="modal-header bg-success">
							<h3 class="modal-title white" style="font-size: 1.1rem;">
								<b id="detail_title"> 게시물 상세</b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(false);">
								<span aria-hidden="true" style="color: white;">&times;</span>
							</button>
						</div>
						<form name="posting_detail_form" id="posting_detail_form" action="/admin/modifyPosting" method="post" enctype="multipart/form-data">
							<input type="hidden" name="postingId" value="">
							<input type="hidden" name="postingType" value="magazine">
							<div class="modal-body" style="padding: 0;">
								<div class="card-body" style="padding-top: 1.0rem;padding-right: 1.0rem;padding-bottom: 0.5rem;padding-left: 1.0rem;">
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
	                                    <div class="media-right" style="margin-left: 10px;">
											<div class="btn-group">
												<button class="btn btn-blind btn-sm" type="button" id="btn-blind-posting">
													<span>숨김</span>
												</button>
											</div>
											<div style="height:5px;"></div>
											<div class="btn-group">
												<button class="btn btn-blind btn-sm" type="button" id="btn-regist-notification" data-toggle="modal" data-target="#notification_modal">
													<span>알림 등록</span>
												</button>
											</div>
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
								<div class="media-right text-right"  style="margin-right: 20px;margin-top:0px;margin-bottom:20px;font-style: italic;color: coral;">
                                    좋아요 : <span id="detail_likecnt"></span>,&nbsp; 스크랩 : <span id="detail_scrapcnt"></span>,&nbsp; 조회 : <span id="detail_viewcnt"></span>,&nbsp; 댓글 : <span id="detail_commentcnt"></span>
								</div>					
							</div>
							<!--  댓글 리스토 노출 -->
							<div id="commentArea"></div>
							
							<!--  댓글 작성 영역 -->
							<div id="comment" class="input-group" style="border-top: 1px solid #626E82;">
								<div class="col-10" style="">
									<fieldset class="form-group"
										style="margin-top: 15px; margin-bottom: 10px;">
										<textarea rows="2" class="form-control autosize" id="commentText" name="commentText" placeholder="댓글 입력"></textarea>
									</fieldset>
									<fieldset class="form-group">
										<div class="fonticon-container">
											<div class="custom-file">
												<input type="file" class="custom-file-input" id="commentFile" name="commentFile"> <label class="custom-file-label" for="commentFile" aria-describedby="댓글 첨부"></label>
											</div>
										</div>
									</fieldset>
								</div>
								<div id="commentsButton" class="col-2" style="margin-top: 15px; margin-bottom: 10px;">
									<button id="commentsButton" class="btn btn-success" type="button" onclick="javascript:saveComment();">
										<i class="la la-save"></i>
									</button>
								</div>
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
                <!-- 매거진 -->
                <form name="posting_category_form" id="posting_category_form" action="/admin/switchPosting" method="post" >
                <input type="hidden" name="postingType" value="magazine">
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
                                                        <!-- <th><input type="checkbox" name="select_all" value="1" id="select-all"></th> -->
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

<!-- 										<div class="row">
											<div class="col-sm-0 text-left">
												<div class="dataTables_length" id="postingtable_length">
													<label>
														<select id="targetCategory" name="targetCategory" aria-controls="postingtable" class="custom-select custom-select-sm form-control form-control-sm">
															<option value="guidebook">가이드북</option>
															<option value="question">이름이 모야</option>
															<option value="clinic">식물 클리닉</option>
															<option value="bragging">자랑하기</option>
														</select>
													</label>
												</div>
											</div>
											<div class="col-sm-2 text-left">
												<div class="btn-group">
													<button class="btn btn-catetory btn-sm" type="button" id="moveCategory">
														<span>카테고리 이동</span>
													</button>
												</div>
											</div>
											<div class="col-sm"></div>
										</div> -->
										
										
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
	
    <script type="text/javascript">
    var prevCommentId = 0;
	$(document).ready(function(){
		setMenuName('${menuName}');
		
		$('[data-toggle="tooltip"]').tooltip({
		    html: true
		});

		$(document).on('change', '.custom-file-input', function (event) {
		    $(this).next('.custom-file-label').html(event.target.files[0].name);
		})
		
		$("textarea.autosize").on('keydown keyup', function () {
		  $(this).height(1).height( $(this).prop('scrollHeight')+12 );	
		});		
		
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

		$('#btn-blind-posting').on('click', function(e){
			alert('blink');
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
			"drawCallback": function (oSettings, json) {
	            $('[data-toggle="tooltip"]').tooltip();
	        },       
            "createdRow": function( row, data, dataIndex){
            	$('td', row).eq(1).addClass('boldcolumn');
            }, 	 
            
	        columns: [
/* 	        	{
		        	data : "id",
	                render: function (data, type, row, meta){
	                    return '<input type="checkbox" name="postingId" value="' + data + '">';
	                },
	                orderable: false,
	                className: 'dt-body-center'
	            }, */
	        	{ data: "orgAttachments", render: function(data, type, row, meta){
	        			var setting = '?d=50x50';
	            		var style = 'width: 50px;height: 50px;padding: 0rem;';
	            		var itemEl = getImgSrc(data[0].photoUrl, setting, style);
	            		return itemEl;	        			
            		}, 
            		orderable: false
            	},
	        	{ data: "title", orderable: false},
	        	{ data: "owner.nickname", orderable: false},
                { data: "orgText"  , render: function ( data, type, row ) {
                	return data.length < 30 ? data : data.substr( 0, 30 ) + " ...";
                	},
                	orderable: false         
                },
	        	{ data: "readCount", orderable: false},
	        	{ data: "likeCount", orderable: false},
	        	{ data: "commentCount", orderable: false},
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

	function getComments(postingId, lastId){

		var param = { "strMaxId": lastId };
	    $.ajax({
	        url:"/rest/"+postingId+"/getComments",
	        type:'POST',
	        data: param,
	        success:function(data){
	        	makeComments(data.data, postingId);
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            alert("에러 \n" + textStatus + " : " + errorThrown);
	        }
	    });
	}


	
    function makeComments(data, postingId) {
		var commentHtml = "<hr size='100%' style='margin-top: 0rem;margin-bottom: 0rem;'/>";
		commentHtml += "<div class='card-body'>";
		var firstId = 0;
		var lastId = 0;
		var commentCnt = data.length;
		$('#posting_detail_modal form[name=posting_detail_form] textarea[name=commentText]').val('');
		$('#posting_detail_modal form[name=posting_detail_form] input[name=commentFile]').val('');
		if (commentCnt > 0) {
			for (var i=0;i<data.length;i++) {
				if (i == 0) {
					firstId = data[i].id;
				}
				lastId = data[i].id;
				commentHtml += "<div class='media' style='margin-top:10px;'>";
				commentHtml += "<a class='media-left' href='#'>";
				commentHtml += "	<img src='"+getImage(data[i].owner.photoUrl, 'noimg.png')+"' style='width: 40px;height: 40px;border-radius: 10%;'>";
				commentHtml += "</a>";
				commentHtml += "<div class='media-body' style='margin-left: 10px;'>";
				commentHtml += "<h5 class='media-heading'>"+data[i].owner.nickname+"</h5>";
				if (data[i].isDelete) {
					commentHtml += "<span style='color:red;''>(삭제)</span> <span style='text-decoration: line-through;'>" + data[i].orgText + "</span>";
					commentHtml += "</br>";
					commentHtml += timeBefore(data[i].createdAt);					
				} else {
					commentHtml += data[i].text;
					commentHtml += "</br>";
					commentHtml += timeBefore(data[i].createdAt);
					commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='javascript:makereply(" +postingId+ "," +data[i].id + ");'>답글달기</a>";
					commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='javascript:blindComment(" +postingId+ "," +data[i].id + ");'>숨김</a></br>";					
				}
				
				commentHtml += "<div style='height:5px;''></div>";
				for (var j=0;j<data[i].attachments.length;j++) {	// 댓글이미지
					var imgUrl = getImage(data[i].attachments[j].photoUrl, 'upload.png');
					commentHtml += "<img src='"+imgUrl+"' style='width: 80%;'></br>";
				}

				commentHtml += "<div id='comment-"+lastId+"' class='input-group' style='display:none;'>";
				commentHtml += "	<div class='col-10' style=''>";		
				commentHtml += "	    <fieldset class='form-group' style='margin-top: 15px;margin-bottom: 10px;'>";						
//				commentHtml += "			<textarea rows='2' class='form-control' id='commentText-"+lastId+"' name='commentText-"+lastId+"' placeholder='댓글 입력'></textarea>	";									
				commentHtml += "			<textarea rows='2' class='form-control autosize' id='commentText' name='commentText' placeholder='답글 입력'></textarea>	";									
				commentHtml += "	    </fieldset>";        
				commentHtml += "	    <fieldset class='form-group'>";							
				commentHtml += "		<div class='fonticon-container'>";       
				commentHtml += "		    <div class='custom-file'>";	                                    	   
//				commentHtml += "			<input type='file' class='custom-file-input' id='replyFile-"+lastId+"' name='commentFile-"+lastId+"'>			";						                                        	
				commentHtml += "			<input type='file' class='custom-file-input' id='replyFile' name='replyFile'>			";						                                        	
				commentHtml += "			<label class='custom-file-label' for='replyFile' aria-describedby='댓글 첨부'></label>				";
				commentHtml += "		    </div>  ";											
				commentHtml += "		</div> ";
				commentHtml += "	    </fieldset>	";								
				commentHtml += "	</div>	";
				commentHtml += "	<div id='comment-7886730' class='col-2' style='margin-top: 15px;margin-bottom: 10px;'>";		
				commentHtml += "	    <button id='detail_to_modify' class='btn btn-success' type='button' onclick='javascript:createReply(" +postingId+ ", " + lastId + ")'><i class='la la-save'></i></button>					";																					
				commentHtml += "	</div>";
				commentHtml += "</div>";
				
				// 대댓글 영역
				var children = data[i].children;
				if (children.length > 0) {
					for (var j=0;j<children.length;j++) {	 
						commentHtml += "	<div class='media mt-1'>";
						commentHtml += "    	<a class='media-left' href='#'>";
						commentHtml += "        	<img src='"+getImage(children[j].owner.photoUrl, 'noimg.png')+"' style='width: 40px;height: 40px;border-radius: 10%;'>";
						commentHtml += "        </a>";
						commentHtml += "    	<div class='media-body'  style='margin-left: 10px;'>";
						commentHtml += "        	<h5 class='media-heading'>"+children[j].owner.nickname+"</h5>";
						if (children[j].isDelete) {
							commentHtml += "<span style='color:red;''>(삭제)</span> <span style='text-decoration: line-through;'>" + children[j].orgText + "</span>";
							commentHtml += "</br>";
							commentHtml += timeBefore(children[j].createdAt);							
						} else {
							commentHtml += children[j].text;
							commentHtml += "</br>";
							commentHtml += timeBefore(children[j].createdAt);
							commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='javascript:blindComment(" +postingId+ "," +children[j].id + ");'>숨김</a></br>";									
						}
	
						commentHtml += "<div style='height:5px;''></div>";
						var childrenAttach = children[j].attachments;
						if((typeof childrenAttach != "undefined") && (childrenAttach.length>0)){
			 				for (var k=0;k<childrenAttach.length;k++) {	 // 대댓글이미지
			 					commentHtml += "<img src='"+getImage(childrenAttach[k].photoUrl, 'upload.png')+"' style='width: 80%;'></br>";
							}
						}
						commentHtml += "			</div>";
						commentHtml += "    </div>";
					}
				}
				commentHtml += "</div>";
				commentHtml += "</div>	";
				
			}
			var pagingHtml = makePaging(postingId, lastId, commentCnt);
			commentHtml += pagingHtml; 
			commentHtml += "</div>	";
			
			//console.log(data[0].text);
			//console.log(commentHtml);
			prevCommentId = firstId;
			$('#commentArea').html(commentHtml);
		} else {
			$('#commentArea').html('');
		}
	}

	function makePaging(postingId, lastId, commentCnt){
//		console.log('prevCommentId : ' + prevCommentId);
//		console.log('lastId : ' + lastId);
		var pagingHtml = ""; 
		pagingHtml +="<div class='my-1'>";
		pagingHtml +="          <ul class='pager pager-round'>";
		
		if (prevCommentId==0) {
			pagingHtml +="              <li class='disabled'>";
			pagingHtml +="                  <a href='#'><i class='ft-arrow-left'></i> 이전</a>";
			pagingHtml +="              </li>";			
		} else {
			pagingHtml +="              <li class=''>";
			pagingHtml +="                  <a href='#' onclick='javascript:getComments("+postingId+", " + prevCommentId + ");'><i class='ft-arrow-left'></i> 이전</a>";
			pagingHtml +="              </li>";			
		}

		if (commentCnt < 5) {
			pagingHtml +="              <li class='disabled'>";
			pagingHtml +="                  <a href='#'>다음 <i class='ft-arrow-right'></i></a>";
			pagingHtml +="              </li>";			
		} else {
			pagingHtml +="              <li class=''>";
			pagingHtml +="                  <a href='#' onclick='javascript:getComments("+postingId+", " + (lastId-1) + ");'>다음 <i class='ft-arrow-right'></i></a>";
			pagingHtml +="              </li>";			
		}

		pagingHtml +="          </ul>";
		pagingHtml +="      </div>";
		return pagingHtml;
	}
	
	function detailView(dataSet) {
		changeScroll(true);
    	//$('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);
    	$('#detail_title').html(dataSet.title);
    	$('#detail_text').html("<span style='font-size: 110%;background-color: white;'>" +dataSet.orgText + "</span>");
    	$('#detail_user_nick').html(dataSet.owner.nickname);
    	$('#detail_createdAt').html(moment(dataSet.createdAt).format('YYYY-MM-DD HH:mm:ss'));
    	$('#detail_modifiedAt').html(moment(dataSet.modifiedAt).format('YYYY-MM-DD HH:mm:ss'));
	
    	$("#detail_user_photo").attr("src", getProfileImage(dataSet.owner.photoUrl, 'noimg.png'));

        $('#posting_detail_modal form[name=posting_modify_form] input[name=postingId]').empty().val(dataSet.id);
        $('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').empty().val(dataSet.id);
        $('#notification_modal form[name=notification_form] input[name=postingId]').empty().val(dataSet.id);
        
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
					contentsHtml += "<span class='text-muted'><span style='font-size: 110%;background-color: white;'><pre style='font-size: 110%;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;'>" + description + "</pre></span></span>";
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
		getComments(dataSet.id, 0);
	}
	function makereply(postingId, commentId) {
		$('#comment-'+commentId).toggle();
	}

	function blindComment() {
        event.preventDefault();
        var form = $('#posting_detail_form')[0];
        var data = new FormData(form);
        //$("#btnSubmit").prop("disabled", true);
        data.append("commentId", commentId);
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
	
	function blindPosting(postingId) {
	}
	
	function createReply(postingId, commentId) {
        event.preventDefault();
        var form = $('#posting_detail_form')[0];
        var data = new FormData(form);
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
            	setTimeout(function(){
            		getComments(postingId, 0)
            	}, 500);
            },
            error: function (e) {
                
                alert(e);
            }
        });
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
	
	function modifyView(dataSet) {
    	$('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);
    	$('#posting_modify_modal form[name=posting_modify_form] textarea[name=text]').empty().val(dataSet.orgText);
        $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').empty().val(dataSet.id);
        
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

	function findLastChild(parentNode) {
	    lastNode = parentNode.lastChild;
	    while (lastNode.nodeType != 1) {
	        lastNode = lastNode.previousSibling;
	    }
	    return lastNode;
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
		    	//$('#posting_add_form').submit();
		         doRestApi('#posting_add_form');
		         
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
	    	//$('#posting_modify_form').submit();
	    	doRestApi('#posting_modify_form');
    	}
    });
    	
    $('#delete').on('click', '', function () {
    	if (confirm('삭제하시겠습니까?')) {
	    	var postId = $('#posting_modify_modal form[name=posting_modify_form] input[name=postingId]').val();
	    	// $('#posting_modify_form').attr('action', "/admin/deletePosting").submit();
	    	doRestApi('#posting_modify_form', '/admin/deletePosting');
    	}
    });		
    function changeScroll(isBody) {
        if (isBody) {
	    	$("body").css({"overflow-y":"hidden"});
			$('#posting_modify_modal').css({"overflow-y":"auto"});
			$('#posting_detail_modal').css({"overflow-y":"auto"});
    	} else {
	    	$("body").css({"overflow-y":"auto"});
			$('#posting_modify_modal').css({"overflow-y":"hidden"});        	
			$('#posting_detail_modal').css({"overflow-y":"hidden"});        	
        }
    }
    /* $("#notification_modal").draggable();
    $("#posting_detail_modal_dialog").draggable();
    $("#posting_modify_modal_dialog").draggable();
    $("#posting_add_modal_dialog").draggable(); */
	</script>
    
