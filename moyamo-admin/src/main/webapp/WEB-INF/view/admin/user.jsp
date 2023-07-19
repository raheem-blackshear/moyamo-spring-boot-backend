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
<!--             <div class="content-header row">
                <div class="content-header-left col-md-6 col-12 mb-2 breadcrumb-new">
                    <h3 class="content-header-title mb-0 d-inline-block">유저 관리</h3>
                </div>
            </div> -->
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
                                                        <th>닉네임</th>
                                                        <th>가입경로</th>
                                                        <th>이메일</th>
                                                        <th>후기작성</th>
                                                        <th>댓글</th>
                                                        <th>좋아요</th>
                                                        <th>에이전시 여부</th>
                                                        <th>가입일</th>
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
    <script src="/static/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jquery.sparkline.min.js"></script>
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
    	setMenuName('${menuName}');

		//메뉴 열린 모양
		$('.la-user').parent().parent().addClass('open active');
		//var dataSet = ${data};
		//console.log(dataSet);
		var table = $('.zero-configuration').DataTable({
			dom:
			    "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'>>" +
			    "<'row'<'col-sm-12'tr>>" +
			    "<'row'<'col-sm-4'i><'col-sm-8'p>>",
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
			'ajax' : '/admin/data/userList',
			'serverSide' : true,
			"processing" : true,
            "order": [7, "desc"],
            "createdRow": function( row, data, dataIndex){
            	$('td', row).eq(0).addClass('boldcolumn');
            },
            columns: [
/*                 { data: "id", render: function (data, type, row, meta) {
					return meta.row + meta.settings._iDisplayStart + 1;
				  }
                }, */
                { data: "name", searchable: true, orderable: true},
                { data: "provider", searchable: false, orderable: false },
                { data: "email", searchable: true, orderable: false },
                { data: "reviewCnt", searchable: false, orderable: true },
                { data: "commentCnt", searchable: false, orderable: true },
                { data: "likeCnt", searchable: false, orderable: true },
                { data: "isAgency", searchable: false, orderable: true },
                { data: "createdAt",
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	}, searchable: false, orderable: true
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
	            var data = table.row( $(this).parent() ).data();
	            registAgency(data);
        	}
        });

        $('#init_pwd').on('click', function () {
            var result = prompt('초기화할 비밀번호를 입력해주세요.');
            console.log('result', result);
            if(result == null || result == '') {
                return;
            }

            var userId = $('#user_detail_modal form[name=user_detail_form] input[name=userId]').val();

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/rest/user/resetPassword",
                data: {
                    userId : userId,
                    resetPassword : result
                },
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    alert('\''+ result +'\' 로 초기화되었습니다.');
                    window.location.reload();
                },
                error: function (e) {
                    alert(e);
                }
            });
        });
        //ready end
	});

	function registAgency(data){
		if (confirm(data.name + ' 을 에이전시로 등록하시겠습니까?')) {
			var allData = { "user_info_id": data.id, };
		    $.ajax({
		        url:"/api/web/v1/regist_agency",
		        type:'POST',
		        data: allData,
		        success:function(data){
		        	if(data.resultCode == 1000){
		        		alert("등록 완료!");
		        		window.location.reload();
		        	}else{
		        		alert('권한 없음!');
		        	}
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		            alert("에러 \n" + textStatus + " : " + errorThrown);
		        }
		    });
		}
	}
	</script>

</body>
<!-- END: Body-->
</html>
