<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   <!-- BEGIN: top-->
    <!-- <nav class="header-navbar navbar-expand-lg navbar navbar-with-menu navbar-without-dd-arrow fixed-top navbar-semi-dark navbar-expand"> -->
    <nav class="header-navbar navbar-expand-lg navbar navbar-with-menu navbar-without-dd-arrow fixed-top navbar-semi-dark navbar-shadow">
        <div class="navbar-wrapper">
            <div class="navbar-header">
                <ul class="nav navbar-nav flex-row">
                    <li class="nav-item mobile-menu d-lg-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ft-menu font-large-1"></i></a></li>
                    <li class="nav-item mr-auto"><a class="navbar-brand" href="/index"><img src="/static/img/moyamo-logo.png" alt="branding logo" style="height: 40px;width: 40px;border-radius: 10%;">
                            <h3 class="brand-text" style="display: inline; padding-left: 6px;vertical-align: middle;font-size: 1.51rem;font-weight: 500;font-family: 'NotoSansKR-Bold','Quicksand', Georgia, 'Times New Roman', Times, serif;">Moyamo Admin</h3>
                        </a></li>
                    <!-- <li class="nav-item d-none d-lg-block nav-toggle"><a class="nav-link modern-nav-toggle pr-0" data-toggle="collapse"><i class="toggle-icon ft-toggle-right font-medium-3 white" data-ticon="ft-toggle-right"></i></a></li> -->
                    <li class="nav-item d-lg-none"><a class="nav-link open-navbar-container" data-toggle="collapse" data-target="#navbar-mobile"><i class="la la-ellipsis-v"></i></a></li>
                </ul>
            </div>
            <div class="navbar-container content">
                <div class="collapse navbar-collapse" id="navbar-mobile">
                    <ul class="nav navbar-nav mr-auto float-left">
						<li class="nav-item mobile-menu d-none d-lg-block"><span style="font-size:1.3rem;font-color:#000000;"><i class="la la-clipboard"></i> 메뉴명</span></li>
                    </ul>
                    <ul class="nav navbar-nav float-right">
                        <li class="nav-item mobile-menu d-none d-lg-block"><a class="nav-link nav-link-expand" href="#"><i class="ficon ft-maximize"></i></a></li>
                    </ul>                    
                    <ul id="badge_Li" class="nav navbar-nav float-right">
                    <!-- <li class="dropdown dropdown-notification nav-item"><a class="nav-link nav-link-label" href="/admin/chat"><i class="ficon ft-bell"></i><span class="badge badge-pill badge-danger badge-up badge-glow"></span></a>
                        </li> -->
                        <li class="dropdown dropdown-user nav-item mobile-menu">
                        	<a class="dropdown-toggle nav-link dropdown-user-link" style="line-height: 32px;" href="#" data-toggle="dropdown">
                        	계정
                        	</a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="/logout"><i class="ft-power"></i> Logout</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
    <!-- END: top-->

