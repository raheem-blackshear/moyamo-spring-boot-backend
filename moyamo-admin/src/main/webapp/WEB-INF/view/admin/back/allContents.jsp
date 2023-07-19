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
    .arrow-red{
   	    color: red;
   	    font-weight: 600;
    }
	div.dataTables_wrapper div.dataTables_filter {
	    text-align: left;
	}
	.commentTime{
	    font-size: 11px;
    	color: #bbbbbb;
	}
	.pickbg{
		background-color: #fff0f0 !important;
	}
    .boldcolumn{
    	font-size: 15px;
   	    font-weight: 1000;
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
                    <h3 class="content-header-title mb-0 d-inline-block">후기 관리</h3>
                </div>
            </div> -->
            <!-- Modal -->
                <div class="modal fade text-left" id="review_detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-danger">
                                <h3 class="modal-title white" id="myModalLabel35" style="font-size: 1.1rem;"></h3>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true" style="color:white;">&times;</span>
                                </button>
                            </div>
								<form name="review_detail_modal_form" action="/admin/review_modify" method="post">
								<input type="hidden" name="id">
	                           	<div class="modal-body">
			                    	<div class="card-body" style="padding: unset;">
			                    		<div class="row p-2">
	                                        <div class="col-sm-6">
	                                            <div class="row">
	                                                <div class="col-lg-4 col-3">
	                                                	<span class="avatar avatar-online">
	                                                    	<img name="userInfoProfileImgPath" alt="avatar">
	                                                    </span>
	                                                </div>
	                                                <div class="col-lg-8 col-7 p-0">
	                                                    <h5 name="userInfoName" class="m-0"></h5>
	                                                    <p name="createdAt"></p>
	                                                </div>
	                                            </div>
	                                        </div>
	                                        <div class="col-sm-6">
	                                            <i class="ft-more-horizontal pull-right"></i>
	                                        </div>
	                                    </div>
	                                    <div class="write-post">
	                                        <div name="content" class="col-sm-12 px-2 pb-2"></div>
                                        	<hr class="m-0">
	                                        <div class="row p-1" style="margin-bottom: 0px;">
	                                            <div class="col-6">
	                                                <div class="row" style="margin-bottom: 0px;">
	                                                    <div class="col-lg-6 col-6 pr-0">
	                                                        <span name="likeCnt"></span>
	                                                        <span style="margin-left: 15px;" name="commentCnt"></span>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
                                    	</div>
		                        	</div>
		                        	<span id ="commentArea" name="commentArea"></span>
	                            </div>
                            	<c:if test="${role == 'MASTER'}">
	                            	<div class="modal-footer">
		                            	<div class="row" style="margin: 0px;">
		                            		<div style="display: flex;" class="col-lg-6 mb-1" id="bbpickInputText">
		                            			<lable style="width:45px;line-height: 35px;">점수</lable>
			                            		<input type="text" class="form-control" name="bbpickOrder" placeholder="0-10">
			                            	</div>
			                            	<div class="col-lg-6 mb-1" style="text-align: right;">
			                            			<button style="margin-right: 5px;" type="submit" class="btn btn-primary" id="modify">
                                       					<i class="la la-check-square-o"></i> BBPick</button>
				                            		<button type="button" class="btn btn-danger" id="delete_btn">
                                       					<i class="ft-x"></i> 삭제</button>
			                            	</div>
		                            	</div>
	                            	</div>
                            	</c:if>
                            </form>
                        </div>
                    </div>
                </div>
                
            <div class="content-body">
                <!-- 후기 관리 -->
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
                                                        <th>PickOrder</th>
                                                        <th>등록일</th>
                                                        <th>병원명</th>
                                                        <th>작성자</th>
                                                        <th>대표이미지</th>
                                                        <th>수술날짜</th>
                                                        <th>수술부위</th>
                                                        <th>원장</th>
                                                        <th>상담건수</th>
                                                        <th>평점</th>
                                                        <th>댓글</th>
                                                        <th>좋아요</th>
                                                        <th>신고건수</th>
                                                        <th>차단여부</th>
                                                        <th>대표후기</th>
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
    <script src="/static/app-assets/vendors/js/forms/icheck/icheck.min.js"></script>
    <script src="/static/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
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
    
    <!-- badge -->
    <%@ include file="/WEB-INF/view/admin/common/badge.jsp"%>
    <!-- badge -->
    
    <script type="text/javascript">
	$(document).ready(function(){
		//메뉴 열린 모양
		$('.la-file-text').parent().parent().addClass('open active');
		//리뷰 data
// 		var ReviewInfo = ${ReviewInfo};
// 		console.log(ReviewInfo);
		
		$('[data-toggle="tooltip"]').tooltip({
		    html: true
		});

		var table = $('.zero-configuration').DataTable({
			dom:
			    "<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'>>" +
			    "<'row'<'col-sm-12'tr>>" +
			    "<'row'<'col-sm-4'i><'col-sm-8'p>>",
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},			
			'ajax' : '/admin/data/reviews',
			'serverSide' : true,
			"processing" : true,
			"order": [[ 0, "desc" ], [ 1, "desc" ]],
			"drawCallback": function (oSettings, json) {
	            $('[data-toggle="tooltip"]').tooltip();
	        },
            "createdRow": function( row, data, dataIndex){
            	//console.log(data['bbpickOrder']);
                if( data['bbpickOrder'] != 0){
            		$(row).removeClass('odd');
            		$(row).removeClass('even');
            		$(row).addClass('pickbg');
                }
                $('td', row).eq(6).addClass('boldcolumn');
                $('td', row).eq(8).addClass('boldcolumn');
                $('td', row).eq(9).addClass('boldcolumn');
            },		
			columns: [
	            { data: "bbpickOrder" , render: function (data, type, row, meta) {
	            	if(data == 0 ) return "선택 안됨";
	            	return "Score : "+data;
//	            	return "<div style='color:blue;'>Score : "+data+"</div>";
				  },
	            searchable: false
	            },
                { data: "createdAt" , 
                	render: function(data, type, row, meta){
                		return moment(data).format('YYYY-MM-DD HH:mm:ss')
                	},
                searchable: false
                },
                { data: "clinicInfo" , //clinicInfo.displayName
                	render: function(data, type, row, meta){
                		return row.clinicName;
                	}, 
                searchable: false , orderable: false
                },
                { data: "userInfo.name", orderable: false},
                { data: "reviewResource", render: function (data, type, row, meta) {
	            	var result = ''; 
					var setting = '?d=50x50';
	        		var style = 'width: 50px;height: 50px;';
	        		var itemEl = getS3Data(data[0].imgUrl, setting, style);
	        		result = itemEl; 
					return result;
				  }, searchable: false , orderable: false
	            },
	            { data: "surgeryDate", searchable: false
            	},
	            { data: "category", render: function (data, type, row, meta) {
	            	var result = ''; 
	            	for(var i=0; i<data.length - 1; i++){
	            		result += data[i].name + ', '; 
	            	}
	            	result+=data[data.length -1].name;
					return result;
				  }, searchable: false, orderable: false
	            },
	            { data: "doctorInfo", //doctorInfo.name
	            	render: function (data, type, row, meta){
	            		return row.doctorName;
	            	},
	            	searchable: false, orderable: false
	            },
	            { data: "consultationCnt", searchable: false}, //상담건수
	            { data: "evaluationScore", searchable: false},
	            { data: "commentCnt", searchable: false},
	            
	            { data: "likeCnt", searchable: false},
	            //신고건수
	            { data: "declarationCnt", searchable: false},
	            { data: "isBlock",//차단여부
	            	render: function (data, type, row, meta){
	            		if(data){
	            			var tooltip = '';
	            			if(row.declarationInfo){
	            				var userInfoName = row.declarationInfo[0].userInfoName;
// 	            				if(userInfoName.indexOf("탈퇴된 사용자")){
// 	            					userInfoName = "탈퇴된 사용자";
// 	            				}
	            				tooltip = '신고자 : '+ userInfoName +'<br>'
    							+'처리일자 : '+ moment(row.declarationInfo[0].resultDateTime).format('YYYY-MM-DD HH:mm:ss') +'<br>'
    							+'신고유형 : '+ row.declarationInfo[0].declarationResource.description +'<br>'
    							+'상세신고사유 : '+ row.declarationInfo[0].description +'<br>';
	            			}
							return '<span class="badge badge-danger" style="cursor: unset;width: 48px;" data-html=true data-toggle="tooltip" title="'+ tooltip +'">차 단</span>';           			
	            		}else if(row.isBlind){
	            			return '<span class="badge badge-danger" style="cursor: unset;width: 48px;" data-html=true data-toggle="tooltip" title="탈퇴한 사용자">탈 퇴</span>';
	            		}else{
	            			return '-';
	            		}
	            		
	            	}, searchable: false},
	            { data: "doctorPick", render : function(data, type, row, meta){
            			var html = "";
            			if(data){
            				html = '<span class="badge badge-success" style="cursor: unset;width: 48px;">노출</span>';
            			}else{
            				html = '-';
            			}
            			
            			return html;
            		}
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
			
		 //** 리뷰 Row 클릭 **//
        $('.zero-configuration tbody').on('click', 'tr', function () {
            var data = table.row( this ).data();
            //console.log( data);

            $('#review_detail_modal').find('input[name=id]').val(data.id);
          	//기본이미지 삽입
			var httpName = '${httpName}';
            var profileImage = data.userInfo.profileImg;
			if(profileImage == "" || profileImage == null){
				profileImage = '/static/img/noimg.png';
    		}else{
    			profileImage = httpName + data.userInfo.profileImg;
    		}
			
            $('#review_detail_modal').find('h3[id=myModalLabel35]').html("<b> 상세 보기 (후기ID : " +data.id+ ")</b>");
            $('#review_detail_modal').find('img[name=userInfoProfileImgPath]').attr("src", profileImage);
            $('#review_detail_modal').find('h5[name=userInfoName]').html(data.userInfo.name);
            $('#review_detail_modal').find('p[name=createdAt]').html(moment(data.createdAt).format('YYYY-MM-DD HH:mm:ss'));
            var content = makeContent(data);
            $('#review_detail_modal').find('div[name=content]').html(content);
            
            $('#review_detail_modal').find('span[name=likeCnt]').html('<i class="ft-heart h4 align-middle danger"></i> ' + data.likeCnt);
            $('#review_detail_modal').find('span[name=commentCnt]').html('<i class="ft-message-square h4 align-middle danger"></i> ' + data.commentCnt);
            $('#review_detail_modal').find('span[name=commentArea]').html(getCommentHtmlByData(data.commentInfo));
            
            //차단된 후기 처리
            if(data.isBlind || data.isBlock){
            	$('#modify').attr('style','display:none;');
            	$('#bbpickInputText').attr('style','display:none;');
            	$('#delete_btn').attr('style', 'width: 76px;');
            }else{
            	$('#modify').attr('style','display: inline-block;');
            	$('#bbpickInputText').attr('style','display: flex;');
            }
            
            $('#review_detail_modal').modal('show');
        });
		 
		//validation 처리
        $('form[name=review_detail_modal_form]').validate({
            //validation이 끝난 이후의 submit 직전 추가 작업할 부분
            submitHandler: function(form) {
                var f = confirm("BBpick을 수정하겠습니까?");
                if(f){
                	/* $.ajax({
                        type: "UPDATE",
                        url: "/admin/",
                        data: $(form).serialize(),
                        timeout: 3000,
                        success: function() {alert('works');},
                        error: function() {alert('failed');}
                      }); 
                      return false;
                  	}*/
                	return true;
                } else {
                    return false;
                }
            },
            //규칙
            rules: {
            	bbpickOrder: {
                    required : true,
                    min : 0,
                    max : 10,
                    digits: true
                }
            },
            //규칙체크 실패시 출력될 메시지
            messages : {
            	bbpickOrder: {
                	required : "필수값",
                	digits : "숫자",
                	min : "0-10",
                	max : "0-10"
                }
            },
            errorPlacement: function(label, element) {
//                 label.addClass('arrow-red');
//                 label.insertAfter(element);
            },
        });
		
		//후기 삭제 기능
		$('form[name=review_detail_modal_form]').find('#delete_btn').on('click', function(){
             if(confirm("BBpick을 삭제하겠습니까?")){
            	var allData = { "review_id": $('form[name=review_detail_modal_form]').find('input[name=id]').val(), };
             	$.ajax({
                     url: "/api/web/v1/review_delete",
                     type: "POST",
                     data: allData,
                     timeout: 3000,
                     success: function(data) {
                    	if(data.resultCode == 1000){
                    		alert("삭제 완료!");
         	        		window.location.reload();
         	        	}else{
         	        		alert('권한 없음!');
         	        	}
                     },
                     error: function(jqXHR, textStatus, errorThrown) {
                    	alert("에러 \n" + textStatus + " : " + errorThrown);
                   	 }
                }); 
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
	
	</script>
    
</body>
<script src="/static/app-assets/vendors/js/extensions/toastr.min.js"></script>
<script src="/static/app-assets/js/scripts/extensions/toastr.js"></script>
<!-- END: Body-->
</html>
