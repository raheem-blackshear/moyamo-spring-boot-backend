<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="hasAnyAuthority('ADMIN')" var="isAdmin"></sec:authorize>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>


    <!-- BEGIN: Content-->
        <div class="content-wrapper">
            <div class="content-body">

<c:if test="${!isAdmin}">
    <div class="row">
        <!--  div class="col-8" -->
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title text-center"></h4>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${isAdmin}">
             <!-- Emails Products & Avg Deals -->
                <div class="row">
                    <!--  div class="col-8" -->
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title text-center">설치 및 가입자 통계</h4><div style="text-align: right;"><span>업데이트 : ${lastModifyDate}</span></div>
                            </div>
                            <div class="card-content collapse show" style="margin-bottom: 20px;">
                                <div class="card-body pt-0">
                                    <div class="row">
                                        <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center">
                                            <h6 class="danger text-bold-600"></h6>
                                            <p class="blue-grey lighten-2 mb-0">총 가입자수</p>
                                            <h4 id="totalJoinCount" class="font-large-2 text-bold-400">0</h4>
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
										                <th colspan="3" style="border-bottom: 0; border-top:0;">가입자</th>
										                <th colspan="3" style="border-bottom: 0; border-top:0;">OS별 가입자</th>
										            </tr>
                                                    <tr>
                                                        <th>신규</th>
                                                        <th>탈퇴</th>
                                                        <th>누적</th>
                                                        <th>IOS</th>
                                                        <th>Android</th>
                                                        <th>ETC</th>
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
                <div class="row">
                    <div class="col-xl-12 col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">가입 매체</h4>
                                <a class="heading-elements-toggle"><i class="la la-ellipsis-v font-medium-3"></i></a>
                                <div class="heading-elements">
                                </div>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body pt-0">
                                    <div class="row mb-1 text-center">
                                        <div class="col-2 col-md-2">
                                            <h5>전체</h5>
                                            <h2 id="joinTotalCount" style="color:#000000">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>카카오</h5>
                                            <h2 id="kakaoJoinTotalCount" style="color:#F4D03F">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>네이버</h5>
                                            <h2 id="naverJoinTotalCount" style="color:#27AE60">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>페이스북</h5>
                                            <h2 id="facebookJoinTotalCount" style="color:#2E86C1">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>이메일</h5>
                                            <h2 id="emailJoinTotalCount" style="color:#2E4053">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>애플</h5>
                                            <h2 id="appleJoinTotalCount" style="color:#E74C3C">0</h2>
                                        </div>
                                    </div>
                                    <div class="chartjs">
                                        <canvas id="join-chart" class="chartjs-render-monitor" style="height:355px; width:55vw"></canvas>
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
                                <h4 class="card-title">컨텐츠 통계</h4>
                                <a class="heading-elements-toggle"><i class="la la-ellipsis-v font-medium-3"></i></a>
                                <div class="heading-elements">
                                </div>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body pt-0">
                                    <div class="row mb-1 text-center">
                                        <div class="col-2 col-md-2">
                                            <h5>전체</h5>
                                            <h2 id="contentsTotalCount" style="color:#000000">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>이름이모야?</h5>
                                            <h2 id="questionTotalCount" style="color:#F4D03F">0</h2>
                                        </div>
                                         <div class="col-2 col-md-2">
                                            <h5>식물클리닉</h5>
                                            <h2 id="clinicTotalCount" style="color:#27AE60">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>매거진</h5>
                                            <h2 id="magazineTotalCount" style="color:#2E86C1">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>자유게시판</h5>
                                            <h2 id="freeTotalCount" style="color:#2E4053">0</h2>
                                        </div>
                                        <div class="col-2 col-md-2">
                                            <h5>자랑하기</h5>
                                            <h2 id="boastTotalCount" style="color:#E74C3C">0</h2>
                                        </div>
                                    </div>
                                    <div class="chartjs">
                                        <canvas id="contents-chart" class="chartjs-render-monitor" style="height:355px; width:55vw"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

</c:if>
        	</div>
    	</div>
    <!-- END: Content-->

    <script src="/static/js/moyamo/statistics.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            setMenuName('${menuName}');
            //메뉴 열린 모양
            //$('.la-bar-chart').parent().parent().addClass('open active');
            callStatistics('${from}', '${to}');
            $("#totalJoinCount").text(numberFormat('${totalJoinCount}'))
        });

        Number.prototype.format = function(n, x, s, c) {
            var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
                num = this.toFixed(Math.max(0, ~~n));

            return (c ? num.replace('.', c) : num).replace(new RegExp(re, 'g'), '$&' + (s || ','));
        };
	</script>
