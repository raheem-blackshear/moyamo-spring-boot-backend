<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/forms/switch.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/core/colors/palette-switch.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/extensions/toastr.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/plugins/extensions/toastr.css">        
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/static/assets/css/style.css">
    <!-- END: Custom CSS-->
</head>
<body class="vertical-layout vertical-menu-modern 2-columns   fixed-navbar" data-open="click" data-menu="vertical-menu-modern" data-col="2-columns">

	<!-- Top -->
    <%@ include file="/WEB-INF/view/admin/common/top.jsp"%>
    <!-- Top -->
    
	<!-- MainMenu -->
    <%@ include file="/WEB-INF/view/admin/common/nav.jsp"%>
    <!-- MainMenu -->

    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-body">
            
             <!-- Emails Products & Avg Deals -->
                <div class="row">
                    <!--  div class="col-8" -->
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title text-center">설치 및 가입자 통계</h4>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body pt-0">
                                    <div class="row">
                                        <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center">
                                            <h6 class="danger text-bold-600"></h6>
                                            <p class="blue-grey lighten-2 mb-0">총 가입자수</p>
                                            <h4 id="totalRegist" class="font-large-2 text-bold-400">0</h4>
                                        </div>
                                        <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center">
                                            <p class="blue-grey lighten-2 mb-0">총 탈퇴자수</p>
                                            <h4 id="totalQuit" class="font-large-2 text-bold-400">0</h4>
                                        </div>
                                        <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center">
                                            <p class="blue-grey lighten-2 mb-0">총 설치수</p>
                                            <h4 id="totalInstall" class="font-large-2 text-bold-400">0</h4>
                                        </div>
                                        <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center">
                                            <p class="blue-grey lighten-2 mb-0">총 삭제수</p>
                                            <h4 id="totalRemove" class="font-large-2 text-bold-400">0</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-content collpase show">
                                    <div class="card-body card-dashboard dataTables_wrapper dt-bootstrap">
                                        <div>
                                            <table class="table table-striped table-bordered zero-configuration" style="text-align:center;vertical-align:middle;width:100%;">
                                                <thead>
                                                	<tr>
										                <th colspan="1" rowspan="2" style="border-top:0;vertical-align:middle;">날짜</th>
										                <th colspan="2" style="border-bottom: 0; border-top:0;">가입자</th>
										                <th colspan="2" style="border-bottom: 0; border-top:0;">iOS</th>
										                <th colspan="2" style="border-bottom: 0; border-top:0;">안드로이드</th>
										                <th colspan="1" rowspan="2" style="border-top:0;vertical-align:middle;">상담신청건수</th>
										                <th colspan="2" style="border-bottom: 0; border-top:0;">메시지수</th>
										            </tr>
                                                    <tr>
                                                        <th>신규</th>
                                                        <th>탈퇴</th>
                                                        <th>설치</th>
                                                        <th>삭제</th>
                                                        <th>설치</th>
                                                        <th>삭제</th>
                                                        <th>유 저</th>
                                                        <th>상담사</th>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>
                                    </div>
<!--                                     <div class="chartjs">
                                        <canvas id="column-chart2" class="chartjs-render-monitor" style="height:355px; width:55vw"></canvas>
                                    </div>    -->
                                    
                                </div>                               
                            </div>
                        </div>
                    </div>

<!--                     <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title text-center">상담 총 건수</h4>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body pt-0">
                                    <div class="row">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> -->
                    
                    <!--  div class="col-4">
                        <div class="card" style="height: 85%;">
                            <div class="card-header">
                                <h4 class="card-title text-center">잔여금액</h4>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body pt-0">
                                    <div class="row">
                                        <div class="col-md-12 col-12 text-center">
                                            <h4 class="font-large-2 text-bold-400" id="money" name="money">0</h4>
                                            <c:if test="${role != 'COUNSELOR'}">
                                            	<button id="chargeBtn" type="button" class="btn btn-secondary btn-sm">충전하기</button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div -->
				</div>
                <!-- Revenue, Hit Rate & Deals -->
					                <div class="row">
					                    <div class="col-xl-12 col-12">
					                        <div class="card">
					                            <div class="card-header">
					                                <h4 class="card-title">가입 / 탈퇴 / 상담 통계</h4>
					                                <a class="heading-elements-toggle"><i class="la la-ellipsis-v font-medium-3"></i></a>
					                                <div class="heading-elements">
					                                </div>
					                            </div>
					                            <div class="card-content collapse show">
					                                <div class="card-body pt-0">
					                                    <div class="row mb-1 text-center">
					                                        <div class="col-4 col-md-4">
					                                            <h5>가입</h5>
					                                            <h2 id="regist_label" style="color:#9ac6f2">0</h2>
					                                        </div>
					                                        <div class="col-4 col-md-4">
					                                            <h5>탈퇴</h5>
					                                            <h2 id="quit_label" style="color:#e18894">0</h2>
					                                        </div>
					                                         <div class="col-4 col-md-4">
					                                            <h5>상담신청</h5>
					                                            <h2 id="consult_label" style="color:#b2dd83">0</h2>
					                                        </div>
					                                    </div>
					                                    <div class="chartjs">
					                                        <canvas id="column-chart2" class="chartjs-render-monitor" style="height:355px; width:55vw"></canvas>
					                                    </div>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					              	</div>                  
                <div class="row">
                    <div class="col-xl-12 col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">상담 유입 경로</h4>
                                <a class="heading-elements-toggle"><i class="la la-ellipsis-v font-medium-3"></i></a>
                                <div class="heading-elements">
                                </div>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body pt-0">
                                    <div class="row mb-1 text-center">
                                        <div class="col-4 col-md-4">
                                            <h5>프로필</h5>
                                            <h2 id="profilePath" style="color:#9ac6f2">0</h2>
                                        </div>
                                        <div class="col-4 col-md-4">
                                            <h5>후기</h5>
                                            <h2 id="reviewPath" style="color:#e18894">0</h2>
                                        </div>
                                         <div class="col-4 col-md-4">
                                            <h5>이벤트</h5>
                                            <h2 id="eventPath" style="color:#b2dd83">0</h2>
                                        </div>
                                    </div>
                                    <div class="chartjs">
                                        <canvas id="column-chart" class="chartjs-render-monitor" style="height:355px; width:55vw"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
              	</div>
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
    <script src="/static/app-assets/vendors/js/tables/datatable/datatables.min.js"></script>
    <script src="/static/app-assets/js/core/libraries/jquery_ui/jquery-ui.min.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/dataTables.buttons.min.js"></script>
    
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="/static/app-assets/vendors/js/charts/chart.min.js"></script>
    <script src="/static/app-assets/vendors/js/charts/raphael-min.js"></script>
    <script src="/static/app-assets/vendors/js/charts/morris.min.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jvector/jquery-jvectormap-2.0.3.min.js"></script>
    <script src="/static/app-assets/vendors/js/charts/jvector/jquery-jvectormap-world-mill.js"></script>
    <script src="/static/app-assets/data/jvector/visitor-data.js"></script>
	<script src="/static/app-assets/vendors/js/forms/toggle/switchery.min.js"></script>   
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-checkbox.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/toggle/bootstrap-switch.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/static/app-assets/js/core/app-menu.js"></script>
    <script src="/static/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="/static/app-assets/js/scripts/forms/switch.js"></script>
    <script src="/static/app-assets/vendors/js/tables/datatable/moment.min.js"></script>
    <!-- END: Page JS-->
    
    
    <script type="text/javascript">
	$(document).ready(function(){
		$('li.nav-item a').click(function(e){
			//template화 시키기
			e.preventDefault();
			var href = $(this).attr('href');
			console.log()
			$.ajax({
		        url: '/admin/index',
		        data:{'date':date, 'isMonth':true},
		        type:'GET',
		        success:function(res){
		        	console.log(res)
		        	$('div.app-content.content').html(res);
		        }
			});
			
		});
		
		
		
		//메뉴 열린 모양
		//$('.la-bar-chart').parent().parent().addClass('open active');
		

		//date 오늘날짜
		var date = new Date().toISOString().split("T")[0];
		
		//차트들
		var lineChart;
		var lineChart2;
		var lineChartNew;
		var lineChartNew2;

		
		var table = $('.zero-configuration').DataTable({
    		searching: false, 
    		paging: false, 
    		info: false,
    		"scrollY": "295px",
            "scrollCollapse": true,
    		columns: [
                { data: "date" },
                { data: "registNew" },
                { data: "registQuit" },
                { data: "iosInstall" },
                { data: "iosRemove" },
                { data: "androidInstall" },
                { data: "androidRemove" },
                { data: "consultCount" },
                { data: "msgUser" },
                { data: "msgConsultant" }
            ]
    	});		
		
		
		//30일 클릭 이벤트
		$('#recentlyDay30TotalCnt').on('click',function(){
			 //기존 차트 삭제
		    if(lineChart){
		    	lineChart.options.responsive = false;
		    	lineChart.destroy();
		    } 
		    if(lineChart2){
		    	lineChart2.options.responsive = false;
		    	lineChart2.destroy();
		    } 
		    if(lineChartNew){
		    	lineChartNew.options.responsive = false;
		    	lineChartNew.destroy();
		    } 
		    if(lineChartNew2){
		    	lineChartNew2.options.responsive = false;
		    	lineChartNew2.destroy();
		    } 
		    
			$(this).addClass('danger');
			$('#recentlyDay7TotalCnt').removeClass('danger');
			$.ajax({
		        url: '/api/v1/admin_dashboard',
		        data:{'date':date, 'isMonth':true},
		        type:'GET',
		        success:function(returnValue){
		        	//잔여금액 셋팅
		        	//$('#money').html(returnValue.data.money.format(0, 3, ','));
		        	$('#totalRegist').html(returnValue.data.totalRegist);
		        	$('#totalQuit').html(returnValue.data.totalQuit);
		        	$('#totalInstall').html(returnValue.data.totalInstall);
		        	$('#totalRemove').html(returnValue.data.totalRemove);
		        	
		        	//상담 총 건수 최근 7일, 최근 30일 계산
		        	var list = returnValue.data.list;
		        	//날짜
		        	var labels30 = [];
		        	
		        	//이벤트 건수
		        	var eventPath30 = [];
		        	//프로필 건수
		        	var profilePath30 = [];
		        	//후기 건수
		        	var reviewPath30 = [];
		        	//총 건수
		        	var totalEventPath30= 0;
		        	var totalProfilePath30 = 0;
		        	var totalReviewPath30 = 0;
		        	//7일 총 건수
		        	var total7DayCnt = 0;
		        	
		        	for(var i=0; i<list.length; i++){
		        		labels30.push(moment(list[i].date).format('YYYY-MM-DD'));
		        		eventPath30.push(list[i].eventPath);
		        		profilePath30.push(list[i].profilePath);
		        		reviewPath30.push(list[i].reviewPath);
		        		
		        		totalEventPath30 += list[i].eventPath;
		        		totalProfilePath30 += list[i].profilePath;
		        		totalReviewPath30 += list[i].reviewPath;
		        	}
		        	
		        	var labels2 = [];
		        	var regist = [];
		        	var quit = [];
		        	var counsel = [];	
		        	var install = returnValue.data.install;
		        	var total30Consult = 0;
					var total30Regist = 0;		        	
					var total30Quit = 0;		        	
		        	for (var i=0;i<install.length;i++) {
		        		labels2.push(install[i].date);
		        		regist.push(install[i].registNew);
		        		quit.push(install[i].registQuit);
		        		counsel.push(install[i].consultCount);
		        		
		        		total30Consult += install[i].consultCount;
		        		total30Regist += install[i].registNew;
		        		total30Quit += install[i].registQuit;
		        	}
		        	$('#regist_label').html(total30Regist);
		        	$('#quit_label').html(total30Quit);		        	
		        	$('#consult_label').html(total30Consult);		        	
		        	
		        	//테이블 그리기
		        	table.clear().draw();
		        	table.rows.add(install); // Add new data
		        	table.columns.adjust().draw(); // Redraw the DataTable
		        	//console.log(total7DayCnt);
		        	//토탈 최근 30일 계산
		        	$('#recentlyDay30TotalCnt').html(totalEventPath30 + totalProfilePath30 + totalReviewPath30);
		        	//$('#recentlyDay7TotalCnt').html(total7DayCnt);
		        	//상담 유입경로
		        	$('#eventPath').html(totalEventPath30);
		        	$('#profilePath').html(totalProfilePath30);
		        	$('#reviewPath').html(totalReviewPath30);
		        	
		        	
		        	//Get the context of the Chart canvas element we want to select
		    	    var ctx = $("#column-chart");
		    	    var ctx2 = $("#column-chart2");
		    	    // Chart Options
		    	    var chartOptions = {
		    	        // Elements options apply to all of the options unless overridden in a dataset
		    	        // In this case, we are setting the border of each bar to be 2px wide and green
		    	        elements: {
		    	            rectangle: {
		    	                borderWidth: 2,
		    	                borderColor: 'rgb(0, 255, 0)',
		    	                borderSkipped: 'bottom'
		    	            }
		    	        },
		    	        tooltips: {
			    	        mode: 'index',
			    	        intersect: false
		    	        },
		    	        hover: {
			    	        mode: 'index',
			    	        intersect: false
		    	        },		    	        
		    	        responsive: true,
		    	        maintainAspectRatio: false,
		    	        responsiveAnimationDuration:500,
		    	        scales: {
		    	            xAxes: [{
		    	                stacked: true,
		    	                ticks: {
		    	                    display: true,
		    	                  },		    	                
		    	            }],		    	        	
		    	            yAxes: [{
		    	               ticks: {
		    	            	  min:0,
		    	            	  precision: 0,
		    	                  userCallback: function(label, index, labels) {
		    	                      if (Math.floor(label) === label) {
		    	                          return label;
		    	                      }

		    	                  }		    	            	  
		    	               },
		                        scaleLabel:{
		                            display: true,
		                            fontColor: "#546372"
		                        }		    	               
		    	            }]
		    	         }
		    	    };
		        	
		        	// Chart Data
		    	    var chartData = {
		    	        labels: labels30,
		    	        datasets: [{
		    	            label: "프로필",
		    	            data: profilePath30,
		    	            backgroundColor: "rgba(55, 141, 230,.5)",
		    	            hoverBackgroundColor: "rgba(55, 141, 230,.9)",
		    	            borderColor: "transparent",
		    	            pointRadius: 2  //<- set this
		    	        }, {
		    	            label: "후기",
		    	            data: reviewPath30,
		    	            backgroundColor: "rgba(195, 19, 43,.5)",
		    	            hoverBackgroundColor: "rgba(195, 19, 43,.9)",	
		    	            borderColor: "transparent",
		    	            pointRadius: 2  //<- set this
		    	        }, {
		    	            label: "이벤트",
		    	            data: eventPath30,
		    	            backgroundColor: "rgba(102, 187, 9,.5)",
		    	            hoverBackgroundColor: "rgba(102, 187, 9,.9)",
		    	            borderColor: "transparent",
		    	            pointRadius: 2  //<- set this
		    	        }]
		    	    };
		        	
		    	    var chartData2 = {
			    	        labels: labels2,
			    	        datasets: [{
			    	            label: "가입",
			    	            data: regist,
			    	            backgroundColor: "rgba(55, 141, 230,.5)",
			    	            hoverBackgroundColor: "rgba(55, 141, 230,.9)",
			    	            borderColor: "transparent",
			    	            pointRadius: 2  //<- set this
			    	        }, {
			    	            label: "탈퇴",
			    	            data: quit,
			    	            backgroundColor: "rgba(195, 19, 43,.5)",
			    	            hoverBackgroundColor: "rgba(195, 19, 43,.9)",			    	            
			    	            borderColor: "transparent",
			    	            pointRadius: 2  //<- set this
			    	        }, {
			    	            label: "상담신청건수",
			    	            data: counsel,
			    	            backgroundColor: "rgba(102, 187, 9,.5)",
			    	            hoverBackgroundColor: "rgba(102, 187, 9,.9)",
			    	            borderColor: "transparent",
			    	            pointRadius: 2  //<- set this
			    	        }]
			    	    };
		        	
		    	    var config = {
		    		        type: 'line',
		    		        // Chart Options
		    		        options : chartOptions,
		    		        fillOpacity: .3,
		    		        data : chartData
		    		    };
		    	    
		    	    var config2 = {
		    		        type: 'line',
		    		        // Chart Options
		    		        options : chartOptions,
		    		        fillOpacity: .3,
		    		        data : chartData2
		    		    };

	    		    // Create the chart
	    		    lineChart = new Chart(ctx, config);
	    		    lineChartNew = new Chart(ctx2, config2);
	    		    
	    		    if(lineChart2){
	    		    	lineChart2.options.responsive = false;
	    		    	lineChart2.destroy();
	    		    } 
	    		    if(lineChartNew2){
	    		    	lineChartNew2.options.responsive = false;
	    		    	lineChartNew2.destroy();
	    		    } 
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		        	console.log("에러 \n" + textStatus + " : " + errorThrown);
		        }
		    });
		});
		
		//7일 이벤트
		$('#recentlyDay7TotalCnt').on('click',function(){
			 //기존 차트 삭제
		    if(lineChart){
		    	lineChart.options.responsive = false;
		    	lineChart.destroy();
		    } 
		    if(lineChart2){
		    	lineChart2.options.responsive = false;
		    	lineChart2.destroy();
		    } 
		    if(lineChartNew){
		    	lineChartNew.options.responsive = false;
		    	lineChartNew.destroy();
		    } 
		    if(lineChartNew2){
		    	lineChartNew2.options.responsive = false;
		    	lineChartNew2.destroy();
		    } 

			$(this).addClass('danger');
			$('#recentlyDay30TotalCnt').removeClass('danger');
			$.ajax({
		        url: '/api/v1/admin_dashboard',
		        data:{'date':date, 'isMonth':false},
		        type:'GET',
		        success:function(returnValue){
		        	//잔여금액 셋팅
		        	//$('#money').html(returnValue.data.money.format(0, 3, ','));
		        	$('#totalRegist').html(returnValue.data.totalRegist);
		        	$('#totalQuit').html(returnValue.data.totalQuit);
		        	$('#totalInstall').html(returnValue.data.totalInstall);
		        	$('#totalRemove').html(returnValue.data.totalRemove);
		        	//상담 총 건수 최근 7일, 최근 30일 계산
		        	var list = returnValue.data.list;
		        	var install = returnValue.data.install;
		        	//날짜
		        	var labels = [];
		        	//이벤트 건수
		        	var eventPath7 = [];
		        	//프로필 건수
		        	var profilePath7 = [];
		        	//후기 건수
		        	var reviewPath7 = [];
		        	//총 건수
		        	var totalEventPath7 = 0;
		        	var totalProfilePath7 = 0;
		        	var totalReviewPath7 = 0;
		        	
		        	for(var i=0; i<list.length; i++){
		        		labels.push(moment(list[i].date).format('YYYY-MM-DD'));
		        		eventPath7.push(list[i].eventPath);
		        		profilePath7.push(list[i].profilePath);
		        		reviewPath7.push(list[i].reviewPath);
		        		
		        		totalEventPath7 += list[i].eventPath;
		        		totalProfilePath7 += list[i].profilePath;
		        		totalReviewPath7 += list[i].reviewPath;
		        	}
		        	var labels2 = [];
		        	var regist = [];
		        	var quit = [];
		        	var counsel = [];	
		        	var install = returnValue.data.install;
		        	var total7Consult = 0;
		        	var total7Regist = 0;
		        	var total7Quit = 0;
		        	for (var i=0;i<install.length;i++) {
		        		labels2.push(install[i].date);
		        		regist.push(install[i].registNew);
		        		quit.push(install[i].registQuit);
		        		counsel.push(install[i].consultCount);
		        		
		        		total7Consult += install[i].consultCount;
		        		total7Regist += install[i].registNew;
		        		total7Quit += install[i].registQuit;		        		
		        	}
		        	$('#regist_label').html(total7Regist);
		        	$('#quit_label').html(total7Quit);		        	
		        	$('#consult_label').html(total7Consult);
		        	
		        	//테이블 그리기
		        	table.clear().draw();
		        	table.rows.add(install); // Add new data
		        	table.columns.adjust().draw(); // Redraw the DataTable
		        	
		        	//토탈 최근 7일 계산
		        	$('#recentlyDay7TotalCnt').html(totalEventPath7 + totalProfilePath7 + totalReviewPath7);
		        	//상담 유입경로
		        	$('#eventPath').html(totalEventPath7);
		        	$('#profilePath').html(totalProfilePath7);
		        	$('#reviewPath').html(totalReviewPath7);
		        	
		        	//Get the context of the Chart canvas element we want to select
		    	    var ctx = $("#column-chart");
		    	    var ctx2 = $("#column-chart2");
		    	    // Chart Options
		    	    var chartOptions = {
		    	        // Elements options apply to all of the options unless overridden in a dataset
		    	        // In this case, we are setting the border of each bar to be 2px wide and green
		    	        elements: {
		    	            rectangle: {
		    	                borderWidth: 2,
		    	                borderColor: 'rgb(0, 255, 0)',
		    	                borderSkipped: 'bottom'
		    	            }
		    	        },
		    	        tooltips: {
			    	        mode: 'index',
			    	        intersect: false
		    	        },
		    	        hover: {
			    	        mode: 'index',
			    	        intersect: false
		    	        },	    	        
		    	        responsive: true,
		    	        maintainAspectRatio: false,
		    	        responsiveAnimationDuration:500,
		    	        scales: {
		    	            xAxes: [{
		    	                stacked: true,
		    	                ticks: {
		    	                    display: true,
		    	                  },		    	                
		    	            }],			    	        	
		    	            yAxes: [{
		    	               ticks: {
		    	            	  min:0,
		    	            	  precision: 0,
		    	                  userCallback: function(label, index, labels) {
		    	                      if (Math.floor(label) === label) {
		    	                          return label;
		    	                      }

		    	                  }
		    	               },
		                        scaleLabel:{
		                            display: true,
		                            fontColor: "#546372"
		                        }	
		    	            }]
		    	         }
		    	    };
		        	
		        	// Chart Data
		    	    var chartData = {
		    	        labels: labels,
		    	        datasets: [{
		    	            label: "프로필",
		    	            data: profilePath7,
		    	            backgroundColor: "rgba(55, 141, 230,.5)",
		    	            hoverBackgroundColor: "rgba(55, 141, 230,.9)",
		    	            borderColor: "transparent",
		    	            pointRadius: 2  //<- set this
		    	        }, {
		    	            label: "후기",
		    	            data: reviewPath7,
		    	            backgroundColor: "rgba(195, 19, 43,.5)",
		    	            hoverBackgroundColor: "rgba(195, 19, 43,.9)",
		    	            borderColor: "transparent",
		    	            pointRadius: 2  //<- set this
		    	        }, {
		    	            label: "이벤트",
		    	            data: eventPath7,
		    	            backgroundColor: "rgba(102, 187, 9,.5)",
		    	            hoverBackgroundColor: "rgba(102, 187, 9,.9)",
		    	            borderColor: "transparent",
		    	            pointRadius: 2  //<- set this
		    	        }]
		    	    };
		        	
		    	    var chartData2 = {
			    	        labels: labels2,
			    	        datasets: [{
			    	            label: "가입",
			    	            data: regist,
			    	            backgroundColor: "rgba(55, 141, 230,.5)",
			    	            hoverBackgroundColor: "rgba(55, 141, 230,.9)",
			    	            borderColor: "transparent",
			    	            pointRadius: 2  //<- set this
			    	        }, {
			    	            label: "탈퇴",
			    	            data: quit,
			    	            backgroundColor: "rgba(195, 19, 43,.5)",
			    	            hoverBackgroundColor: "rgba(195, 19, 43,.9)",
			    	            borderColor: "transparent",
			    	            pointRadius: 2  //<- set this
			    	        }, {
			    	            label: "상담신청건수",
			    	            data: counsel,
			    	            backgroundColor: "rgba(102, 187, 9,.5)",
			    	            hoverBackgroundColor: "rgba(102, 187, 9,.9)",
			    	            borderColor: "transparent",
			    	            pointRadius: 2  //<- set this
			    	        }]
			    	    };		        	
		    	    var config = {
		    		        type: 'line',
		    		        // Chart Options
		    		        options : chartOptions,
		    		        fillOpacity: .3,
		    		        data : chartData
		    		    };
		    	    var config2 = {
		    		        type: 'line',
		    		        // Chart Options
		    		        options : chartOptions,
		    		        fillOpacity: .3,
		    		        data : chartData2
		    		    };
	    		    // Create the chart
	    		    
	    		    lineChart2 = new Chart(ctx, config);
	    		    lineChartNew2 = new Chart(ctx2, config2);
	    		    
	    		    if(lineChart){
	    		    	lineChart.options.responsive = false;
	    		    	lineChart.destroy();
	    		    } 
	    		    if(lineChartNew){
	    		    	lineChartNew.options.responsive = false;
	    		    	lineChartNew.destroy();
	    		    } 
	    		    
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		        	console.log("에러 \n" + textStatus + " : " + errorThrown);
		        }
		    });
		});
		
		$('#recentlyDay7TotalCnt').click();
		setTimeout(function() {
			//최초 30일로 보여주기
			$('#recentlyDay30TotalCnt').click();
		}, 200); 
	});
	
	Number.prototype.format = function(n, x, s, c) {
	    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
	        num = this.toFixed(Math.max(0, ~~n));

	    return (c ? num.replace('.', c) : num).replace(new RegExp(re, 'g'), '$&' + (s || ','));
	};
	</script>
</body>
<script src="/static/app-assets/vendors/js/extensions/toastr.min.js"></script>
<script src="/static/app-assets/js/scripts/extensions/toastr.js"></script>
<!-- END: Body-->
</html>
