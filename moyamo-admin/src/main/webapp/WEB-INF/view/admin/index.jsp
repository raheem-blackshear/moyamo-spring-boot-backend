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
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/tables/extensions/buttons.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/toggle/bootstrap-switch.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/toggle/switchery.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/pickers/daterange/daterangepicker.css">
<!--     reporting -->
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/icheck/custom.css">
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
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/charts/jquery-jvectormap-2.0.3.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/charts/morris.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/fonts/simple-line-icons/style.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/forms/switch.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/core/colors/palette-switch.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/toastr.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/extensions/toastr.css">

<!--     reporting -->
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/core/colors/palette-callout.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/ui/jqueryui.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/pages/ecommerce-shop.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/pickers/daterange/daterange.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/bootstrap-select/bootstrap-select.css" />
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/static/assets/css/style.css">
    <!-- END: Custom CSS-->

     <!-- BEGIN: Vendor CSS-->

    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/datedropper.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/timedropper.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="/static/app-assets/fonts/simple-line-icons/style.min.css">
    <!-- END: Theme CSS-->

    <style type="text/css">
    .main-menu{
    	display: block;
    }

    div.dataTables_wrapper div.dataTables_processing{
    	border: 1px solid #000;
    }
    </style>
</head>
<body class="vertical-layout vertical-menu-modern 2-columns fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="2-columns">

	<!-- Top -->
    <%@ include file="/WEB-INF/view/admin/common/top.jsp"%>
    <!-- Top -->

	<!-- MainMenu -->
    <%@ include file="/WEB-INF/view/admin/common/nav.jsp"%>
    <!-- MainMenu -->

    <!-- BEGIN: Content-->
    <div class="app-content content"></div>
    <!-- END: Content-->

    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

	<!-- Footer -->
    <%@ include file="/WEB-INF/view/admin/common/footer.jsp"%>
    <!-- Footer -->

	<!-- BEGIN: Vendor JS-->
    <script src="/static/app-assets/vendors/js/vendors.min.js"></script>
    <script src="/static/app-assets/js/core/libraries/jquery_ui/jquery-ui.min.js"></script>
    <script src="/static/app-assets/data/jvector/visitor-data.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="/static/app-assets/vendors/js/charts/chart.min.js"></script>
    <script src="/static/app-assets/vendors/js/charts/raphael-min.js"></script>
    <script src="/static/app-assets/vendors/js/charts/morris.min.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jvector/jquery-jvectormap-2.0.3.min.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jvector/jquery-jvectormap-world-mill.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jquery.sparkline.min.js"></script>
	<script src="/static/app-assets/vendors/js/forms/toggle/switchery.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-checkbox.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-switch.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js"></script>
    <script src="/static/app-assets/vendors/js/pickers/pickadate/picker.js"></script>
    <script src="/static/app-assets/vendors/js/pickers/pickadate/picker.date.js"></script>
    <script src="/static/app-assets/vendors/js/pickers/pickadate/picker.time.js"></script>
    <script src="/static/app-assets/vendors/js/pickers/pickadate/legacy.js"></script>
    <script src="/static/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js"></script>
    <script src="/static/app-assets/vendors/js/pickers/daterange/daterangepicker.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/static/app-assets/js/core/app-menu.js"></script>
    <script src="/static/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- Validation -->
    <script src="/static/js/validation/jquery.validate.min.js"></script>
	<script src="/static/js/validation/additional-methods.min.js"></script>
	<script src="/static/js/validation/messages_ko.min.js"></script>

    <!-- BEGIN: Page Vendor JS-->
    <script src="/static/app-assets/vendors/js/forms/repeater/jquery.repeater.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/typeahead/typeahead.bundle.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/typeahead/bloodhound.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/typeahead/handlebars.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/formatter/formatter.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/maxlength/bootstrap-maxlength.js"></script>
    <script src="/static/app-assets/vendors/js/forms/extended/card/jquery.card.js"></script>
    <script src="/static/app-assets/vendors/js/forms/select/jquery.selectBoxIt.js"></script>
    <script src="/static/app-assets/vendors/js/forms/icheck/icheck.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/datedropper.min.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/timedropper.min.js"></script>
    <script src="/static/app-assets/vendors/js/extensions/dragula.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="/static/app-assets/js/scripts/forms/switch.js"></script>
    <script src="/static/app-assets/js/scripts/forms/checkbox-radio.js"></script>
    <script src="/static/app-assets/js/scripts/ui/jquery-ui/dialog-tooltip.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="/static/app-assets/js/scripts/tables/jquery.spring-friendly.js"></script>
    <script src="/static/app-assets/js/scripts/tables/components/table-components.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/datatables.min.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/moment.min.js"></script>
    <script src="/static/app-assets/vendors/js/pickers/dateTime/moment-timezone-with-data.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/select/1.3.1/js/dataTables.select.min.js"></script>
    <script src="/static/app-assets/vendors/js/bootstrap-select/bootstrap-select.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Page JS-->
	<script src="/static/js/moyamo-util.js"></script>
	<script src="/static/js/moyamo/common.js"></script>
    <!-- END: Page JS-->

    <script type="text/javascript">

    function init(href){
        document.location.hash = href;
	}

	function load(href) {
        if(href=='') {
            console.log('load is empty')
            return;
        }
        console.log('load', href);
        $.ajax({
            url: href,
            data:{},
            type:'GET',
            success:function(res){
                console.log('페이지 변환시 backdrop 처리');
                $('.modal-backdrop.fade.show').remove();
                $('div.app-content.content').html(res);

            },fail:function(e){
                alert('페이지를 찾을 수 없습니다.');
                init('/admin/dashBoard');
                console.log(e);
            }
        });
    }

	$(document).ready(function(){

	    if(document.location.hash === "") {
            init('admin/dashBoard');
        } else {
            load(document.location.hash.replace('#', ''));
        }

		//메뉴 열린 모양
		/*
		$('.la-user').parent().parent().addClass('open active');
		$('#user-normal').addClass('active');
		*/

        $(window).on('hashchange', function() {
            console.log('hash change : ' +document.location.hash);
            load(document.location.hash.replace('#', ''));
        });

		$('li.nav-item a').click(function(e){
			//template화 시키기
			var href = $(this).attr('href');
			if(href === "#"){
			    console.log(href + '확인 바람!!');
				return;
			}

			if(href === "/logout"){
				return;
			}

			e.preventDefault();
            //document.location.hash = href;
			//hashchange 로 변경되도록 수정
            init(href);
		});

	});

	</script>
</body>
<script src="/static/app-assets/vendors/js/extensions/toastr.min.js"></script>
<script src="/static/app-assets/js/scripts/extensions/toastr.js"></script>
<!-- END: Body-->
</html>
