<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        <!-- BEGIN: Content-->
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
								    		<button class="btn mr-1 mb-1 btn-secondary btn-sm float-right" type="button" id="init_pwd">비밀번호 초기화</button>
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

									<div class="row align-items-center" style="height: 35px;">
										<div class="col col-lg-2"><b>상태</b></div>
										<div class="col col-lg-4">
											<select class="custom-select custom-select-sm form-control form-control-sm" name="userStatus" id="userStatus" onchange="javascript:setStatus(this.value);">
												<option value="NORMAL">정상</option>
												<option value="BAN">차단</option>
												<option value="LEAVE">탈퇴</option>
											</select>
										</div>
										<div class="col col-lg-6">
											<button class="btn mr-1 mb-1 btn-danger btn-sm float-right" type="button" id="init_pwd" style="width: 50px;" onclick="javascript:save_status();">저장</button>
										</div>
									</div>

									<hr style="margin-bottom: .5rem;"/>

									<div class="row align-items-center" style="height: 100px;">
										<div class="col col-lg-2"><b>메모</b></div>
										<div class="col col-lg-4">
											<textarea id="memo" rows="5" style="resize: none;"></textarea>
										</div>
										<div class="col col-lg-6">
											<button class="btn mr-1 mb-1 btn-danger btn-sm float-right" type="button" id="save_memo_btn" style="width: 50px;" onclick="javascript:saveMemo();">저장</button>
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
								    	<div class="col col-12">개인정보</div>
								  	</div>
								</div>
								<hr>
								<div class="container">
									<div class="row align-items-center" style="height: 35px;">
								    	<div class="col col-2">가입매체(<span id="provider"><b>전화번호</b></span>)</div>
								    	<div class="col col-8" id="providerId"></div>
										<div class="col col-2" id="sns">

										</div>
									</div>

									<div class="row align-items-center" style="height: 55px;" id="phoneVerifyView" >
										<div class="col col-2"><b>인증정보</b></div>
										<div class="col col-6" id="phoneVerifyInfo">
										</div>
										<div class="col col-4">
											<button class="btn mr-1 mb-1 btn-danger btn-sm float-right" type="button" onclick="javascript:phoneVerifyViewFn()">인증번호조회</button>
										</div>
									</div>
									<hr style="margin-bottom: .5rem;"/>

									<div class="row align-items-center" style="height: 55px;" id="emailVerifyView" >
										<div class="col col-2"><b>인증정보</b></div>
										<div class="col col-6" id="emailVerifyInfo">
										</div>
										<div class="col col-4">
											<button class="btn mr-1 mb-1 btn-danger btn-sm float-right" type="button" onclick="javascript:emailVerifyViewFn()">인증번호조회</button>
										</div>
									</div>

									<hr style="margin-bottom: .5rem;"/>
									<div class="row align-items-center" style="height: 35px;">
										<div class="col col-2"><b>쇼핑몰ID</b></div>
										<div class="col col-10" id="shopUserId"></div>
									</div>
									<hr style="margin-bottom: .5rem;"/>
									<div class="row align-items-center" >
										<div class="col col-2" id="badgesCnt"></div>
										<div class="col col-10" id="badges"></div>
									</div>
									<hr style="margin-bottom: .5rem;"/>
									<div class="row align-items-center" style="height: 35px;">
										<div class="col col-2"><b>포토<br>활성화</b></div>
										<div class="col col-2" id="photoEnable"></div>
										<div class="col col-lg-4">
											<select class="custom-select custom-select-sm form-control form-control-sm" id="photoEnableSelect">
												<option value="true">활성화</option>
												<option value="false">비활성화</option>
											</select>
										</div>
										<div class="col col-lg-4">
											<button class="btn mr-1 mb-1 btn-danger btn-sm float-right" type="button" id="photoEnableSelect_sub" style="width: 50px;">저장</button>
										</div>
									</div>
								</div>
								<hr style="margin-bottom: 3rem;"/>
								<div class="container">
									<div class="row align-items-center">
								    	<div class="col col-12"><b>활동정보</b></div>
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
                                                    <td id="posting_cnt">-</td>
                                                    <td id="posting_alert_cnt">-</td>
                                                    <!-- <td id="posting_read_cnt">3</td> -->
                                                </tr>
                                                <tr>
                                                    <th scope="row">댓글</th>
                                                    <td id="comments_cnt">-</td>
                                                    <td id="comments_alert_cnt">-</td>
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
														<th>ID</th>
                                                        <th>프로필사진</th>
                                                        <th>닉네임</th>
                                                        <th>아이디</th>
                                                        <th>가입수단</th>
                                                        <th>게시글</th>
                                                        <th>댓글</th>
                                                        <th>계정상태</th>
                                                        <th>가입일</th>
                                                        <!-- <th>최근 접속일</th> -->
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
    <!-- END: Content-->


    <script type="text/javascript">
    $(document).ready(function(){
    	setMenuName('${menuName}');

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
					"userRole":"USER"
				}
			},
			'serverSide' : true,
			"processing" : true,
            "order": [3, "desc"],
            "createdRow": function( row, data, dataIndex){
            	$('td', row).eq(2).addClass('boldcolumn').css('cursor', 'pointer');
            },
            columns: [
				{ data: "id", searchable: true, orderable: false},
	        	{ data: "photoUrl", render: function(data, type, row, meta){
            		var setting = '?d=50x50';
            		var style = 'width: 50px;height: 50px;padding: 0rem;';
            		var itemEl = getImgSrc(data, setting, style);
            		return itemEl;
        			},
        			orderable: false
        		},
                { data: "nickname", searchable: true, orderable: false},
                { data: "providerId", searchable: true, orderable: false},
                { data: "provider", searchable: true, orderable: false},
                { data: "activity.postingCount", searchable: true, orderable: false},
                { data: "activity.commentCount", searchable: true, orderable: false},
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
                    searchable: true, orderable: false},
                { data: "createdAt" ,
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	},
                	searchable: false, orderable: false
                }
                /* { data: "nickname", searchable: true, orderable: true}, */
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
	        if(this.value.length >= 1 || e.keyCode == 13) {
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
				$('#badges').empty();
	        	detailView(dataSet);
	    	}
	    });

		$('#init_pwd').on('click', function () {

			var result = prompt('초기화할 비밀번호를 입력해주세요.');
			console.log('result', result);
			if(result == null || result == '') {
				return;
			}

			var userId = $('#user_detail_modal form[name=user_detail_form] input[name=userId]').val();

			var data = new FormData();
			data.append("userId", userId);
			data.append("resetPassword", result);

			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: "/rest/user/resetPassword",
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

					alert('\''+ result +'\' 로 초기화되었습니다.');
				},
				error: function (e) {
					alert(e);
				}
			});
		});
		//ready end

	});

	function detailView(dataSet){
		$('#user_detail_modal form[name=user_detail_form] input[name=userId]').empty().val(dataSet.id);
		$('#nickname').html(dataSet.nickname);

		$('#user_detail_modal #provider').html('<b>' + dataSet.provider + '</b>')
		$('#user_detail_modal #providerId').html('<b>' + dataSet.providerId + '</b>')

		$('#phoneVerifyView').css('display', 'none');
		$('#emailVerifyView').css('display', 'none');
		$('#sns').html('');
		$('#phoneVerifyInfo').html('');
		$('#emailVerifyInfo').html('');

		if(dataSet.provider === 'phone') {
			$('#phoneVerifyView').css('display', '');
		} else if(dataSet.provider === 'email') {
			$('#emailVerifyView').css('display', '');
		} else if(dataSet.provider == 'kakao') {
			$('#sns').html('<span><img src="/static/img/sns/kakao.png" style="height: 20px;width: 20px;border-radius: 10%;"></span>');
		} else if(dataSet.provider == 'naver') {
			$('#sns').html('<span><img src="/static/img/sns/naver.png" style="height: 20px;width: 20px;border-radius: 10%;"></span>');
		} else if(dataSet.provider == 'facebook') {
			$('#sns').html('<span><img src="/static/img/sns/facebook.png" style="height: 20px;width: 20px;border-radius: 10%;"></span>');
		} else if(dataSet.provider == 'apple') {
			$('#sns').html('<span><img src="/static/img/sns/apple.png" style="height: 20px;width: 20px;border-radius: 10%;"></span>');
		}

		$('#posting_cnt').html(dataSet.activity.postingCount);
		$('#comments_cnt').html(dataSet.activity.commentCount);

		$('#posting_alert_cnt').html(dataSet.reportPostingCount);
		$('#comments_alert_cnt').html(dataSet.reportCommentCount);
		$('#memo').val(dataSet.memo);

		$('#shopUserId').text(dataSet.shopUserId);
		$("#photoUrl").attr("src", getProfileImage(dataSet.photoUrl, 'noimg.png'));
		$('#photoEnable').text(dataSet.photoEnable);
		// role change
		init_expert_group();
		setRole(dataSet.role);
		setStatus(dataSet.status);
		for (var i=0;i<dataSet.expertGroup.length;i++) {
			expert_detail_change(dataSet.expertGroup[i].expertGroup);
		}

		$("#badgesCnt").html("<b>뱃지 ("+dataSet.myBadges.length+") </b>");
		for(var index in dataSet.myBadges){
			var badge = dataSet.myBadges[index];
			var title = badge.title;
			var srcUrl = badge.imageUrl;

			$("#badges").append($("<img>", {
				src: srcUrl,
				title: title,
				style: "width: 20px; height: 20px;"
			}).mouseover(function () {
			}));
		}
	}

	$('#photoEnableSelect_sub').on('click', function () {
		var userId = $('#user_detail_modal form[name=user_detail_form] input[name=userId]').val();
		var result = $('#photoEnableSelect').val();

		var data = new FormData();
		data.append("userId", userId);
		data.append("photoEnable", result);

		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/rest/user/modifyPhotoEnable",
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

				alert('포토 활성화가 '+'\''+ result +'\' 로 저장되었습니다.');
				window.location.reload();
			},
			error: function (e) {
				alert(e);
			}
		});

	});

	function phoneVerifyViewFn() {
		var userId = $('#user_detail_modal form[name=user_detail_form] input[name=userId]').val();
		$.ajax(
			{
				url:'/rest/user/phoneVerifyInfo/' + userId,
				success:function(data) {
					if(data && data.authIdKey) {
						var msg = "인증번호 : " + data.authIdKey + "<br>"
								+ "발송시간 : " + data.authIdKeySendedAt;
						console.log(msg);
						$('#phoneVerifyInfo').html(msg);
					} else {
						alert("인증정보가 존재하지 않습니다.");
					}

				}, error: function(request, status, error) {
					//console.log(a, b, c);
					alert('에러가 발생했습니다.');
				}
			});
	}

	function emailVerifyViewFn() {
		var userId = $('#user_detail_modal form[name=user_detail_form] input[name=userId]').val();
		$.ajax(
				{
					url:'/rest/user/emailVerifyInfo/' + userId,
					success:function(data) {
						if(data && data.authKey) {
							var msg = "인증번호 : " + data.authKey + "<br>"
									+ "발송시간 : " + data.authMailSendedAt;
							console.log(msg);
							$('#emailVerifyInfo').html(msg);
						} else {
							alert("인증정보가 존재하지 않습니다.");
						}

					}, error: function(request, status, error) {
						//console.log(a, b, c);
						alert('에러가 발생했습니다.');
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

	function setStatus(str){
		var divId = "#userStatus";
		if (str == '' || str.toUpperCase() == 'LEAVE') {
			$(divId).val('LEAVE');
		} else if (str.toUpperCase() == 'BAN') {
			$(divId).val('BAN');
		} else if (str.toUpperCase() == 'NORMAL') {
			$(divId).val('NORMAL');
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
					$('.zero-configuration').DataTable().ajax.reload(null, false);
	            },
	            error: function (e) {
	                alert(e);
	            }
	        });
        }
	}

	function save_status() {
		event.preventDefault();
		var form = $('#user_detail_form')[0];
		var data = new FormData(form);
		//$("#btnSubmit").prop("disabled", true);
		var userId =$('#user_detail_modal form[name=user_detail_form] input[name=userId]').val();
		data.append("userId", userId);
		if (confirm('상태를 수정하시겠습니까?')) {
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: "/rest/user/modifyUserStatus",
				data: data,
				processData: false,
				contentType: false,
				cache: false,
				timeout: 600000,
				success: function (data) {
					alert('상태가 변경되었습니다.');
					$('.zero-configuration').DataTable().ajax.reload(null, false);
				},
				error: function (e) {
					alert(e);
				}
			});
		}
	}

	function saveMemo() {
		event.preventDefault();
		var data = new FormData();
		data.append('memo', $('#memo').val())
		//$("#btnSubmit").prop("disabled", true);
		var userId =$('#user_detail_modal form[name=user_detail_form] input[name=userId]').val();
		data.append("userId", userId);
		if (confirm('메모를 수정하시겠습니까?')) {
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: "/rest/user/memo",
				data: data,
				processData: false,
				contentType: false,
				cache: false,
				timeout: 600000,
				success: function (data) {
					alert('수정되었습니다.');
					$('.zero-configuration').DataTable().ajax.reload(null, false);
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
			return '<img class="img-thumbnail" style="'+style+'" src="'+data+setting+'" alt="">';
		}
	}
	</script>
