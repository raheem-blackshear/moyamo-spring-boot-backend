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
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/toastr.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/extensions/toastr.css">    
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/static/assets/css/style.css">
    <!-- END: Custom CSS-->
    <style>
    .btn-custom-info:hover {
	    border-color: #cc514b !important;
	    background-color: #cc514b !important;
	}
	div.dataTables_wrapper div.dataTables_filter {
	    text-align: left;
	}
	.commentTime{
	    font-size: 11px;
    	color: #bbbbbb;
	}
	.commentBorderCss{
		border-style: groove;
    	border-color: deeppink;
    	border-radius: 5px;
	}
    .titlecolumn{
	    padding: 0;
	    font-weight: bold;
	    font-size: 13px;
	    background-color: transparent;
	    text-align: center;
    }
    .usercolumn{
	    padding: 0;
	    font-weight: bold;
	    font-size: 13px;
	    background-color: transparent;
	    text-align: center;
    }
	</style>      
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
            <div class="content-body">
            
			<!-- 게시물 상세보기모달 -->
			<div class="modal fade text-left" id="posting_detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header bg-success">
							<h3 class="modal-title white" style="font-size: 1.1rem;">
								<b id="detail_title"> 게시물 상세</b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
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
<!-- 							<div id="comment" class="input-group" style="border-top: 1px solid #626E82;">
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
							</div> -->
							<!--  모달 푸터 -->		
<!-- 							<div class="modal-footer" style="background: lightgray;">
								<button id="detail_to_modify" class="btn btn-success" type="button">
									<i class="la la-save"></i> 컨텐츠 수정
								</button>
							</div>	 -->							
						</form>
					</div>
				</div>
			</div>
                
                
                <!-- 신고 관리 -->
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
                                                        <th>카테고리</th>
                                                        <th>썸네일</th>
                                                        <th>제목</th>
                                                        <th>작성일</th>
                                                        <th>닉네임</th>
                                                        <th>내용</th>
                                                        <th>신고 카테고리</th>
                                                        <th>신고 접수일</th>
                                                        <th>신고 내용</th>
                                                        <th>신고자</th>
                                                        <th>처리</th>
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
                <!-- 후기 관리 -->
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
    <script src="/static/app-assets/vendors/js/forms/icheck/icheck.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/switchery.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jquery.sparkline.min.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/datatables.min.js"></script>
    <script src="/static/app-assets/js/core/libraries/jquery_ui/jquery-ui.min.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/moment.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/static/app-assets/js/core/app-menu.js"></script>
    <script src="/static/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="/static/app-assets/js/scripts/tables/components/table-components.js"></script>
    <script src="/static/app-assets/js/scripts/ui/jquery-ui/dialog-tooltip.js"></script>
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
		$('.la-warning').parent().parent().addClass('open active');
		$('#reportBoardManagement').addClass('active');
		
		
		var table = $('.zero-configuration').DataTable({
			dom:
			    "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'>>" +
			    "<'row'<'col-sm-12'tr>>" +
			    "<'row'<'col-sm-4'i><'col-sm-8'p>>",
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},	
		    
		    'ajax' : {
			    'url': '/rest/report/getList',
			    'type': 'GET',
			    error: function (jqXHR, textStatus, errorThrown) {
	                console.log(jqXHR);
	                console.log(textStatus);
	                console.log(errorThrown);
	            }
			  },
			'serverSide' : true,
			"order": [[ 7, "desc" ]],
			
            "createdRow": function( row, data, dataIndex){
            	$('td', row).eq(2).addClass('titlecolumn'); // 제목
            	$('td', row).eq(5).addClass('titlecolumn'); // 내용
            	
            	$('td', row).eq(4).addClass('usercolumn'); // 작성자
            	$('td', row).eq(9).addClass('usercolumn'); // 신고자
            }, 
			columns: [
                { data: "postingType" , render: function(data, type, row, meta){
            		return getPostingTypeText(data)
            		}, 
            		searchable: false 
            	},
                { data: "posting.orgAttachments", render: function(data, type, row, meta){
	            		var setting = '?d=50x50';
	            		var style = 'width: 50px;height: 50px;padding: 0rem;';
	            		var itemEl = getImgSrc(data[0].photoUrl, setting, style);
	            		return itemEl;
        			}, 
        			orderable: false
        		},
                { data: "posting.title", orderable: false},
                { data: "posting.createdAt" , 
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	},orderable: false
        		},
	            { data: "posting.owner.nickname", orderable: false, searchable: false},
	            { data: "posting.orgText", orderable: false, searchable: false},
	            { data: "title", orderable: false, searchable: false},
	            { data: "createdAt" , 
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	},orderable: false
        		},
        		{ data: "text", orderable: false, searchable: false},
        		{ data: "user.nickname", orderable: false, searchable: false},
        		{ data: "reportStatus", render: function(data, type, row, meta){
            			return renderingStatus(data, row.posting.id, row.id);
        			}, 
        			orderable: false, searchable: false
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


	    // 컨텐츠뷰
	    $('.zero-configuration tbody').on('click', 'td', function () {
	    	
	    	if('titlecolumn' == $(this)[0].className.trim()){	

	    		$('#posting_detail_modal').modal('show');
	        	//var data = table.row( $(this) ).data(); 
	        	var dataSet = table.row( $(this).parent() ).data();

	        	//modifyView(dataSet);
	        	detailView(dataSet);
	    		
	    	}
	    });

	    // 유저뷰
	    $('.zero-configuration tbody').on('click', 'td', function () {
	    	if('usercolumn' == $(this)[0].className.trim()){	
	    		//$('#posting_detail_modal').modal('show');
	        	var dataSet = table.row( $(this).parent() ).data();
	        	//alert(2);
	        	//detailView(dataSet);
	    	}
	    });
	    
	});

	function detailView(dataSet) {
		console.log(dataSet);
    	//$('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);
    	$('#detail_title').html(dataSet.posting.title);
    	$('#detail_text').html("<span style='font-size: 110%;background-color: white;'>" +dataSet.posting.orgText + "</span>");
    	$('#detail_user_nick').html(dataSet.posting.owner.nickname);
    	$('#detail_createdAt').html(moment(dataSet.posting.createdAt).format('YYYY-MM-DD HH:mm:ss'));
    	$('#detail_modifiedAt').html(moment(dataSet.posting.modifiedAt).format('YYYY-MM-DD HH:mm:ss'));
	
    	$("#detail_user_photo").attr("src", getProfileImage(dataSet.posting.owner.photoUrl, 'noimg.png'));

        $('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').empty().val(dataSet.posting.id);
        
        /* var count = $(this).parent()[0].childElementCount;
        console.log($("#posting_modify_modal form[name=posting_modify_form] input[name^='repeater-list'").parent()[0].childElementCount); */
        //$('.delete_photo').click();
        var contentsHtml = "";
        for(var i=0; i < dataSet.posting.orgAttachments.length; i++){
            var imgUrl = dataSet.posting.orgAttachments[i].photoUrl;
            var description = dataSet.posting.orgAttachments[i].description;
            
        	contentsHtml += "<div class='media'>";
			contentsHtml += "<div class='media-body' style='margin-left: 0px;'>";
			contentsHtml += "<img src='" + imgUrl + "' style='width:100%;'/>";
			contentsHtml += "</div>";
			contentsHtml += "</div>";
				contentsHtml += "<div class='media'>";
				contentsHtml += "<div class='media-body' style='margin-left: 10px;margin-top:10px;margin-bottom:20px;'>";
				if(typeof description != "undefined"){
					contentsHtml += "<span class='text-muted'><span style='font-size: 110%;background-color: white;'><pre style='word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;'>" + description + "</pre></span></span>";
				}			
				contentsHtml += "</div>";
				contentsHtml += "</div>";
   		}
        $('#detail_attach_view').html(contentsHtml);
        $('#detail_likecnt').html(dataSet.posting.likeCount);
        $('#detail_scrapcnt').html(dataSet.posting.scrapCount);
        $('#detail_viewcnt').html(dataSet.posting.readCount);
        $('#detail_commentcnt').html(dataSet.posting.commentCount);
        getComments(dataSet.posting.id, 0);
	}

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
					//commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='javascript:makereply(" +postingId+ "," +data[i].id + ");'>답글달기</a>";
					//commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='javascript:blindComment(" +postingId+ "," +data[i].id + ");'>숨김</a></br>";					
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
							//commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='javascript:blindComment(" +postingId+ "," +children[j].id + ");'>숨김</a></br>";									
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
	
	function getImgSrc(data, setting, style){
		var imgUrl = getImage(data, 'upload.png');
		var itemEl = '<img class="img-thumbnail" style="'+style+'" src="'+imgUrl+setting+'" alt="">';
		return itemEl;
	}
	
	function getProfileImage(url, defaultImg) {
		if(url == "" || url == null || (typeof(url) == 'undefined')){
			profileImage = '/static/img/'+defaultImg;
		}else{
			profileImage = url;
		}
		return 	profileImage;
	}

	function getPostingTypeText(type) {
		var ret;
		if (type == 'magazine') {
			ret = "매거진";
		} else if (type == 'guidebook') {
			ret = "가이드북";
		} else if (type == 'question') {
			ret = "이름이모야";
		} else if (type == 'clinic') {
			ret = "식물클리닉";
		} else if (type == 'boast') {
			ret = "자랑하기";
		} else if (type == 'free') {
			ret = "자유수다";
		} else {
			ret = "기타";
		}
		return ret;
	}
	
	function getStatusText(type) {
		var ret;
		if (type == 'WAIT') {
			ret = "미결";
		} else if (type == 'HOLD') {
			ret = "반려";
		} else if (type == 'BLOCK') {
			ret = "차단";
		}
		return ret;
	}

	function renderingStatus(data, postingId, reportId) {
		var ret = "";
		ret +="<div class='btn-group'>																		"
			ret +="    <button type='button' class='btn"+getActiveClass2(data)+" dropdown-toggle btn-sm' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>						"
			ret +=  	getStatusText(data)
			ret +="    </button>																					"
			ret +="    <div class='dropdown-menu dropdown-menu-sm arrow-left' x-placement='bottom-start' style='position: absolute; will-change: transform; top: -50px; left: -50px; transform: translate3d(0px, 0px, 0px);'>"
			ret +="			<button class='dropdown-item"+getActiveClass(data, 0)+"' type='button' onclick='javascript:chagneStatus(\"WAIT\", "+postingId+", "+reportId+");'>미결</button>															"
			ret +="			<button class='dropdown-item"+getActiveClass(data, 1)+"' type='button' onclick='javascript:chagneStatus(\"HOLD\", "+postingId+", "+reportId+");'>반려</button>													"
			ret +="			<button class='dropdown-item"+getActiveClass(data, 2)+"' type='button' onclick='javascript:chagneStatus(\"BLOCK\", "+postingId+", "+reportId+");'>차단</button>														"
			ret +="    </div>																					"
			ret +="</div>																						"	
		return ret;	
	}

	function chagneStatus(status, postingId, reportId) {
		var allData = { "reportStatus": status, "reportId" : reportId };
	    $.ajax({
	        url:"/rest/report/"+postingId+"/changeStatus",
	        type:'POST',
	        data: allData,
	        success:function(data){
	        	if(data.resultCode == 1000){
	        		alert('처리 완료');
					window.location.reload();
	        	}else{
	        		alert('처리 실패');
	        	}
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            alert("에러 \n" + textStatus + " : " + errorThrown);
	        }
	    });	
	}

	
	function getActiveClass(status, id) {
		var ret = "";
		if (status == 'WAIT' && id == 0) {
			ret = " active";
		}
		if (status == 'HOLD' && id == 1) {
			ret = " active";
		}
		if (status == 'BLOCK' && id == 2) {
			ret = " active";
		}
		return ret;
	}
	
	function getActiveClass2(status) {
		var ret = "";
		if (status == 'WAIT') {
			ret = " badge-success";
		}
		if (status == 'HOLD') {
			ret = " badge-secondary";
		}
		if (status == 'BLOCK') {
			ret = " badge-danger";
		}
		return ret;
	}
	</script>
    
</body>
<script src="/static/app-assets/vendors/js/extensions/toastr.min.js"></script>
<script src="/static/app-assets/js/scripts/extensions/toastr.js"></script>
<!-- END: Body-->
</html>
