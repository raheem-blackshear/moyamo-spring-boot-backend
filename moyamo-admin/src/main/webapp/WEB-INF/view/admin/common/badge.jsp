<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="/static/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
<!-- Firebase Messaging -->
<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-messaging.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	//뱃지 url 설정
	//var url="https://testchat.bbchat.co.kr/api/v1/chats/badge";
	var url="${chatUrl}";
	var bearer = '${bearer}';
	var html = '<li class="dropdown dropdown-notification nav-item"><a class="nav-link nav-link-label" href="/admin/chat"><i class="ficon ft-bell"></i><span class="badge badge-pill badge-danger badge-up badge-glow"></span></a></li>';
 	
	if(bearer != ''){
		$('#badge_Li').prepend(html);
		(function poll(){ 
			$.ajax({
		        url: url,
		        type:'GET',
		        timeout: 9000,
		        beforeSend : function(xhr){
		        	//헤더에 토큰 설정
		            xhr.setRequestHeader("Authorization", "Bearer "+bearer);
		        },
		        success:function(data){
		           if(data.resultData.badge == 0){
		        	   $('.badge-glow').html('');
		           }else{
		        	   $('.badge-glow').html(data.resultData.badge);
		           }
		        },
		        complete: setTimeout(function() {poll()}, 10000),
		        error:function(jqXHR, textStatus, errorThrown){
		        	console.log("에러 \n" + textStatus + " : " + errorThrown);
		        }
		    });
		})();
	}
});

if("${role}" == "TRANSLATOR"){
	var firebaseConfig = {
	  apiKey: "AIzaSyBKWnjI-oKX6L7TYJIN1AaCOc4Pc6oOXV8",
	  authDomain: "bbchat-push-staging.firebaseapp.com",
	  databaseURL: "https://bbchat-push-staging.firebaseio.com",
	  projectId: "bbchat-push-staging",
	  storageBucket: "bbchat-push-staging.appspot.com",
	  messagingSenderId: "372131803773",
	  appId: "1:372131803773:web:cf08986ca1c3c981"
	};
	// Initialize Firebase
	firebase.initializeApp(firebaseConfig);
	
	const messaging = firebase.messaging();
	console.log('role: ${role}');
	navigator.serviceWorker.register('/bbchat-service-worker.js')
	.then(function (registration) {
		console.log(registration);
	    messaging.useServiceWorker(registration);
	        
	    // Request for permission
	    messaging.requestPermission()
	    .then(function() {
	      console.log('Notification permission granted.');
	      // TODO(developer): Retrieve an Instance ID token for use with FCM.
	      messaging.getToken().then(function(currentToken) {
	        if (currentToken) {
	          subscribeTopic(currentToken);
	          console.log('Token: ' + currentToken);
	          //sendTokenToServer(currentToken);
	        } else {
	          console.log('No Instance ID token available. Request permission to generate one.');
	          setTokenSentToServer(false);
	        }
	      })
	      .catch(function(err) {
	        console.log('An error occurred while retrieving token. ', err);
	        setTokenSentToServer(false);
	      });
	    })
	    .catch(function(err) {
	      console.log('Unable to get permission to notify.', err);
	    });
	});


	
	// Handle incoming messages
	messaging.onMessage(function(payload) {
	  console.log("Notification received: ", payload);
/* 	  console.log("data ", payload.data);
	  console.log("payload ", payload.data.targetId); */
	  toastr["info"](payload.notification.body, payload.notification.title, {onclick: function() {movechat(payload.data.targetId)}, positionClass: 'toast-bottom-right', containerId: 'toast-bottom-right', "showMethod": "slideDown", "hideMethod": "slideUp", "closeButton": true, timeOut: 0, extendedTimeOut: 0});
	  var audio = new Audio('/static/media/sms-alert-4-daniel_simon.mp3');
	  audio.play();
	});

	// Callback fired if Instance ID token is updated.
	messaging.onTokenRefresh(function() {
	  messaging.getToken()
	  .then(function(refreshedToken) {
	    console.log('Token refreshed.');
	    // Indicate that the new Instance ID token has not yet been sent
	    // to the app server.
	    setTokenSentToServer(false);
	    // Send Instance ID token to app server.
	    //sendTokenToServer(refreshedToken);
	  })
	  .catch(function(err) {
	    console.log('Unable to retrieve refreshed token ', err);
	  });
	});
 }
 
function subscribeTopic(token){
	var allData = { "access_token": token, "user_info_id": ${user_info_id}};
	//console.log(allData);
    $.ajax({
       url:"/api/v1/subscribe_topic",
       type:'POST',
       data: allData,
       success:function(data){
    	   setTokenSentToServer(true);
       },
       error:function(jqXHR, textStatus, errorThrown){
       	console.log("subscribe exception");
       }
    });   	
}

function isTokenSentToServer() {
  return window.localStorage.getItem('sentToServer') == 1;
}

function setTokenSentToServer(sent) {
  window.localStorage.setItem('sentToServer', sent ? 1 : 0);
}
function movechat (chatroomid) {
	//window.location.href = '/hospital/${hospitalName}/chat?chatroomid='+chatroomid;
	window.location.href = '/admin/chat?chatroomid='+chatroomid;
}


</script>