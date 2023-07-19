<%@ page import="net.infobank.moyamo.enumeration.PostingType" %>
<%@ page import="net.infobank.moyamo.models.Posting" %>
<%@ page import="net.infobank.moyamo.models.board.ClinicCondition" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020/08/20
  Time: 4:55 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    String strPostingType = request.getParameter("postingType");
    String strUserId = request.getParameter("user");

    //신고페이지에서는 readonly 로 사용
    String strReadOnly = request.getParameter("readOnly");
    boolean readOnly = strReadOnly != null;
    String menuName = request.getParameter("menuName");
    PostingType postingType = null;
    System.out.println("readonly : " + readOnly);
    if(!readOnly) {
        postingType = PostingType.valueOf(strPostingType);
        System.out.println("detail modal board : " + postingType);
    } else {
        System.out.println("detail modal board readOnly");
    }


    StringBuilder builder = new StringBuilder();
    String separator = "";
    String dq = "\"";
    String colon = ":";
    builder.append("{");

    for(int i = 0 ; ClinicCondition.ClinicConditionPlace.values().length > i ; i++ ) {
        ClinicCondition.ClinicConditionPlace place = ClinicCondition.ClinicConditionPlace.values()[i];

        builder.append(separator).append(dq).append(place.name()).append(dq)
                .append(colon)
                .append(dq).append(place.getName()).append(dq);

        separator = ",";

    }

    for(int i = 0 ; ClinicCondition.ClinicConditionLight.values().length > i ; i++ ) {
        ClinicCondition.ClinicConditionLight light = ClinicCondition.ClinicConditionLight.values()[i];

        builder.append(separator).append(dq).append(light.name()).append(dq)
                .append(colon)
                .append(dq).append(light.getName()).append(dq);

        separator = ",";

    }

    for(int i = 0 ; ClinicCondition.ClinicConditionWater.values().length > i ; i++ ) {
        ClinicCondition.ClinicConditionWater water = ClinicCondition.ClinicConditionWater.values()[i];

        builder.append(separator).append(dq).append(water.name()).append(dq)
                .append(colon)
                .append(dq).append(water.getName()).append(dq);

        separator = ",";

    }

    for(int i = 0 ; ClinicCondition.ClinicDetailRepotting.values().length > i ; i++ ) {
        ClinicCondition.ClinicDetailRepotting repotting = ClinicCondition.ClinicDetailRepotting.values()[i];

        builder.append(separator).append(dq).append(repotting.name()).append(dq)
                .append(colon)
                .append(dq).append(repotting.getName()).append(dq);

        separator = ",";
    }

    builder.append("}");

    String conditions = builder.toString();
    pageContext.setAttribute("conditions", conditions);

%>
<sec:authorize access="hasAnyAuthority('ADMIN')" var="isAdmin"></sec:authorize>
<style>
    .mentiony-content {
        width:300px;
    }

    #detail_attach_view > .media > .media-body > .position.active {
        text-align: right;
        right: 10px;
        top: 10px;
        padding: 5px 5px 5px;
        color: white;
        background: url('/static/img/position_active.png');
        background-repeat: no-repeat;
        background-position: right 5px;
        position: absolute;
        background-color: rgba(0,0,0,0.6);
        border-radius: 8px;
    }

    #detail_attach_view > .media > .media-body > .position.inactive {
        text-align: right;
        right: 10px;
        top: 10px;
        padding: 5px 5px 5px;
        color: white;
        background: url('/static/img/position_inactive_white.png');
        background-repeat: no-repeat;
        background-position: right 5px;
        position: absolute;
        background-color: rgba(0,0,0,0.6);
        border-radius: 8px;
    }

    #detail_attach_view > .media > .media-body > .position > .place {
        margin-right: 15px;
    }

</style>

<div class="modal fade text-left" id="posting_detail_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="posting_detail_modal_dialog" style="">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b id="detail_title"> 게시물 상세</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(false);">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>
            <form name="posting_detail_form" id="posting_detail_form" action="/admin/modifyPosting" method="post" enctype="multipart/form-data">
                <input type="hidden" name="postingId" value="">
                <input type="hidden" name="blind" value="">
                <input type="hidden" name="postingType" value="">
                <div class="modal-body" style="padding: 0;">
                    <div class="card-body" style="padding-top: 1.0rem;padding-right: 1.0rem;padding-bottom: 0.5rem;padding-left: 1.0rem;">
                        <% if(postingType == PostingType.guidebook || postingType == PostingType.television) { %>
                        <!-- 포스터 이미지 -->
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col" style="text-align: right;"><b><font color="red">포스터 이미지</font></b></div>
                        </div>
                        <div class="row" style="margin-bottom: 0px;">
                            <div class="col" id="detail_poster"></div>
                        </div>


                        <% } %>
                        <!-- 개인정보 영역 -->
                        <div class="media">
                            <a class="media-left" href="javascript:;">
                                <img class="media-object" src="" id="detail_user_photo" src="" onerror="this.src='/static/img/noimg.png';" style="width: 64px;height: 64px;border-radius: 10%;">
                            </a>
                            <div class="media-body" style="margin-left: 10px;">
                                <h5 class="media-heading" id="detail_user_nick"></h5>
                                작성일 : <span class="text-muted" id="detail_createdAt"></span></br>
                                수정일 : <span class="text-muted" id="detail_modifiedAt"></span>
                            </div>
                            <div class="media-right" style="margin-left: 10px;">
                                <% if(!readOnly) { %>
                                <c:if test="${contentsEditAllowed}">

                                <div class="btn-group">
                                    <button class="btn btn-blind btn-sm" type="button" id="btn-blind-posting">
                                        <span>숨김</span>
                                    </button>
                                </div>
                                <% if(postingType == PostingType.magazine || postingType == PostingType.free || postingType == PostingType.boast) { %>
                                <div class="btn-group">
                                    <button class="btn btn-blind btn-sm" type="button" id="btn-copy-posting" >
                                        <span>복사</span>
                                    </button>
                                </div>
                                <% } %>
                                <div style="height:5px;"></div>
                                <div class="btn-group">
                                    <button class="btn btn-blind btn-sm" type="button" id="btn-regist-notification" data-toggle="modal" data-target="#notification_modal">
                                        <span>알림 등록</span>
                                    </button>
                                </div>
                                <div style="height:5px;"></div>
                                <div class="btn-group">
                                    <button class="btn btn-blind btn-sm" type="button" id="btn-delete-posting" >
                                        <span>삭제</span>
                                    </button>
                                </div>
                                </c:if>
                                <% } %>
                            </div>

                        </div>

                        <hr size="100%"/>

                        <!-- embed 유튜브 -->
                        <div id="detail_youtube_view"></div>

                        <!-- 컨텐츠 영역 본문 -->
                        <div class="row" style="margin-bottom: 20px;">
                            <b><div class="col" id="detail_text"></div></b>
                        </div>

                        <!-- 컨텐츠 영역 본문 -->
                        <br>
                        <div class="row" style="margin-bottom: 20px;">
                            <b><div class="col" id="detail_condition" style="font-weight: 100;"></div></b>
                        </div>

                        <!-- 컨텐츠 영역 파일/설명 -->
                        <div id="detail_attach_view"></div>

                        <!-- 상품 노출 -->
                        <div id="detail_goods_view"></div>

                    </div>

                    <!-- 좋아요/댓글수 -->
                    <!-- <div class="media-right" style="margin-left: 10px;margin-top:0px;margin-bottom:20px;"> -->
                    <div class="media-right text-right"  style="margin-right: 20px;margin-top:0px;margin-bottom:20px;font-style: italic;color: coral;">
                        좋아요 : <span id="detail_likecnt"></span>,&nbsp; 스크랩 : <span id="detail_scrapcnt"></span>,&nbsp; 조회 : <span id="detail_viewcnt"></span>,&nbsp; 댓글 : <span id="detail_commentcnt"></span>
                    </div>
                </div>

                <!--  선택된 댓글 노출 -->
                <div id="mainCommentArea"></div>

                <!--  댓글 리스트 노출 -->
                <div id="commentArea"></div>

                <% if(!readOnly) { %>
                <!--  댓글 작성 영역 -->
                <div id="comment" class="input-group" style="border-top: 1px solid #626E82;">
                    <div class="col-10" style="">
                        <fieldset class="form-group"
                                  style="margin-top: 15px; margin-bottom: 10px;">
                            <textarea rows="2" class="form-control autosize" id="commentText" name="commentText" placeholder="댓글 입력"></textarea>

                        </fieldset>
                        <fieldset class="form-group">
                            <div class="fonticon-container">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="commentFile" name="commentFile"> <label class="custom-file-label" for="commentFile" aria-describedby="댓글 첨부"></label>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div id="commentsButton" class="col-2" style="margin-top: 15px; margin-bottom: 10px;">
                        <button id="commentsButton" class="btn btn-success" type="button" onclick="javascript:saveComment();">
                            <i class="la la-save"></i>
                        </button>
                    </div>
                </div>
                <!--  모달 푸터 -->

                <div class="modal-footer" style="background: lightgray;">
                    <button id="detail_to_modify" class="btn btn-success" type="button" style="display: block;">
                        <i class="la la-save"></i> 컨텐츠 수정
                    </button>
                </div>

                <% } %>
            </form>
        </div>
    </div>
</div>


<script>

    function getComments(postingId, id, action){
        var param = {
        };
        if(action == 'newest') {
            if(currentPage == 1)
                return;

            //param['sinceId'] = id;
            param = paramHistory[currentPage - 1];
        } else if(action == 'oldest') {
            param['maxId'] = id;
            //paramHistory[currentPage + 1] = param;
        } else {
            //paramHistory[currentPage] = param;
        }

        console.log('getComments param : ', param, paramHistory);

        $.ajax({
            url:"/rest/"+postingId+"/getComments",
            type:'POST',
            data: param,
            success:function(data){
                makeComments(data.data, postingId, action, param);
                bindMentiony();
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러 \n" + textStatus + " : " + errorThrown);
            }
        });

        <% if(postingType == PostingType.question) { %>
        /* 첫번째 댓글 표시 */
        $.ajax({
            url:"/rest/postings/"+postingId+"/comments/first",
            type:'POST',
            data: param,
            success:function(data){
                var list = (data.resultData) ? [data.resultData] : [];
                makeMainComment(list, postingId, false, 'question');
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러 \n" + textStatus + " : " + errorThrown);
            }
        });
        <% } %>

        <% if(postingType == PostingType.clinic) { %>
        /* 첫번째 댓글 표시 */
        $.ajax({
            url:"/rest/postings/"+postingId+"/comments/adopt",
            type:'POST',
            data: param,
            success:function(data){
                var list = (data.resultData) ? [data.resultData] : [];
                makeMainComment(list, postingId, false, 'clinic');
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("에러 \n" + textStatus + " : " + errorThrown);
            }
        });
        <% } %>

    }

    var firstId = 0;
    var lastId = 0;
    var currentPage = 1;
    var paramHistory = {};

    function initPage() {
        firstId = 0;
        lastId = 0;
        currentPage = 1;
        paramHistory = {};
    }


    $("#posting_detail_modal, #posting_add_modal, #posting_modify_modal").on("hidden.bs.modal", function (a, b, c) {
        // put your default event here
        changeScroll(false, a.currentTarget);
    });


    function makeMainComment(data, postingId, useChildren, clazz) {
        if(data == undefined) {
            alert('로그아웃되었습니다. 다시 로그인해주세요.');
            location.href = '/';
        }

        console.log('makeMainComment', postingId, data);



        var commentCnt = data.length;
        //$('#posting_detail_modal form[name=posting_detail_form] textarea[name=commentText]').val('');
        console.log('style change');

        $('#posting_detail_modal form[name=posting_detail_form] .mentiony-content').css('min-height', '40px');
        $('#posting_detail_modal form[name=posting_detail_form] .mentiony-content').text('');
        $('#posting_detail_modal form[name=posting_detail_form] input[name=commentFile]').val('');
        var mentionTemplate = '<span class="mention-area"><span class="highlight"><a href="javascript:;" data-item-id="[MENTIONID]" class="mentiony-link">@[NAME]</a></span></span>'
        if (commentCnt > 0) {

            var commentHtml = "<hr size='100%' style='margin-top: 0rem;margin-bottom: 0rem;'/>";

            var mainCommentStyle = "style='background-color: rgba(0, 0, 0, 0.1);'";

            if(clazz === 'question') {
                mainCommentStyle = "style='background-image: url(\"/static/img/first_icon.png\");background-position: 420px 15px, 10px 10px;background-repeat: no-repeat;background-color: rgba(0, 0, 0, 0.1);'"
            } else if(clazz === 'clinic') {
                mainCommentStyle = "style='background-image: url(\"/static/img/adopt_icon.png\");background-position: 20px 5px, 10px 10px;background-repeat: no-repeat;background-color: rgba(0, 0, 0, 0.1);'"
            }

            commentHtml += "<div class='card-body' "+ mainCommentStyle +">";
            for (var i=0;i<data.length;i++) {
                if (i == 0) {
                    firstId = data[i].id;
                }
                lastId = data[i].id;
                commentHtml += "<div class='media' style='margin-top:10px;'>";
                commentHtml += "<a class='media-left' href='javascript:;'>";
                commentHtml += "	<img src='"+getImage(data[i].owner.photoUrl, 'noimg.png')+"' style='width: 40px;height: 40px;border-radius: 10%;'>";
                commentHtml += "</a>";
                commentHtml += "<div class='media-body' style='margin-left: 10px;'>";
                commentHtml += "<h5 class='media-heading'>"+data[i].owner.nickname+"</h5>";
                dd = data[i];
                console.log('data : ', data[i]);
                var blindBtnText = (data[i].isBlind == true) ? '숨김해제' : '숨김';
                if (data[i].isDelete) {
                    commentHtml += "<span style='color:red;''>(삭제)</span> <span style='text-decoration: line-through;'>" + xssFilter(data[i].orgText) + "</span>";
                    commentHtml += "</br>";
                    commentHtml += timeBefore(data[i].createdAt);
                } else if (data[i].isBlind) {
                    commentHtml += "<span style='color:red;''>(차단)</span> <span style='text-decoration: line-through;'>" + xssFilter(data[i].orgText) + "</span>";
                    commentHtml += "</br>";
                    commentHtml += timeBefore(data[i].createdAt);
                    commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:blindComment(" +postingId+ "," +data[i].id + ", "+ (data[i].isBlind != true)  +");return false;'>"+blindBtnText+"</a></br>";
                } else {

                    var content = data[i].plainText;
                    for(var j = 0; j < data[i].mentions.length ; j++) {
                        var mention = data[i].mentions[j];
                        if(content) {
                            content = content.replaceAll('@[' + mention.id + ']', mentionTemplate.replace('[MENTIONID]', mention.id).replace('[NAME]', mention.nickname));
                        }
                        else {
                            content = "";
                        }
                    }
                    commentHtml += '<div style="width: 400px;word-break: break-all;">' + content + "</div>";
                    //commentHtml += data[i].text;
                    commentHtml += "</br>";
                    commentHtml += timeBefore(data[i].createdAt);

                    console.log('comment', data[i].id, data[i].isBlind, blindBtnText);
                    commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:makereply(" +postingId+ "," +data[i].id + ");return false;'>답글달기</a>";
                    commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:blindComment(" +postingId+ "," +data[i].id + ", "+ (data[i].isBlind != true)  +");return false;'>"+blindBtnText+"</a></br>";
                }

                commentHtml += "<div style='height:5px;''></div>";
                for (var j=0;j<data[i].attachments.length;j++) {	// 댓글이미지
                    var imgUrl = getImage(data[i].attachments[j].photoUrl, 'upload.png');
                    commentHtml += "<img src='"+imgUrl+"' style='width: 80%;'></br>";
                }

                commentHtml += "<div id='comment-"+lastId+"' class='input-group' style='display:none;'>";
                commentHtml += "	<div class='col-10' style=''>";
                commentHtml += "	    <fieldset class='form-group' style='margin-top: 15px;margin-bottom: 10px;'>";
//				commentHtml += "			<textarea rows='2' class='form-control' id='commentText-"+lastId+"' name='commentText-"+lastId+"' placeholder='댓글 입력'></textarea>	";
                commentHtml += "			<textarea rows='2' class='form-control autosize' id='commentText' name='commentText' placeholder='답글 입력'></textarea>	";
                commentHtml += "	    </fieldset>";
                commentHtml += "	    <fieldset class='form-group'>";
                commentHtml += "		<div class='fonticon-container'>";
                commentHtml += "		    <div class='custom-file'>";
//				commentHtml += "			<input type='file' class='custom-file-input' id='replyFile-"+lastId+"' name='commentFile-"+lastId+"'>			";
                commentHtml += "			<input type='file' class='custom-file-input' id='replyFile' name='replyFile'>			";
                commentHtml += "			<label class='custom-file-label' for='replyFile' aria-describedby='댓글 첨부'></label>				";
                commentHtml += "		    </div>  ";
                commentHtml += "		</div> ";
                commentHtml += "	    </fieldset>	";
                commentHtml += "	</div>	";
                commentHtml += "	<div id='comment-7886730' class='col-2' style='margin-top: 15px;margin-bottom: 10px;'>";
                commentHtml += "	    <button class='btn btn-success' type='button' onclick='javascript:createReply(" +postingId+ ", " + lastId + ")'><i class='la la-save'></i></button>					";
                commentHtml += "	</div>";
                commentHtml += "</div>";

                // 대댓글 영역
                var children = data[i].children;
                if (children.length > 0 && useChildren) {
                    for (var j=0;j<children.length;j++) {
                        commentHtml += "	<div class='media mt-1'>";
                        commentHtml += "    	<a class='media-left' href='javascript:;'>";
                        commentHtml += "        	<img src='"+getImage(children[j].owner.photoUrl, 'noimg.png')+"' style='width: 40px;height: 40px;border-radius: 10%;'>";
                        commentHtml += "        </a>";
                        commentHtml += "    	<div class='media-body'  style='margin-left: 10px;'>";
                        commentHtml += "        	<h5 class='media-heading'>"+children[j].owner.nickname+"</h5>";

                        var childBlindBtnText = (children[j].isBlind == true) ? '숨김해제' : '숨김';
                        if (children[j].isDelete) {
                            commentHtml += "<span style='color:red;''>(삭제)</span> <span style='text-decoration: line-through;'>" + xssFilter(children[j].orgText) + "</span>";
                            commentHtml += "</br>";
                            commentHtml += timeBefore(children[j].createdAt);
                        } else if (children[j].isBlind) {
                            commentHtml += "<span style='color:red;''>(차단)</span> <span style='text-decoration: line-through;'>" + xssFilter(children[j].orgText) + "</span>";
                            commentHtml += "</br>";
                            commentHtml += timeBefore(children[j].createdAt);
                            commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:blindComment(" +postingId+ "," +children[j].id + "," + (children[j].isBlind != true) +");return false;'>"+childBlindBtnText+"</a></br>";
                        } else {

                            var content = children[j].plainText;
                            for(var k = 0; k < children[j].mentions.length ; k++) {
                                var mention = children[j].mentions[k];
                                if(content) {
                                    content = content.replaceAll('@['+mention.id+']',  mentionTemplate.replace('[MENTIONID]',  mention.id).replace('[NAME]', mention.nickname));
                                } else {
                                    content = "";
                                }
                            }
                            commentHtml += '<div style="width: 340px;word-break: break-all;">' + content + "</div>";

                            //commentHtml += children[j].text;
                            commentHtml += "</br>";
                            commentHtml += timeBefore(children[j].createdAt);
                            commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:blindComment(" +postingId+ "," +children[j].id + "," + (children[j].isBlind != true) +");return false;'>"+childBlindBtnText+"</a></br>";
                        }

                        commentHtml += "<div style='height:5px;''></div>";
                        var childrenAttach = children[j].attachments;
                        if((typeof childrenAttach != "undefined") && (childrenAttach.length>0)){
                            for (var k=0;k<childrenAttach.length;k++) {	 // 대댓글이미지
                                commentHtml += "<img src='"+getImage(childrenAttach[k].photoUrl, 'upload.png')+"' style='width: 80%;'></br>";
                            }
                        }
                        commentHtml += "			</div>";
                        commentHtml += "    </div>";
                    }
                }
                commentHtml += "</div>";
                commentHtml += "</div>	";
                commentHtml += "</div>	";
            }

            // var pagingHtml = makePaging(postingId, commentCnt);
            // commentHtml += pagingHtml;


            //console.log(data[0].text);
            //console.log(commentHtml);
            prevCommentId = firstId;

            $('#mainCommentArea').html(commentHtml);
        } else {
            $('#mainCommentArea').children('.card-body').remove()
        }

    }



    /**
     * action : 'newest', 'oldest'
     */
    function makeComments(data, postingId, action, param) {

        if(data == undefined) {
            alert('로그아웃되었습니다. 다시 로그인해주세요.');
            location.href = '/';
        }

        var commentCnt = data.length;
        if(action == undefined) {
            currentPage = 1;
        }

        if(action == 'newest') {
            currentPage--;
        } else if(action == 'oldest') {
            currentPage++;
        }

        if(currentPage > 1) {
            if(commentCnt == 0) {
                alert('더이상 불러올 댓글이 존재하지 않습니다.');
                currentPage -= 1;
                return;
            }
        }

        paramHistory[currentPage] = param;
        console.log('currentPage : ', currentPage, action);
        var commentHtml = "<hr size='100%' style='margin-top: 0rem;margin-bottom: 0rem;'/>";
        commentHtml += "<div class='card-body'>";


        //$('#posting_detail_modal form[name=posting_detail_form] textarea[name=commentText]').val('');
        console.log('style change');
        $('#posting_detail_modal form[name=posting_detail_form] .mentiony-content').css('min-height', '40px');
        $('#posting_detail_modal form[name=posting_detail_form] .mentiony-content').text('');
        $('#posting_detail_modal form[name=posting_detail_form] input[name=commentFile]').val('');
        var mentionTemplate = '<span class="mention-area"><span class="highlight"><a href="javascript:;" data-item-id="[MENTIONID]" class="mentiony-link">@[NAME]</a></span></span>'
        if (commentCnt > 0) {
            for (var i=0;i<data.length;i++) {
                if (i == 0) {
                    firstId = data[i].id;
                }
                lastId = data[i].id;
                commentHtml += "<div class='media' style='margin-top:10px;'>";
                commentHtml += "<a class='media-left' href='javascript:;'>";
                commentHtml += "	<img src='"+getImage(data[i].owner.photoUrl, 'noimg.png')+"' style='width: 40px;height: 40px;border-radius: 10%;'>";
                commentHtml += "</a>";
                commentHtml += "<div class='media-body' style='margin-left: 10px;'>";
                commentHtml += "<h5 class='media-heading'>"+data[i].owner.nickname+"</h5>";

                var blindBtnText = (data[i].isBlind == true) ? '숨김해제' : '숨김';
                if (data[i].isDelete) {
                    commentHtml += "<span style='color:red;''>(삭제)</span> <span style='text-decoration: line-through;'>" + xssFilter(data[i].orgText) + "</span>";
                    commentHtml += "</br>";
                    commentHtml += timeBefore(data[i].createdAt);
                } else if (data[i].isBlind) {
                    commentHtml += "<span style='color:red;''>(차단)</span> <span style='text-decoration: line-through;'>" + xssFilter(data[i].orgText) + "</span>";
                    commentHtml += "</br>";
                    commentHtml += timeBefore(data[i].createdAt);
                    commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:blindComment(" +postingId+ "," +data[i].id + ", "+ (data[i].isBlind != true)  +");return false;'>"+blindBtnText+"</a></br>";
                } else {

                    var content = data[i].plainText;
                    for(var j = 0; j < data[i].mentions.length ; j++) {
                        var mention = data[i].mentions[j];
                        if(content) {
                            content = content.replaceAll('@[' + mention.id + ']', mentionTemplate.replace('[MENTIONID]', mention.id).replace('[NAME]', mention.nickname));
                        }
                        else {
                            content = "";
                        }
                    }
                    commentHtml += '<div style="width: 400px;word-break: break-all;">' + content + "</div>";
                    //commentHtml += data[i].text;
                    commentHtml += "</br>";
                    commentHtml += timeBefore(data[i].createdAt);

                    console.log('comment', data[i].id, data[i].isBlind, blindBtnText);
                    commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:makereply(" +postingId+ "," +data[i].id + ");return false;'>답글달기</a>";
                    commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:blindComment(" +postingId+ "," +data[i].id + ", "+ (data[i].isBlind != true)  +");return false;'>"+blindBtnText+"</a></br>";
                }

                commentHtml += "<div style='height:5px;''></div>";
                for (var j=0;j<data[i].attachments.length;j++) {	// 댓글이미지
                    var imgUrl = getImage(data[i].attachments[j].photoUrl, 'upload.png');
                    commentHtml += "<img src='"+imgUrl+"' style='width: 80%;'></br>";
                }

                commentHtml += "<div id='comment-"+lastId+"' class='input-group' style='display:none;'>";
                commentHtml += "	<div class='col-10' style=''>";
                commentHtml += "	    <fieldset class='form-group' style='margin-top: 15px;margin-bottom: 10px;'>";
//				commentHtml += "			<textarea rows='2' class='form-control' id='commentText-"+lastId+"' name='commentText-"+lastId+"' placeholder='댓글 입력'></textarea>	";
                commentHtml += "			<textarea rows='2' class='form-control autosize' id='commentText' name='commentText' placeholder='답글 입력'></textarea>	";
                commentHtml += "	    </fieldset>";
                commentHtml += "	    <fieldset class='form-group'>";
                commentHtml += "		<div class='fonticon-container'>";
                commentHtml += "		    <div class='custom-file'>";
//				commentHtml += "			<input type='file' class='custom-file-input' id='replyFile-"+lastId+"' name='commentFile-"+lastId+"'>			";
                commentHtml += "			<input type='file' class='custom-file-input' id='replyFile' name='replyFile'>			";
                commentHtml += "			<label class='custom-file-label' for='replyFile' aria-describedby='댓글 첨부'></label>				";
                commentHtml += "		    </div>  ";
                commentHtml += "		</div> ";
                commentHtml += "	    </fieldset>	";
                commentHtml += "	</div>	";
                commentHtml += "	<div id='comment-7886730' class='col-2' style='margin-top: 15px;margin-bottom: 10px;'>";
                commentHtml += "	    <button class='btn btn-success' type='button' onclick='javascript:createReply(" +postingId+ ", " + lastId + ")'><i class='la la-save'></i></button>					";
                commentHtml += "	</div>";
                commentHtml += "</div>";

                // 대댓글 영역
                var children = data[i].children;
                if (children.length > 0) {
                    for (var j=0;j<children.length;j++) {
                        commentHtml += "	<div class='media mt-1'>";
                        commentHtml += "    	<a class='media-left' href='javascript:;'>";
                        commentHtml += "        	<img src='"+getImage(children[j].owner.photoUrl, 'noimg.png')+"' style='width: 40px;height: 40px;border-radius: 10%;'>";
                        commentHtml += "        </a>";
                        commentHtml += "    	<div class='media-body'  style='margin-left: 10px;'>";
                        commentHtml += "        	<h5 class='media-heading'>"+children[j].owner.nickname+"</h5>";

                        var childBlindBtnText = (children[j].isBlind == true) ? '숨김해제' : '숨김';
                        if (children[j].isDelete) {
                            commentHtml += "<span style='color:red;''>(삭제)</span> <span style='text-decoration: line-through;'>" + xssFilter(children[j].orgText) + "</span>";
                            commentHtml += "</br>";
                            commentHtml += timeBefore(children[j].createdAt);
                        } else if (children[j].isBlind) {
                            commentHtml += "<span style='color:red;''>(차단)</span> <span style='text-decoration: line-through;'>" + xssFilter(children[j].orgText) + "</span>";
                            commentHtml += "</br>";
                            commentHtml += timeBefore(children[j].createdAt);
                            commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:blindComment(" +postingId+ "," +children[j].id + "," + (children[j].isBlind != true) +");return false;'>"+childBlindBtnText+"</a></br>";
                        } else {

                            var content = children[j].plainText;
                            for(var k = 0; k < children[j].mentions.length ; k++) {
                                var mention = children[j].mentions[k];
                                if(content) {
                                    content = content.replaceAll('@['+mention.id+']',  mentionTemplate.replace('[MENTIONID]',  mention.id).replace('[NAME]', mention.nickname));
                                } else {
                                    content = "";
                                }
                            }
                            commentHtml += '<div style="width: 340px;word-break: break-all;">' + content + "</div>";

                            //commentHtml += children[j].text;
                            commentHtml += "</br>";
                            commentHtml += timeBefore(children[j].createdAt);
                            commentHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:;' onclick='javascript:blindComment(" +postingId+ "," +children[j].id + "," + (children[j].isBlind != true) +");return false;'>"+childBlindBtnText+"</a></br>";
                        }

                        commentHtml += "<div style='height:5px;''></div>";
                        var childrenAttach = children[j].attachments;
                        if((typeof childrenAttach != "undefined") && (childrenAttach.length>0)){
                            for (var k=0;k<childrenAttach.length;k++) {	 // 대댓글이미지
                                commentHtml += "<img src='"+getImage(childrenAttach[k].photoUrl, 'upload.png')+"' style='width: 80%;'></br>";
                            }
                        }
                        commentHtml += "			</div>";
                        commentHtml += "    </div>";
                    }
                }
                commentHtml += "</div>";
                commentHtml += "</div>	";

            }

            var pagingHtml = makePaging(postingId, commentCnt);
            commentHtml += pagingHtml;
            commentHtml += "</div>	";

            //console.log(data[0].text);
            //console.log(commentHtml);
            prevCommentId = firstId;

            $('#commentArea').html(commentHtml);
        } else {

            commentHtml += "</div>	";
            $('#commentArea').html(commentHtml);
            //alert('')
        }

    }

    function makePaging(postingId, commentCnt){

//		console.log('prevCommentId : ' + prevCommentId);
//		console.log('lastId : ' + lastId);
        console.log('makePaging : ', currentPage);
        var pagingHtml = "";
        pagingHtml +="<div class='my-1'>";
        pagingHtml +="          <ul class='pager pager-round'>";

        //이전 페이지 가져오기
        pagingHtml +="              <li class=''>";
        pagingHtml +="                  <a href='javascript:;' onclick=\"javascript:getComments("+postingId+", "+(lastId - 1)+", 'oldest');return false;\"><i class='ft-arrow-left'></i> 이전</a>";
        pagingHtml +="              </li>";

        if(currentPage > 1) {
            //이후 페이지 가져오기
            pagingHtml +="              <li class=''>";
            pagingHtml +="                  <a href='javascript:;' onclick=\"javascript:getComments("+postingId+", "+firstId+", 'newest');return false;\">다음 <i class='ft-arrow-right'></i></a>";
            pagingHtml +="              </li>";

        }



        /*if (commentCnt < 5) {
            pagingHtml +="              <li class='disabled'>";
            pagingHtml +="                  <a href='#'><i class='ft-arrow-left'></i> 이전</a>";
            pagingHtml +="              </li>";
        } else {
            pagingHtml +="              <li class=''>";
            pagingHtml +="                  <a href='#' onclick='javascript:getComments("+postingId+", 0, " + (lastId-1) + ");'><i class='ft-arrow-left'></i> 이전</a>";
            pagingHtml +="              </li>";
        }

        if (prevCommentId==0) {
            pagingHtml +="              <li class='disabled'>";
            pagingHtml +="                  <a href='#'>다음 <i class='ft-arrow-right'></i></a>";
            pagingHtml +="              </li>";
        } else {
            pagingHtml +="              <li class=''>";
            pagingHtml +="                  <a href='#' onclick='javascript:getComments("+postingId+", " + prevCommentId + ", 0);'>다음 <i class='ft-arrow-right'></i></a>";
            pagingHtml +="              </li>";
        }*/

        pagingHtml +="          </ul>";
        pagingHtml +="      </div>";
        return pagingHtml;
    }

    function xssFilter(origin) {
        return origin.replace(/\<|\>|\"|\'|\%|\;|\(|\)|\&|\+|\-/g, "");
    }


    var conditions = <c:out value="${conditions}" escapeXml="false" />;

    function conditionToHtml(condition) {
        //키우는장소, 자라는환경, 물, 분갈이
        if(condition) {
            var html = '<br>1. 키우는 장소 : ' + conditions[condition.place];
            html += '<br>2. 자라는 환경 : ' + conditions[condition.light];
            html += '<br>3. 물 주는 방식 : ' + conditions[condition.water];
            html += '<br>4. 마지막 분갈이 : ' + conditions[condition.repotting];
            html += '<br>';
            return html;
        } else {
            return '';
        }
    }

    function detailView(dataSet) {

        <c:if test="${!isAdmin}">
        if('<%=strUserId%>' == dataSet.owner.id) {
            console.log('isOwner');
            $('#detail_to_modify').css('display', 'block');
        } else {
            $('#detail_to_modify').css('display', 'none');
        }
        </c:if>

        changeScroll(true);
        //$('#posting_modify_modal form[name=posting_modify_form] input[name=title]').empty().val(dataSet.title);
        $('#detail_youtube_view').empty();
        if(dataSet.youtubeId) {
            loadEmbedYoutubeById(dataSet.youtubeId)
            $('#detail_youtube_view').css('display', '');
        } else {
            $('#detail_youtube_view').css('display', 'none');
        }

        $('#detail_title').html(dataSet.title);
        $('#detail_text').html("<span style='font-size: 110%;background-color: white;'>" +xssFilter(dataSet.orgText) + "</span>");
        $('#detail_condition').html(conditionToHtml(dataSet.condition));

        var user = dataSet.owner.nickname + ' (ID:' + dataSet.owner.id + ')';
        $('#detail_user_nick').html(user);
        $('#detail_createdAt').html(moment(dataSet.createdAt).format('YYYY-MM-DD HH:mm:ss'));
        $('#detail_modifiedAt').html(moment(dataSet.modifiedAt).format('YYYY-MM-DD HH:mm:ss'));

        $("#detail_user_photo").attr("src", getProfileImage(dataSet.owner.photoUrl, 'noimg.png'));

        $('#posting_detail_modal form[name=posting_modify_form] input[name=postingId]').empty().val(dataSet.id);
        $('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').empty().val(dataSet.id);
        $('#posting_detail_modal form[name=posting_detail_form] input[name=blind]').empty().val(dataSet.isBlind);

        var btnText = (dataSet.isBlind == true) ? '숨김해제' : '숨김';
        $('#btn-blind-posting').text(btnText);

        $('#notification_modal form[name=notification_form] input[name=postingId]').empty().val(dataSet.id);

        <c:if test="${postingType == PostingType.guidebook || postingType == PostingType.television}">
        if(dataSet.posters && dataSet.posters.length > 0) {
            $('#detail_poster').html("<img class='img-thumbnail' src='" + dataSet.posters[0].photoUrl + "' style='width:100%;padding: 0rem;'/><hr>");
        }
        </c:if>
        /* var count = $(this).parent()[0].childElementCount;
        console.log($("#posting_modify_modal form[name=posting_modify_form] input[name^='repeater-list'").parent()[0].childElementCount); */
        //$('.delete_photo').click();
        var contentsHtml = "";

        for(var i=0; i < dataSet.orgAttachments.length; i++){
            var imgUrl = dataSet.orgAttachments[i].photoUrl + "?f=jpg";
            var description = dataSet.orgAttachments[i].description;

            var placeHtml = (dataSet.orgAttachments[i].placeName !== undefined) ? '<span class="position active"><span class="place">'+ dataSet.orgAttachments[i].placeName  + '</span></span>' : '<span class="position inactive"><span  class="place">위치없음</span></span>';
            contentsHtml += "<div class='media'>";
            contentsHtml += "<div class='media-body' style='margin-left:0px;position:relative;'>";
            contentsHtml += placeHtml;
            contentsHtml += "<img src='" + imgUrl + "' style='width:100%;'/>";
            contentsHtml += "</div>";
            contentsHtml += "</div>";
            contentsHtml += "<div class='media'>";
            contentsHtml += "<div class='media-body' style='margin-left: 10px;margin-top:10px;margin-bottom:20px;'>";
            if(typeof description != "undefined"){
                contentsHtml += "<span class='text-muted'><span style='font-size: 110%;background-color: white;'><pre style='font-size: 110%;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;'>" + description + "</pre></span></span>";
            }
            contentsHtml += "</div>";
            contentsHtml += "</div>";
        }
        $('#detail_attach_view').html(contentsHtml);
        $('#detail_likecnt').html(dataSet.likeCount);
        $('#detail_scrapcnt').html(dataSet.scrapCount);
        $('#detail_viewcnt').html(dataSet.readCount);
        $('#detail_commentcnt').html(dataSet.commentCount);


        if(dataSet.goodses != null && dataSet.goodses.length > 0) {
            console.log('goodses', dataSet.goodses);

            var template = '<div style="border-style: solid;border-width: thin;margin: 2px 0; height:102px;"><img src="{src}" style="float: left"><div style="font-size: 14px; margin:0 105px; font-weight: bold;">{title}</div><div style="font-size: 14px; margin-left:10px; margin:0 105px;">{price}<div></div>';
            var html = template.replace("{title}", dataSet.goodses[0].name)
                .replace("{price}", dataSet.goodses[0].discountedPrice + '원')
                .replace("{src}", dataSet.goodses[0].photoUrl + '?d=100x100');
            $('#detail_goods_view').html(html);
        }

        initPage();
        modifyView(dataSet);
        getComments(dataSet.id, 0);
    }

    function makereply(postingId, commentId) {
        $('#comment-'+commentId).toggle();
    }

    /*function blindComment() {
        event.preventDefault();
        var form = $('#posting_detail_form')[0];
        var data = new FormData(form);
        //$("#btnSubmit").prop("disabled", true);
        data.append("commentId", commentId);
        data.append("blind", blind);
        var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/"+postingId+"/blindComments",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                setTimeout(function(){
                    getComments(postingId, 0)
                }, 500);
            },
            error: function (e) {

                alert(e);
            }
        });
    }

    function blindPosting(postingId) {
    }
*/

    function mentionContentToText(commentId) {
        var selector = (commentId) ? '#comment-' + commentId : '#comment';
        var html = $('.mentiony-content', selector).html();
        var $html = $('<div>' + html + '</div>');

        if(typeof $html == 'string') {
            return xssFilter($html);
        } else {
            var mentionLinks = $html.find('.mentiony-link');
            if(mentionLinks.length) {
                for(var i = 0 ; i < mentionLinks.length ; i++) {
                    var id = $(mentionLinks[i]).attr('data-item-id');
                    $(mentionLinks[i]).text('@[' + id + ']');
                }
                console.log('case1', $html);
                return xssFilter($html.text());
            } else {
                console.log('case2', $html);
                return xssFilter($html.text());
            }
        }
    }

    function createReply(postingId, commentId) {
        event.preventDefault();
        var form = $('#posting_detail_form')[0];
        //var data = new FormData(form);

        var data = new FormData();

        data.append('replyFile', $('#replyFile', '#comment-' + commentId)[0].files[0])
        data.append('commentText', mentionContentToText(commentId));
        data.append("commentId", commentId);

        //$("#btnSubmit").prop("disabled", true);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/"+postingId+"/createComments",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                setTimeout(function(){
                    getComments(postingId, 0)
                }, 500);
            },
            error: function (e) {

                alert(e);
            }
        });
    }

    function saveComment() {

        event.preventDefault();
        var form = $('#posting_detail_form')[0];
        //var data = new FormData(form);

        var data = new FormData();

        data.append('commentFile', $('#commentFile', '#comment')[0].files[0])
        data.append('commentText', mentionContentToText());
        //$("#btnSubmit").prop("disabled", true);
        var postingId =$('#posting_detail_modal form[name=posting_detail_form] input[name=postingId]').val();
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/rest/"+postingId+"/createComments",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                setTimeout(function(){
                    getComments(postingId, 0)
                }, 500);
            },
            error: function (e) {
                alert(e);
            }
        });
    }

    function loadEmbedYoutubeById(id){
        $.ajax({
            type: "GET",
            url: '/rest/postings/youtube?url=' + encodeURI('https://www.youtube.com/watch?v='+ id),
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                console.log(data);
                if(data.resultCode === 1000) {
                    var html = $(data.resultData.html);
                    // html.attr('width', '100%');
                    // html.attr('height', 'auto');
                    console.log(html);
                    $('#detail_youtube_view').empty().html(html);
                } else {
                    alert( '동영상 정보를 가져올 수 없습니다. ');
                }
            },
            error: function (e) {
                alert('실패');
                console.log(e);
            }
        });
    }
</script>
