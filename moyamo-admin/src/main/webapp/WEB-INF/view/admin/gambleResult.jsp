<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.lang.String" %>
<%@page import="java.util.*" %>
<%@page import="java.time.ZoneId" %>
<%@taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!doctype html>
<html lang="ko">
<head>

    <!-- BEGIN: Head-->
    <head>
        <title>Moyamo Admin</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="이 식물 이름이 모야모!">
        <meta name="keywords" content="식물, 꽃, 나무">

        <link rel="apple-touch-icon" href="/static/img/moyamo-logo.png">
        <!--     <link rel="shortcut icon" type="image/x-icon" href="/static/app-assets/images/ico/favicon.ico"> -->
        <link rel="shortcut icon" type="image/x-icon" href="/static/img/moyamo-logo.png">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i%7CQuicksand:300,400,500,700" rel="stylesheet">


        <!-- BEGIN: Theme CSS-->
        <link rel="stylesheet" type="text/css" href="/static/app-assets/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="/static/app-assets/css/bootstrap-extended.css">
        <script type="application/javascript">

            function download(gambleId, itemId, version, godo) {
                console.log('download', gambleId);
                const url = new URL(location.protocol + "//" + location.host + "/rest/gamble/" + gambleId + "/excel");
                if(itemId)
                    url.searchParams.append("itemId", itemId);

                if(version)
                    url.searchParams.append("version", version);

                url.searchParams.append("godo", godo);

                window.location.assign(url.href);
            }

        </script>
    </head>
    <!-- END: Head-->
    <body>
        <div class="container">
            <div class="content-main">
                <br>
                <div class="row">
                    <div class="col">
                        <h1>${gamble.title} 결과</h1>
                    </div>
                </div>

                <br><br>
                <form name="gamble_result_search_form" id="gamble_result_search_form" action="/admin/gamble/result" method="get" enctype="multipart/form-data">
                    <div class="row" style="display:none;">
                        <input type="text" name="gambleId" value="${gamble.id}">
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="version">참여일</label>
                            <select class="form-control" id="version" name="version">
                                <option value="0" <c:if test="${version.equals(0)}">selected</c:if>>전체</option>
                                <c:forEach var="rv" items="${versionList}">
                                    <option value="${rv.version}" <c:if test="${version.equals(rv.version)}">selected</c:if>>${rv.date.withZoneSameInstant(zoneId).format(datePattern)}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col">
                            <label for="itemId">아이템</label>
                            <select class="form-control" id="itemId" name="itemId">
                                <c:forEach var="item" items="${gamble.items}">
                                    <option value="${item.id}" <c:if test="${itemId == item.id}">selected</c:if>>${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col">
                            <div class="float-right">
                                <input style="margin-top:25px" type="submit" class="btn btn-primary" value="조회">
                            </div>
                        </div>
                    </div>
                </form>
                <br><br>

                <div class="row">
                    <div class="col">
                        <div class="float-left">
                            <b>총참여수</b> : ${betCount}회 <br>
                            <b>상품 당첨자수</b> : ${resultList.size()}명
                        </div>
                        <div class="float-right">
                            <button class="btn btn-success" onclick="download('${gamble.id}', '${itemId}', '${version}', false)">다운로드</button>
                            <button class="btn btn-success" onclick="download('${gamble.id}', '${itemId}', '${version}', true)">고도몰용 다운로드</button>
                        </div>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col">

                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">당첨</th>
                                <th scope="col">시간</th>
                                <th scope="col">쇼핑몰ID</th>
                                <th scope="col">닉네임</th>
                                <th scope="col">수령자</th>
                                <th scope="col">주소</th>
                                <th scope="col">우편번호</th>
                                <th scope="col">전화번호1</th>
                                <th scope="col">전화번호2</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="result" items="${resultList}">
                                    <tr>
                                        <th scope="row">${result.id}</th>
                                        <td>${result.item.name}</td>
                                        <td>${result.createdAt.withZoneSameInstant(zoneId).format(dateTimePattern)}</td>
                                        <td>${result.user.shopUserId}</td>
                                        <td>${result.user.nickname}</td>
                                        <c:choose>
                                            <c:when test="${result.item.address && result.address != null}">
                                                <td>${result.address.name}</td>
                                                <td>${result.address.roadAddress} ${result.address.detailAddress}</td>
                                                <td>${result.address.postCode}</td>
                                                <td>${result.address.phone1}</td>
                                                <td>${result.address.phone2}</td>
                                            </c:when>
                                            <c:otherwise>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                </c:forEach>
                                <c:if test="${resultList.size() == 0}">
                                    <tr><td colspan="10">결과가 존재하지 않습니다.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
