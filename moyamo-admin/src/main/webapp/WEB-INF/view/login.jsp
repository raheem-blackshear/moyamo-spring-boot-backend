<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<!doctype html>
<html xmlns:th="http://www.thymeleaf.org" lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Modern admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities with bitcoin dashboard.">
    <meta name="keywords" content="admin template, modern admin template, dashboard template, flat admin template, responsive admin template, web app, crypto dashboard, bitcoin dashboard">
    <meta name="author" content="PIXINVENT">
    <title>Moyamo Admin</title>
    <link rel="apple-touch-icon" href="/static/img/moyamo-logo.png">
    <!-- <link rel="shortcut icon" type="image/x-icon" href="/static/app-assets/images/ico/favicon.ico"> -->
    <link rel="shortcut icon" type="image/x-icon" href="/static/img/moyamo-logo.png">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i%7CQuicksand:300,400,500,700" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="/static/app-assets/vendors/css/forms/icheck/custom.css">
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
    <link rel="stylesheet" type="text/css" href="/static/app-assets/css/pages/login-register.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/static/assets/css/style.css">
    <!-- END: Custom CSS-->


	<!--네이버 로그인 -->
    <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
    <!--카카오 로그인 -->
	<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<!--페이스북 로그인 -->
	<script>
/* 	  window.fbAsyncInit = function() {
	    FB.init({
	      appId      : '253433882741593',
	      cookie     : true,
	      xfbml      : true,
	      version    : 'v7.0'
	    });

	    FB.AppEvents.logPageView();

	  };

	  (function(d, s, id){
	     var js, fjs = d.getElementsByTagName(s)[0];
	     if (d.getElementById(id)) {return;}
	     js = d.createElement(s); js.id = id;
	     js.src = "https://connect.facebook.net/ko_KR/sdk.js";
	     fjs.parentNode.insertBefore(js, fjs);
	   }(document, 'script', 'facebook-jssdk')); */
	</script>
</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu-modern 1-column  bg-full-screen-image blank-page" data-open="click" data-menu="vertical-menu-modern" data-col="1-column">

    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row mb-1">
            </div>
            <div class="content-body">
                <section class="flexbox-container">
                    <div class="col-12 d-flex align-items-center justify-content-center">
                        <div class="col-lg-4 col-md-8 col-10 box-shadow-2 p-0">
                            <div class="card border-grey border-lighten-3 px-1 py-1 m-0">
                                <div class="card-header border-0" style="padding: 0;">
                                    <div class="card-title text-center">
                                        <!-- <img src="/static/app-assets/images/logo/logo-dark.png" alt="branding logo"> -->
                                        <img src="/static/img/moyamo-logo.png" alt="MOYAMO" style="height: 80px;width: 80px;border-radius: 10%;">
                                    </div>
                                    <h6 class="card-subtitle line-on-side text-muted text-center font-small-3 pt-2"><span>Social</span></h6>
                                </div>
                                <div class="card-content">
                                     <div class="text-center" style="height:50px;">
    									<a href="javascript:;" class="btn_social" data-social="kakao"><img src="/static/img/sns/kakao.png" style="height: 50px;width: 50px;border-radius: 10%;"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
    									<a href="javascript:;" class="btn_social" data-social="naver"><img src="/static/img/sns/naver.png" style="height: 50px;width: 50px;border-radius: 10%;"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
    									<a href="javascript:;" class="btn_social" data-social="facebook"><img src="/static/img/sns/facebook.png" style="height: 50px;width: 50px;border-radius: 10%;"/></a>
<!--     									<a href="#" onclick="javascript:alert('ing');return false;"><img src="/static/img/sns/facebook.png" style="height: 50px;width: 50px;border-radius: 10%;"/></a> -->
									</div>
                                    <p class="card-subtitle line-on-side text-muted text-center font-small-3 mx-2 my-1"><span>EMAIL</span></p>
                                    <div class="card-body" style="padding-top: 0.5rem;padding-right: 1.5rem;padding-bottom: 1.5rem;padding-left: 1.5rem;">
                                        <form id="loginForm" name="loginForm" class="form-horizontal" th:action="@{/login}" method="post" novalidate>
                                            <fieldset class="form-group position-relative has-icon-left">
                                                <input type="text" class="form-control" id="user-name" name="username" placeholder="전화번호 또는 이메일" required>
                                                <div class="form-control-position">
                                                    <i class="ft-user"></i>
                                                </div>
                                            </fieldset>
                                            <fieldset class="form-group position-relative has-icon-left">
                                                <input type="password" class="form-control" id="user-password" name="password" placeholder="비밀번호(전화번호 로그인은 최초 닉네임)" required>
                                                <div class="form-control-position">
                                                    <i class="la la-key"></i>
                                                </div>
                                            </fieldset>
                                            <h6 class="danger"><span id="login_message"></span></h6>
                                            <div class="form-group row">
                                                <div class="col-sm-6 col-12 text-center text-sm-right pr-0">
                                                </div>
                                                <div class="col-sm-6 col-12 float-sm-left text-center text-sm-right">
                                                    <fieldset>
                                                        <input type="checkbox" id="remember-me" class="chk-remember">
                                                        <label for="remember-me"> Remember Me</label>
                                                    </fieldset>
                                                </div>
                                            </div>
                                            <input type="hidden" name="provider" value=""/>
                                            <input type="hidden" name="provider_id" value=""/>
                                            <button type="submit" class="btn btn-outline-info btn-block"><i class="ft-unlock"></i> Login</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

            </div>
        </div>
    </div>
    <!-- END: Content-->


    <!-- BEGIN: Vendor JS-->
    <script src="/static/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/static/app-assets/js/core/app-menu.js"></script>
    <script src="/static/app-assets/js/core/app.js"></script>
    <!-- END: Theme JS-->


</body>
<!-- END: Body-->
    <script type="text/javascript">
	$(document).ready(function(){

        var err = "${error_flag}";
        <c:if test="${error_flag == '1' || error_flag == '2' || error_flag == '3'}">
        var providerId = "${providerId}";
        $('#login_message').html('존재하지 않거나 아이디 혹은 비밀번호가 일치하지 않습니다.');
        $('#user-name').val(providerId);
        </c:if>
        <c:if test="${error_flag == '4'}">
        var providerId = "${providerId}";
        $('#login_message').html('관리자 페이지 접속이 허가된 사용자가 아닙니다. 다시 확인해주세요.');
        </c:if>
	});

	</script>
<script>
    let socials = document.getElementsByClassName("btn_social");
    for(let social of socials) {
        social.addEventListener('click', function(){
            let socialType = this.getAttribute('data-social');
            location.href="/oauth2/authorization/" + socialType;
        })
    }
</script>
</html>
