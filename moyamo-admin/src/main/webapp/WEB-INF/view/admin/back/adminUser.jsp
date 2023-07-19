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
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/tables/datatable/datatables.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/toggle/bootstrap-switch.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/toggle/switchery.min.css"> 
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
    <link rel="stylesheet" type="text/css" href="/static/app-assets/fonts/simple-line-icons/style.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/core/colors/palette-switch.css">   
    
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/static/assets/css/style.css">
    <!-- END: Custom CSS-->
    <style>
    .href_pointer{
        cursor: pointer;
    }
    .arrow-red{
   	    color: red;
   	    font-weight: 600;
    }
    .btn-custom-info:hover {
	    border-color: #cc514b !important;
	    background-color: #cc514b !important;
	}    
	div.dataTables_wrapper div.dataTables_filter {
	    text-align: left;
	}	
	
    .href_eventName{
        cursor: pointer;
    }
    .boldcolumn{
    	font-size: 13px;
   	    font-weight: 600;
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

			<!-- 계정관리 상세보기모달 -->
			<div class="modal fade text-left" id="user_detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header bg-success">
							<h3 class="modal-title white" style="font-size: 1.1rem;">
								<b> 계정관리 </b>
							</h3>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true" style="color: white;">&times;</span>
							</button>
						</div>
						<form name="user_detail_form" id="user_detail_form" action="/admin/modifyPosting" method="post" enctype="multipart/form-data">
							<input type="hidden" name="userId" value="">
							<div class="modal-body" style="padding: 0;">
								<div class="col-12">
									<div class="card">
				                    	<div class="text-center">
				                        	<div class="card-body">
				                            	<img id="photoUrl" src="/static/img/noimg.png" class="rounded-circle height-150 width-150" onerror="this.src='/static/img/noimg.png';" >
				                            </div>
				                        </div>				
									</div>
								</div>
								<div class="container">
									<div class="row align-items-center">
								    	<div class="col col-lg-8">기본정보</div>
								    	<div class="col col-lg-4">알림설정</div>
								  	</div>
								</div>
								<hr>
								<div class="container">
									<div class="row align-items-center" style="height: 35px;">
								    	<div class="col col-lg-2"><b>닉네임</b></div>
								    	<div class="col col-lg-6" id="nickname"></div>
								    	<div class="col col-lg-4">
								    		<button class="btn mr-1 mb-1 btn-danger btn-sm float-right" type="button" id="init_pwd">비밀번호 초기화</button>
								    	</div>
									</div>
									<hr style="margin-bottom: .5rem;"/>
									<div class="row align-items-center" style="height: 35px;">
								    	<div class="col col-lg-2"><b>그룹</b></div>
								    	<div class="col col-lg-4">
											<select class="custom-select custom-select-sm form-control form-control-sm" name="userRole" id="userRole" onchange="javascript:setRole(this.value);">
                                                <option value="ADMIN">관리자</option>
                                                <option value="EXPERT">전문가</option>
                                                <option value="USER">일반</option>
                                            </select>
								    	</div>
								    	<div class="col col-lg-6">
								    		<button class="btn mr-1 mb-1 btn-danger btn-sm float-right" type="button" id="init_pwd" style="width: 50px;" onclick="javascript:save_role_group();">저장</button>
								    	</div>								    	
									</div>
									<hr style="margin-bottom: .5rem;"/>
									<div class="row align-items-center" id="expert_group_view" style="height: 35px;display:none;">
								    	<div class="col col-lg-2"><b>세부그룹</b></div>
								    	<div class="col col-lg-10">
								    		<button class="btn mr-1 mb-1 btn-sm btn-outline-secondary" type="button" id="name" onclick="javascript:expert_detail_change('name');">이름</button>
								    		<button class="btn mr-1 mb-1 btn-sm btn-outline-secondary" type="button"  id="clinic" onclick="javascript:expert_detail_change('clinic');">클리닉</button>
								    		<button class="btn mr-1 mb-1 btn-sm btn-outline-secondary" type="button"  id="contents" onclick="javascript:expert_detail_change('contents');">컨텐츠</button>
								    	</div>
									</div>
								</div>
								<br/><br/>
								<div class="container">
									<div class="row align-items-center">
								    	<div class="col col-lg-12">개인정보</div>
								  	</div>
								</div>
								<hr>
								<div class="container">
									<div class="row align-items-center" style="height: 35px;">
								    	<div class="col col-lg-2"><b>전화번호</b></div>
								    	<div class="col col-lg-10" id="tel"></div>
									</div>
									<hr style="margin-bottom: .5rem;"/>
									<div class="row align-items-center" style="height: 35px;">
								    	<div class="col col-lg-2"><b>이메일</b></div>
								    	<div class="col col-lg-8" id="email"></div>
								    	<div class="col col-lg-2">
								    		<img src="/static/img/sns/kakao.png" style="height: 20px;width: 20px;border-radius: 10%;">
								    	</div>
									</div>									
								</div>									
								<hr style="margin-bottom: 3rem;"/>
								<div class="container">
									<div class="row align-items-center">
								    	<div class="col col-lg-12"><b>활동정보</b></div>
								  	</div>
								</div>
								<br/>
								<div class="container">
									<div class="table-responsive">
                                        <table class="table">
                                            <thead style="text-align: center;">
                                                <tr>
                                                    <th> </th>
                                                    <th>작성</th>
                                                    <th>신고</th>
                                                    <!-- <th>조회수</th> -->
                                                </tr>
                                            </thead>
                                            <tbody style="text-align: center;">
                                                <tr>
                                                    <th scope="row">게시글</th>
                                                    <td id="posting_cnt">1</td>
                                                    <td id="posting_alert_cnt"> </td>
                                                    <!-- <td id="posting_read_cnt">3</td> -->
                                                </tr>
                                                <tr>
                                                    <th scope="row">댓글</th>
                                                    <td id="comments_cnt">4</td>
                                                    <td id="comments_alert_cnt"> </td>
                                                    <!-- <td id="comments_read_cnt">6</td> -->
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>								
								</div>								
							</div>
							
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


            <div class="content-body">
                <!-- 이벤트 관리 -->
                <section id="sorting-scenario">
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
                                            <table class="table table-hover table-striped table-bordered zero-configuration" style="text-align:center;vertical-align:middle;width:100%;">
                                                <thead>
                                                    <tr>
                                                        <!-- <th>NO</th> -->
                                                        <th>프로필사진</th>
                                                        <th>닉네임</th>
                                                        <th>이메일</th>
                                                        <!-- <th>세부 그룹</th> -->
                                                        <th>가입일</th>
                                                        <!-- <th>최근 접속일</th> -->
                                                        <th>계정상태</th>
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
    <script src="/static/app-assets/vendors/js/tables/datatable/datatables.min.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/moment.min.js"></script>   
    <script src="/static/app-assets/js/scripts/tables/jquery.spring-friendly.js"></script> 
    <script src="/static/app-assets/vendors/js/forms/toggle/switchery.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-checkbox.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-switch.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/icheck/icheck.min.js"></script>
	<script src="/static/app-assets/js/core/libraries/jquery_ui/jquery-ui.min.js"></script>    
    <script src="/static/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jquery.sparkline.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/static/app-assets/js/core/app-menu.js"></script>
    <script src="/static/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->
    
    <!-- Validation -->
    <script src="/static/js/validation/jquery.validate.min.js"></script>
	<script src="/static/js/validation/additional-methods.min.js"></script>
	<script src="/static/js/validation/messages_ko.min.js"></script>
	    
    <script type="text/javascript">
    $(document).ready(function(){
		//메뉴 열린 모양
		$('.la-user').parent().parent().addClass('open active');
		$('#user-admin').addClass('active');
		//var dataSet = ${data};
		//console.log(dataSet);
		var table = $('.zero-configuration').DataTable({
			dom:
			    "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'>>" +
			    "<'row'<'col-sm-12'tr>>" +
			    "<'row'<'col-sm-4'i><'col-sm-8'p>>",
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
			'ajax' : {
				"url":'/rest/user/getList',
				"data":{
					"userRole":"ADMIN"					
				}
			},			
			'serverSide' : true,
			"processing" : true,  			
            "order": [3, "desc"],
            "createdRow": function( row, data, dataIndex){
            	$('td', row).eq(1).addClass('boldcolumn');
            },              
            columns: [
	        	{ data: "photoUrl", render: function(data, type, row, meta){
            		var setting = '?d=50x50';
            		var style = 'width: 50px;height: 50px;padding: 0rem;';
            		var itemEl = getImgSrc(data, setting, style);
            		return itemEl;
        			}, 
        			orderable: false
        		},
                { data: "nickname", searchable: true, orderable: true},
                { data: "provider", searchable: true, orderable: true},
                /* { data: "levelInfo.name", searchable: true, orderable: true}, */
                { data: "createdAt" , 
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	},
                	searchable: false
                },
                /* { data: "nickname", searchable: true, orderable: true}, */
                { data: "status", 
                	render: function(data, type, row, meta){
                    	var ret;
                		if (data == 'normal') {
                    		ret = "";
                    	} else if (data == 'ban') {
                    		ret = "차단";
                    	} else if (data == 'leave') {
                    		ret = "탈퇴";
                        }
                        return ret;
                	},
                    searchable: true, orderable: true}
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
	    		$('#user_detail_modal').modal('show'); 
	        	var dataSet = table.row( $(this).parent() ).data();
	        	detailView(dataSet);
	    	}
	    });

	});

	function detailView(dataSet){
		$('#user_detail_modal form[name=user_detail_form] input[name=userId]').empty().val(dataSet.id);
		$('#nickname').html(dataSet.nickname);
		$('#tel').html(dataSet.provider);
		$('#posting_cnt').html(dataSet.activity.postingCount);
		$('#comments_cnt').html(dataSet.activity.commentCount);
		$("#photoUrl").attr("src", getProfileImage(dataSet.photoUrl, 'noimg.png'));
		// role change
		init_expert_group();
		setRole(dataSet.role);
		for (var i=0;i<dataSet.expertGroup.length;i++) {
			expert_detail_change(dataSet.expertGroup[i].expertGroup);	
		}
	}

	function getProfileImage(url, defaultImg) {
		if(url == "" || url == null || (typeof(url) == 'undefined')){
			profileImage = '/static/img/'+defaultImg;
		}else{
			profileImage = url;
		}
		return 	profileImage;
	}

	function setRole(str){
		var divId = "#userRole";
		if (str == '' || str.toUpperCase() == 'USER') {
			$(divId).val('USER');
			$("#expert_group_view").hide();
		} else if (str.toUpperCase() == 'EXPERT') {
			$(divId).val('EXPERT');
			$("#expert_group_view").show();
		} else if (str.toUpperCase() == 'ADMIN') {
			$(divId).val('ADMIN');
			$("#expert_group_view").hide();
		}
		
	}

	function save_role_group() {
        event.preventDefault();
        var form = $('#user_detail_form')[0];
        var data = new FormData(form);
        //$("#btnSubmit").prop("disabled", true);
        var userId =$('#user_detail_modal form[name=user_detail_form] input[name=userId]').val();
        data.append("userId", userId);
        data.append("expertGroup", get_expert_group());
        if (confirm('그룹을 수정하시겠습니까?')) {
	        $.ajax({
	            type: "POST",
	            enctype: 'multipart/form-data',
	            url: "/rest/user/modifyUser",
	            data: data,
	            processData: false,
	            contentType: false,
	            cache: false,
	            timeout: 600000,
	            success: function (data) {
	            	alert('권한이 변경되었습니다.');
	            	window.location.reload();
	            },
	            error: function (e) {
	                alert(e);
	            }
	        });
        }
	}
	
	
    function expert_detail_change(item){
        //alert($(this).hasClass('btn-outline-secondary'));
    	if( $('#'+item).hasClass('btn-outline-secondary') ) {
    		$('#'+item).removeClass('btn-outline-secondary');
    		$('#'+item).addClass('btn-success');
        } else {
    		$('#'+item).removeClass('btn-success');
    		$('#'+item).addClass('btn-outline-secondary');
        }   
   }
    
    function init_expert_group(){
        //alert($(this).hasClass('btn-outline-secondary'));
    	if( $('#name').hasClass('btn-success') ) {
    		$('#name').removeClass('btn-success');
    		$('#name').addClass('btn-outline-secondary');
        }   
    	if( $('#clinic').hasClass('btn-success') ) {
    		$('#clinic').removeClass('btn-success');
    		$('#clinic').addClass('btn-outline-secondary');
        }   
    	if( $('#contents').hasClass('btn-success') ) {
    		$('#contents').removeClass('btn-success');
    		$('#contents').addClass('btn-outline-secondary');
        }   
    	
    }
    function get_expert_group(){
        var group = new Array;
        if ($('#name').hasClass('btn-success')) {
            group.push('NAME');
        }
        if ($('#clinic').hasClass('btn-success')) {
            group.push('CLINIC');
        }
        if ($('#contents').hasClass('btn-success')) {
            group.push('CONTENTS');
        }
        return group;
    }
	function getImgSrc(data, setting, style){
		if (data == null) {
			return '<img style="'+style+'" src="/static/img/noimg.png" alt="">';
		} else {
			return '<img class="img-thumbnail" onerror="this.src=/static/img/noimg.png;" style="'+style+'" src="'+data+setting+'" alt="">';
		}
	}      
	</script>
    
</body>
<!-- END: Body-->
</html>
