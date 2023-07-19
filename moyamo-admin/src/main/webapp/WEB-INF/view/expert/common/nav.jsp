<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!-- BEGIN: Main Menu-->
    <div class="main-menu menu-fixed menu-dark menu-accordion menu-shadow" data-scroll-to-active="false">
        <div class="main-menu-content">
            <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
                <li class=" nav-item"><a href="/index"><i class="la la-bar-chart"></i><span class="menu-title" data-i18n="nav.dash.main">대시보드</span></a></li>
                <li class=" nav-item"><a href="#"><i class="la ft-users"></i><span class="menu-title" data-i18n="nav.templates.main">유저관리</span></a>
                	<ul class="menu-content">
                        <li id="bannerOngoing"><a class="menu-item" href="/adminUser"><i></i><span data-i18n="nav.templates.vert.main">관리자</span></a></li>
                        <li id="bannerExpired"><a class="menu-item" href="/specialUser"><i></i><span data-i18n="nav.templates.horz.main">전문가</span></a></li>
                        <li id="bannerExpired"><a class="menu-item" href="/user"><i></i><span data-i18n="nav.templates.horz.main">일반 유저</span></a></li>
                    </ul>
                </li>
                <li class=" nav-item"><a href="#"><i class="la ft-grid"></i><span class="menu-title" data-i18n="nav.templates.main">컨텐츠 관리</span></a>
                	<ul class="menu-content">
                        <li id="bannerOngoing"><a class="menu-item" href="/allContents"><i></i><span data-i18n="nav.templates.vert.main">전체 컨텐츠</span></a></li>
                        <li id="bannerExpired"><a class="menu-item" href="/magazine"><i></i><span data-i18n="nav.templates.horz.main">매거진</span></a></li>
                        <li id="bannerExpired"><a class="menu-item" href="/guideBook"><i></i><span data-i18n="nav.templates.horz.main">가이드북</span></a></li>
                        <li id="bannerExpired"><a class="menu-item" href="/moyamo"><i></i><span data-i18n="nav.templates.horz.main">이름이 모야</span></a></li>
                        <li id="bannerExpired"><a class="menu-item" href="/clinic"><i></i><span data-i18n="nav.templates.horz.main">식물 클리닉</span></a></li>
                        <li id="bannerExpired"><a class="menu-item" href="/bragging"><i></i><span data-i18n="nav.templates.horz.main">자랑하기</span></a></li>
                        <li id="bannerExpired"><a class="menu-item" href="/freeboard"><i></i><span data-i18n="nav.templates.horz.main">자유수다</span></a></li>
                    </ul>
                </li>
	            <li class=" nav-item"><a href="/reporting"><i class="la la-warning"></i><span class="menu-title" data-i18n="nav.templates.main">신고 관리</span></a></li>                
                <li class=" nav-item"><a href="/tag"><i class="la la-tag"></i><span class="menu-title" data-i18n="nav.templates.main">태그 관리</span></a></li>
                <li class=" nav-item"><a href="/alarm"><i class="la la-bell"></i><span class="menu-title" data-i18n="nav.templates.main">알림 관리</span></a></li>
                <li class=" nav-item"><a href="/notice"><i class="la la-bullhorn"></i><span class="menu-title" data-i18n="nav.templates.main">공지사항</span></a>
                <li class=" nav-item"><a href="/statistics"><i class="la ft-pie-chart"></i><span class="menu-title" data-i18n="nav.templates.main">통계</span></a>
                </li>
            </ul>
        </div>
    </div>
    <!-- END: Main Menu-->