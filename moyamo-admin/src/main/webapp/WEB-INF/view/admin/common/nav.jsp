<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

 <!-- BEGIN: Main Menu-->
    <div class="main-menu menu-fixed menu-dark menu-accordion menu-shadow" data-scroll-to-active="false">
        <div class="main-menu-content">
            <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
                <li class=" nav-item"><a href="/admin/dashBoard"><i class="la la-bar-chart"></i><span class="menu-title" data-i18n="nav.dash.main">대시보드</span></a></li>
                <sec:authorize access="hasAnyAuthority('ADMIN')">
                <li class=" nav-item"><a href="#"><i class="la ft-users"></i><span class="menu-title" data-i18n="nav.templates.main">유저관리</span></a>
                	<ul class="menu-content">
                        <li id="user-admin"><a class="menu-item" href="/admin/adminUser"><i></i><span data-i18n="nav.templates.vert.main">관리자</span></a></li>
                        <li id="user-expert"><a class="menu-item" href="/admin/expertUser"><i></i><span data-i18n="nav.templates.horz.main">전문가</span></a></li>
                        <li id="user-normal"><a class="menu-item" href="/admin/normalUser"><i></i><span data-i18n="nav.templates.horz.main">일반 유저</span></a></li>
                    </ul>
                </li>
                </sec:authorize>

                <li class=" nav-item"><a href="#"><i class="la ft-grid"></i><span class="menu-title" data-i18n="nav.templates.main">컨텐츠 관리</span></a>
                	<ul class="menu-content">
                        <!-- <li id="bannerOngoing"><a class="menu-item" href="/admin/allContents"><i></i><span data-i18n="nav.templates.vert.main">전체 컨텐츠</span></a></li> -->

                        <li id="post-magazine"><a class="menu-item" href="/admin/magazine"><i></i><span data-i18n="nav.templates.horz.main">매거진</span></a></li>
<sec:authorize access="hasAnyAuthority('ADMIN')">
                        <li id="post-television"><a class="menu-item" href="/admin/television"><i></i><span data-i18n="nav.templates.horz.main">모야모TV</span></a></li>
</sec:authorize>
                        <li id="post-guide"><a class="menu-item" href="/admin/guideBook"><i></i><span data-i18n="nav.templates.horz.main">가이드북</span></a></li>
                        <li id="post-moyamo"><a class="menu-item" href="/admin/moyamo"><i></i><span data-i18n="nav.templates.horz.main">이름이 모야</span></a></li>
                        <li id="post-clinic"><a class="menu-item" href="/admin/clinic"><i></i><span data-i18n="nav.templates.horz.main">식물 클리닉</span></a></li>
                        <li id="post-bragging"><a class="menu-item" href="/admin/bragging"><i></i><span data-i18n="nav.templates.horz.main">자랑하기</span></a></li>
                        <li id="post-freeboard"><a class="menu-item" href="/admin/freeboard"><i></i><span data-i18n="nav.templates.horz.main">자유수다</span></a></li>
<sec:authorize access="hasAnyAuthority('ADMIN')">
                        <li class=" nav-item"><a href="#"><i></i><span data-i18n="nav.templates.horz.main">랭킹</span></a>
                            <ul class="menu-content">
                                <li id="post-bestGoods"><a class="menu-item" href="/admin/bestGoods"><i></i><span data-i18n="nav.templates.horz.main">인기상품</span></a></li>
                            </ul>
                        </li>
</sec:authorize>

<c:if test="${isPhotoEnable || role == 'ADMIN' }">
                        <li id="post-photo"><a class="menu-item" href="/admin/photo"><i></i><span data-i18n="nav.templates.horz.main">포토 리스트</span></a></li>
</c:if>
<c:if test="${isPhotoEnable}">
                        <li id="post-photoAlbum"><a class="menu-item" href="/admin/photoAlbum"><i></i><span data-i18n="nav.templates.horz.main">내 앨범 관리</span></a></li>
</c:if>
                        <li id="post-mention"><a class="menu-item" href="/admin/mention"><i></i><span data-i18n="nav.templates.horz.main">언급 댓글</span></a></li>
                    </ul>
                </li>

                <li class=" nav-item"><a href="#"><i class="la ft-grid"></i><span class="menu-title" data-i18n="nav.templates.main">답변이 필요한 컨텐츠</span></a>
                    <ul class="menu-content">
                        <!-- <li id="bannerOngoing"><a class="menu-item" href="/admin/allContents"><i></i><span data-i18n="nav.templates.vert.main">전체 컨텐츠</span></a></li> -->
                        <li id="post-moyamo-2"><a class="menu-item" href="/admin/moyamo-2"><i></i><span data-i18n="nav.templates.horz.main">이름이 모야</span></a></li>
                        <li id="post-clinic-2"><a class="menu-item" href="/admin/clinic-2"><i></i><span data-i18n="nav.templates.horz.main">식물 클리닉</span></a></li>
                    </ul>
                </li>

<sec:authorize access="hasAnyAuthority('ADMIN')">
                <li class=" nav-item"><a href="#"><i class="la la-warning"></i><span class="menu-title" data-i18n="nav.templates.main">신고 관리</span></a>
                    <ul class="menu-content">
                        <li class=" nav-item"><a href="/admin/reporting"><span class="menu-title" data-i18n="nav.templates.main">게시글</span></a></li>
                        <li class=" nav-item"><a href="/admin/commentReporting"><span class="menu-title" data-i18n="nav.templates.main">댓글</span></a></li>
                    </ul>
                </li>

                <li class=" nav-item"><a href="/admin/tag"><i class="la la-tag"></i><span class="menu-title" data-i18n="nav.templates.main">태그 관리</span></a></li>
                <li class=" nav-item"><a href="/admin/notification"><i class="la la-bell"></i><span class="menu-title" data-i18n="nav.templates.main">알림 관리</span></a></li>
                <li class=" nav-item"><a href="/admin/notice"><i class="la la-bullhorn"></i><span class="menu-title" data-i18n="nav.templates.main">공지사항</span></a>


                <li class=" nav-item"><a href="#"><i class="la la-gamepad"></i><span class="menu-title" data-i18n="nav.templates.main">이벤트 관리</span></a>
                    <ul class="menu-content">
                        <li class=" nav-item"><a href="/admin/event"><span class="menu-title" data-i18n="nav.templates.main">팝업 관리</span></a>
                        <li class=" nav-item"><a href="/admin/gamble"><span class="menu-title" data-i18n="nav.templates.main">게임 관리</span></a>
                    </ul>
                </li>


                <li class=" nav-item"><a href="/admin/statistics"><i class="la ft-pie-chart"></i><span class="menu-title" data-i18n="nav.templates.main">통계</span></a>
                <li class=" nav-item"><a href="/admin/providerHistory"><i class="la la-search"></i><span class="menu-title" data-i18n="nav.templates.main">가입내역 검색</span></a>
<!--                 <li class=" nav-item"><a href="/admin/agree"><i class="la ft-pie-chart"></i><span class="menu-title" data-i18n="nav.templates.main">약관동의 처리</span></a> -->


                <li id="post-badge"><li class=" nav-item"><a href="/admin/badge"><i class="la la-certificate"></i><span class="menu-title" data-i18n="nav.templates.main">뱃지</span></a></li>
                <li id="post-home"><li class=" nav-item"><a href="/admin/home"><i class="la la-sitemap"></i><span class="menu-title" data-i18n="nav.templates.main">모아보기</span></a></li>
                <li id="post-banner"><li class=" nav-item"><a href="/admin/banner"><i class="la la-list"></i><span class="menu-title" data-i18n="nav.templates.main">배너</span></a></li>
                <li id="post-banner"><li class=" nav-item"><a href="/admin/recommendKeyword"><i class="la la-yelp"></i><span class="menu-title" data-i18n="nav.templates.main">추천 검색어 관리</span></a></li>
</sec:authorize>
                </li>
            </ul>
        </div>
    </div>
    <!-- END: Main Menu-->
