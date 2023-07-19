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
                                                        <th>카테고리</th>
                                                        <th>썸네일</th>
                                                        <th>제목</th>
                                                        <th>작성일</th>
                                                        <th>닉네임</th>
                                                        <th>내용</th>
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
                        if(data[0]) {
                            var setting = '?d=50x50';
                            var style = 'width: 50px;height: 50px;padding: 0rem;';
                            var itemEl = getImgSrc(data[0].photoUrl, setting, style);
                            return itemEl;
                        }
	            		return "-";
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


	    // 컨텐츠뷰
	    $('.zero-configuration tbody').on('click', 'td', function () {

	    	if('titlecolumn' == $(this)[0].className.trim()){

	    		$('#posting_detail_modal').modal('show');
	        	//var data = table.row( $(this) ).data();
	        	var dataSet = table.row( $(this).parent() ).data();

	        	//modifyView(dataSet);
	        	detailView(dataSet.posting);

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


        $("#posting_detail_modal").on("hidden.bs.modal", function () {
            // put your default event here
            console.log('hide')
            changeScroll(false);
        });


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


    function changeStatus(status, postingId, reportId) {
        var allData = { "reportStatus": status, "reportId" : reportId };
        $.ajax({
            url:"/rest/report/"+postingId+"/changeStatus",
            type:'POST',
            data: allData,
            success:function(data){
                if(data.resultCode == 1000){
                    alert('처리 완료');
                    $('.zero-configuration').DataTable().ajax.reload( null, false );
                    //window.location.reload();
                }else{
                    alert('처리 실패');
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러 \n" + textStatus + " : " + errorThrown);
            }
        });
    }


    </script>
