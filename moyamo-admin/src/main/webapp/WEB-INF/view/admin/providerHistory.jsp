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
        	<input type="text" value="" id="prId">
			<button onclick="javascript:btnClick();">검색</button>

			<div id="list">
			</div>
			<div id="list2">
			</div>
        </div>
    <!-- END: Content-->


    <script type="text/javascript">
    var prevCommentId = 0;
    function btnClick(){
    	getList();
    	getUserInfoList();
    }
    function getList(){
		console.log('getList');

		var sendData = {
			providerId: $('#prId').val()
		};

		$.ajax({
			crossOrigin : true,
			type : "POST",
			data : sendData,
			url : "/rest/providerHistory/getList",
			success : function(data) {
				if(data.recordsTotal == 0){
					$('#list2').html('-가입수단을 변경한 내역이 없습니다.<br>');
				}
				for(var i = 0; i<data.recordsTotal; i++){
					console.log(data.data)
					$('#list2').html('-회원 정보 : 가입수단을 변경한 회원입니다.<br>');
					$('#list2').append('닉네임 : ' + data.data[i].nickname + '<br>');
					$('#list2').append('가입수단 : ' + data.data[i].provider + '<br>');
					$('#list2').append('현재 아이디 : ' + data.data[i].providerId);
				}

			}, error: function (e) {
				$('#list2').html('검색 결과가 없습니다.');
			}
		});
	}

    function getUserInfoList(){
		console.log('getUserInfoList');

		var sendData = {
			providerId: $('#prId').val()
		};

		$.ajax({
			crossOrigin : true,
			type : "POST",
			data : sendData,
			url : "/rest/providerHistory/getUserInfoList",
			success : function(data) {
				if(data.recordsTotal == 0){
					$('#list').html('');
				}
				for(var i = 0; i<data.recordsTotal; i++){
					console.log(data.data)
					$('#list').html('-회원 정보- <br>');

					$('#list').append('닉네임 : ' + data.data[i].nickname + '<br>');
                    $('#list').append($('<button>재색인</button>').attr('data-id', data.data[i].id));
                    $('#list').append('<br>');
					$('#list').append('가입수단 : ' + data.data[i].provider + '<br>');
				}

			}, error: function (e) {
				$('#list').html('검색 결과가 없습니다.');
			}
		});
	}

	$(document).ready(function(){

		/* 상단 타이틀 변경 */
		setMenuName('${menuName}');

		$('[data-toggle="tooltip"]').tooltip({
		    html: true
		});

        $('#list').on('click', 'button', function(e) {
            e.preventDefault();

            $.ajax({method:'POST'
                , url:'/rest/user/indexing?ids=' + $(this).attr('data-id')
                , success : function(data) {
                    alert('색인되었습니다.');
                }, error : function(request,status,error) {
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            })  ;
        });


		/* var table = $('.zero-configuration').DataTable({
			dom:
				"<'row'<'col-sm-0 text-left'l><'col-sm-4 text-left'f><'col-sm'><'col-sm-2'B>>" +
			    "<'row'<'col-sm-12'tr>>" +
			    "<'row'<'col-sm-4'i><'col-sm-8'p>>",
	        buttons: [
	            {
	            	text: '공지 등록',
	            	className: 'btn btn-custom-info First',
	                action: function ( e, dt, node, config ) {
	                	initInput();
	                	$('#regist_modal').modal("show");

	                }
	            },
	        ],
		    language: { search: '', searchPlaceholder: "검색" , lengthMenu: "_MENU_"},
			'ajax' : {
				"url":'/rest/providerHistory/getList',
				"data":{
					"providerId":"01025532587"
				}

			},
			'serverSide' : true,
			"processing" : true,
			//"order": [[ 0, "desc" ]],
			"drawCallback": function (oSettings, json) {
	            $('[data-toggle="tooltip"]').tooltip();
	        },
            "createdRow": function( row, data, dataIndex){
            	$('td', row).eq(1).addClass('boldcolumn');
            },
	        columns: [
	        	{ data: "id", searchable: true, orderable: false},
	        	{ data: "providerId",
	        		render: function(data, type, row, meta){
	        			console.log(row);
	        			return data;
	       			},
	       			orderable: false
        		}
	        ]
		}); */

		//검색창 3글자 이내는 검색안되게 딜레이 600ms
		/* var searchWait = 0;
	    var searchWaitInterval;
	    $('.dataTables_filter input')
	    .unbind() // leave empty here
	    .bind('input', function(e){ //leave input
	        var item = $(this);
	        searchWait = 0;
	        if(this.value.length >= 2 || e.keyCode == 13) {
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
	    }); */

		 //** Row 클릭 **//
	    $('.zero-configuration tbody').on('click', 'td', function () {

	    	if('boldcolumn' == $(this)[0].className.trim()){
	    		$('#detail_modal').modal('show');
	        	var dataSet = table.row( $(this).parent() ).data();
	        	detailView(dataSet);
	    	}
	    });

	});


	</script>

