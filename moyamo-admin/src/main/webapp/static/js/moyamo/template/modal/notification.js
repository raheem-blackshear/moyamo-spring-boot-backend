
$(document).ready(function(){
	/* 알림 등록 버튼 클릭, modal창 초기화 */
	$('#btn-regist-notification').click(function(){
		$('#modify_noti').hide();
		$('#remove_noti').hide();

		notificationInit(true);
	});

	/* 달력, 초기화 */
	$('#notificationDatepicker').datepicker({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',

		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],

		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		yearSuffix: '년',
	});
	$('#notificationDatepicker').datepicker().datepicker("setDate", new Date());
	$('#notificationDatepicker').datepicker().datepicker("option", "minDate", new Date());

	/* 알림 예약 버튼 클릭, field show/hide 동작 */
	$('#reserved').change(function(e){
		if($(this).is(":checked")){
			console.log("true");
			$('#reservedFieldset').show();
		} else{
			console.log("false");
			$('#reservedFieldset').hide();
		}

	});

	/* 사진 선택 버튼 클릭, 등록 된 이미지 view */
	$(this).find('input[name*=files]').change(function(e){
		var itemEl = getDisplayItem(window.URL.createObjectURL(this.files[0]), "img");
		$(this).parent().parent().find("#modify_id").val("");
		$(this).parent().parent().find(".view:eq(0)").empty().prepend(itemEl);
		//window.URL.revokeObjectURL(itemEl);
	});

});

function notificationInit(linkHide){
    if(linkHide == undefined)
        linkHide = false;

    console.log('notificationInit hide : ', linkHide)

	$('#notification_form #reserved').prop('checked', false);
	$('#reservedFieldset').hide();
	/* 알림 등록 시간, 현재 시간으로 설정 */
	var reservedHour = getDisit((new Date()).getHours());
	$('#notificationDatepicker').datepicker().datepicker("setDate", new Date());
	$('#notification_form #time').val(reservedHour);
	//var reservedMinute = getDisit((new Date()).getMinutes());
	//$('#notification_form #minute').val(reservedMinute);

	/* 제목, 내용 초기화 */
	$('#notification_form #title').val('');
	$('#notification_form #text').val('');
	$('#notification_form #link').val('');

    $('#link-form-group').val('');
	if(linkHide) {
        $('#link-form-group').hide();
        $('#link').hide();
    } else {
        $('#link-form-group').show();
        $('#link').show();
    }

	$('#notification_form #deviceGroup[value="all"]').prop('checked', true);
	$('#notification_form #expertGroup[value="all"]').prop('checked', true);

	$('#modify_id').val('');
	$('.custom-file-input').val('');
	$('.custom-file-label').html('');
	$('.view').empty();

	/* 알림 등록 버튼 비활성화 */
	$('#regist_noti').prop('disabled', true);
}
/* 달력, 시간 2disit 맞추기 */
function getDisit(target){
	return ("0" + target).slice(-2);
}

/* 알림 등록 버튼 클릭, 동작 */
function resitNotification(postingId){
	event.preventDefault();

    var form = $('#notification_form')[0];
    var data = new FormData(form);
    //var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();

    //new date(year, month....) month = 0 -> 1월, 11 -> 12월
    var split_datepicker = data.get("notificationDatepicker").split("-");
    var date = new Date(split_datepicker[0], split_datepicker[1]-1, split_datepicker[2], data.get("time"), data.get("minute"));

    if (confirm('알림을 등록 하시겠습니까?')) {
        data.append("reserved", $('#reserved').is(":checked"));
        data.append("reservedTime", $('#reserved').is(":checked") == true ? date.toUTCString() : (new Date()).toUTCString());
        data.append("postingId", postingId);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/notification/regist",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
            	console.log(data);
            	$('.zero-configuration').DataTable().ajax.reload();
            	$('#notification_modal').modal('hide');
            	alert('알림 등록이 완료되었습니다');
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}

/* 알림 테스트 버튼 클릭, 동작 */
function sendTestNotification(postingId) {
    event.preventDefault();

    var form = $('#notification_form')[0];
    var data = new FormData(form);
    //var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();

    //new date(year, month....) month = 0 -> 1월, 11 -> 12월
    var split_datepicker = data.get("notificationDatepicker").split("-");
    var date = new Date(split_datepicker[0], split_datepicker[1]-1, split_datepicker[2], data.get("time"), data.get("minute"));

    if (confirm('테스트 발송하시겠습니까?')) {
        data.append("reserved", $('#reserved').is(":checked"));
        data.append("reservedTime", $('#reserved').is(":checked") == true ? date.toUTCString() : (new Date()).toUTCString());
        data.append("postingId", postingId);

        console.log(data.get("files"));
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/notification/testSend",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
            	$('#regist_noti').prop('disabled', false);
            	$('#modify_noti').prop('disabled', false);
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}

/* 알림 수정 버튼 클릭, 동작 */
function modifyNotification(notificationId, postingId){
	console.log('notificationId : ' + notificationId)
	console.log('postingId : ' + postingId)
	event.preventDefault();

    var form = $('#notification_form')[0];
    var data = new FormData(form);
    //var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();

    //new date(year, month....) month = 0 -> 1월, 11 -> 12월
    var split_datepicker = data.get("notificationDatepicker").split("-");
    var date = new Date(split_datepicker[0], split_datepicker[1]-1, split_datepicker[2], data.get("time"), data.get("minute"));

    if (confirm('알림을 수정 하시겠습니까?')) {
        data.append("reserved", $('#reserved').is(":checked"));
        data.append("reservedTime", $('#reserved').is(":checked") == true ? date.toUTCString() : (new Date()).toUTCString());
        data.append("postingId", postingId);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/notification/modify/"+notificationId,
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
            	console.log(data);
            	$('.zero-configuration').DataTable().ajax.reload(null, false);
            	$('#notification_modal').modal('hide');
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}


/* 알림 삭제 버튼 클릭, 동작 */
function removeNotification(notificationId, postingId){
	console.log('notificationId : ' + notificationId)
	console.log('postingId : ' + postingId)
	event.preventDefault();

    var form = $('#notification_form')[0];
    var data = new FormData(form);
    //var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();

    //new date(year, month....) month = 0 -> 1월, 11 -> 12월
    var split_datepicker = data.get("notificationDatepicker").split("-");
    var date = new Date(split_datepicker[0], split_datepicker[1]-1, split_datepicker[2], data.get("time"), data.get("minute"));

    if (confirm('알림을 삭제 하시겠습니까?')) {
        data.append("reserved", $('#reserved').is(":checked"));
        data.append("reservedTime", $('#reserved').is(":checked") == true ? date.toUTCString() : (new Date()).toUTCString());
        data.append("postingId", postingId);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/notification/remove/"+notificationId,
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
            	console.log(data);
            	$('.zero-configuration').DataTable().ajax.reload(null, false);
            	$('#notification_modal').modal('hide');
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}
