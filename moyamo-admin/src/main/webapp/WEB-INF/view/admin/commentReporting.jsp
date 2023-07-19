<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <!-- BEGIN: Content-->
        <div class="content-wrapper">
            <div class="content-body">

			<!-- 게시물 상세보기모달 -->
			<jsp:include page="partial/detailModal.jsp" flush="false">
				<jsp:param name="menuName" value='신고글보기' />
				<jsp:param name="readOnly" value='true' />
			</jsp:include>


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
                                                        <th>썸네일</th>
                                                        <th>내용</th>
                                                        <th>작성일</th>
                                                        <th>닉네임</th>
                                                        <th>신고 카테고리</th>
                                                        <th>신고 접수일</th>
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
    <!-- END: Content-->


    <script src="/static/assets/js/jquery.mentiony.js"></script>
    <script type="text/javascript">
    var prevCommentId = 0;
	$(document).ready(function(){
		setMenuName('${menuName}');

		var table = $('.zero-configuration').DataTable({
            "searching": false,
			dom:
			    "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'>>" +
			    "<'row'<'col-sm-12'tr>>" +
			    "<'row'<'col-sm-4'i><'col-sm-8'p>>",
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},

		    'ajax' : {
			    'url': '/rest/report/getCommentList',
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
                $('td', row).eq(1).addClass('titlecolumn'); // 내용
            	$('td', row).eq(2).addClass('titlecolumn'); // 제목
                $('td', row).eq(3).addClass('titlecolumn'); // 내용
            	$('td', row).eq(4).addClass('titlecolumn'); // 내용
            	$('td', row).eq(5).addClass('titlecolumn'); // 작성자
            	$('td', row).eq(6).addClass('titlecolumn'); // 신고자
            },
			columns: [
                { data: "comment.orgAttachments", render: function(data, type, row, meta){
	            		var setting = '?d=50x50';
	            		var style = 'width: 50px;height: 50px;padding: 0rem;';
	            		if(data != null && data.length > 0) {
                            var itemEl = getImgSrc(data[0].photoUrl, setting, style);
                            return itemEl;
                        } else {
                            return "-";
                        }
        			},
        			orderable: false
        		},
                { data: "comment.orgText", orderable: false},
                { data: "comment.createdAt" ,
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	},orderable: false
        		},
	            { data: "comment.owner.nickname", orderable: false, searchable: false},
	            { data: "title", orderable: false, searchable: false},
	            { data: "createdAt" ,
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	},orderable: false
        		},
        		{ data: "user.nickname", orderable: false, searchable: false},
        		{ data: "reportStatus", render: function(data, type, row, meta){
            			return renderingStatus(data, row.comment.id, row.id);
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
		                console.log(searchTerm);
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

	    // 유저뷰
	    $('.zero-configuration tbody').on('click', 'td', function () {
	    		//$('#posting_detail_modal').modal('show');
                if('titlecolumn' != $(this)[0].className.trim()){
                    return;
                }
	        	var dataSet = table.row( $(this).parent() ).data();
	        	//alert(2);
                $.ajax({
                    url : "/rest/getPosting?posting_id=" + dataSet.comment.postingId,
                    type:'GET',
                    success:function(data){
                        if(data){
                            //alert('처리 완료');
                            console.log(data.data);
                            $('#posting_detail_modal').modal('show');
                            detailView(data.data);
                            //$('.zero-configuration').DataTable().ajax.reload( null, false );
                        }else{
                            alert('처리 실패');
                        }
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                        alert("에러 \n" + textStatus + " : " + errorThrown);
                    }
                });
	    });

        $("#posting_detail_modal").on("hidden.bs.modal", function () {
            // put your default event here
            console.log('hide')
            changeScroll(false);
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

        function getImgSrc(data, setting, style){
            var itemEl = '<img class="img-thumbnail" style="'+style+'" src="'+data+setting+'" alt="">';
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
            ret +="			<button class='dropdown-item"+getActiveClass(data, 0)+"' type='button' onclick='javascript:changeStatus(\"WAIT\", "+postingId+", "+reportId+");'>미결</button>															"
            ret +="			<button class='dropdown-item"+getActiveClass(data, 1)+"' type='button' onclick='javascript:changeStatus(\"HOLD\", "+postingId+", "+reportId+");'>반려</button>													"
            ret +="			<button class='dropdown-item"+getActiveClass(data, 2)+"' type='button' onclick='javascript:changeStatus(\"BLOCK\", "+postingId+", "+reportId+");'>차단</button>														"
            ret +="    </div>																					"
            ret +="</div>																						"
            return ret;
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


	});


    function changeStatus(status, commentId, reportId) {
        var allData = { "reportStatus": status, "reportId" : reportId };
        $.ajax({
            url:"/rest/report/"+commentId+"/changeCommentStatus",
            type:'POST',
            data: allData,
            success:function(data){
                if(data.resultCode == 1000){
                    alert('처리 완료');
                    $('.zero-configuration').DataTable().ajax.reload( null, false );
                }else{
                    alert('처리 실패');
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러 \n" + textStatus + " : " + errorThrown);
            }
        });
    }

    function changeScroll(isBody, target) {
        console.log('changeScroll', isBody);
        if(target) {
            if (isBody) {
                $("body").css({"overflow-y":"hidden"});
                $(target).css({"overflow-y":"auto"});
            } else {
                $("body").css({"overflow-y":"auto"});
                $(target).css({"overflow-y":"hidden"});
            }
        } else {
            if (isBody) {
                $("body").css({"overflow-y":"hidden"});
                $('#posting_add_modal').css({"overflow-y":"auto"});
                $('#posting_modify_modal').css({"overflow-y":"auto"});
                $('#posting_detail_modal').css({"overflow-y":"auto"});
            } else {
                $("body").css({"overflow-y":"auto"});
                $('#posting_add_modal').css({"overflow-y":"hidden"});
                $('#posting_modify_modal').css({"overflow-y":"hidden"});
                $('#posting_detail_modal').css({"overflow-y":"hidden"});
            }
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

    function modifyView(dataSet) {
    }

    function bindMentiony() {
        $('textarea#commentText').mentiony({
            onDataRequest: function (mode, keyword, onDataRequestCompleteCallback) {

                var postingId = $('#posting_detail_modal_dialog input[name="postingId"]').val();
                var filterParam = postingId + (keyword) ? '&q='+keyword : '';
                $.ajax({
                    method: 'GET',
                    url: 'rest/getMentions?posting_id='+ postingId + filterParam,
                    dataType: 'json',
                    success: function (response) {
                        var result = response;
                        if(result.resultCode != 1000) {
                            alert(result.resultMsg);
                        }

                        var data = result.resultData;
                        // NOTE: Assuming this filter process was done on server-side
                        data = jQuery.grep(data, function( item ) {
                            return item.nickname.toLowerCase().indexOf(keyword.toLowerCase()) > -1;
                        });
                        // End server-side
                        // Call this to populate mention.
                        onDataRequestCompleteCallback.call(this, data);
                    }
                });
            },
            timeOut: 500,
            debug: 1
        });
    }

	</script>
