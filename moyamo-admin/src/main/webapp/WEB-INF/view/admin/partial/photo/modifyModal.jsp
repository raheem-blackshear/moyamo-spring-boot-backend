<%@ page import="net.infobank.moyamo.enumeration.PostingType" %>
<%@ page import="net.infobank.moyamo.models.Posting" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.String" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2020/08/20
  Time: 4:55 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String menuName = request.getParameter("menuName");
    PostingType postingType = PostingType.photo;
    System.out.println("modify modal board : " + postingType);
%>

<div class="modal fade text-left" id="posting_modify_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="posting_modify_modal_dialog" style="cursor:default;">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b> 포토 수정</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(false);">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>


            <form name="posting_modify_form" id="posting_modify_form" action="/admin/modifyPhoto" method="post" enctype="multipart/form-data">
                <input type="hidden" name="postingId" value="">
                <input type="hidden" name="postingType" value="<%= postingType.name() %>">
                <div class="modal-body" style="padding: 0;">
                    <div class="card-body">

                        <div class="media">
                            <a class="media-left" href="#">
                                <img class="media-object" src="" id="detail_user_photo" src="" onerror="this.src='/static/img/noimg.png';" style="width: 64px;height: 64px;border-radius: 10%;">
                            </a>
                            <div class="media-body" style="margin-left: 10px;">
                                <h5 class="media-heading" id="detail_user_nick"></h5>
                                작성일 : <span class="text-muted" id="detail_createdAt"></span></br>
                                수정일 : <span class="text-muted" id="detail_modifiedAt"></span>
                            </div>
                            <div class="media-right" style="margin-left: 10px;">

                            </div>
                        </div>


                        <fieldset class="form-group">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group file-repeater">
                                        <div data-repeater-list="repeater-list">
                                            <div data-repeater-item>
                                                <div class="row mb-1">
                                                    <div class="col-12 col-xl-12">
                                                        <div class="custom-file" style="height: 100%; width:100%; margin-bottom: 15px">
                                                            <input type="file" accept="image/*" class="custom-file-input" name="files" style="display:none"/>
                                                            <label class="custom-file-label" aria-describedby="inputGroupFileAddon02" style="display:none">사진 선택</label>
                                                            <div class="view"></div>
                                                            <input type="hidden" name="id" id="modify_id">
                                                        </div>
                                                    </div>
                                                    <div class="col-2 col-xl-1" style="float: right; padding-left: 0px;">
                                                        <button type="button" style="float: right; display:none" data-repeater-delete="" class="btn btn-icon btn-danger mr-1 delete_photo">
                                                            <i class="ft-x"></i>
                                                        </button>
                                                    </div>
                                                    <div class="col-12 col-xl-12">
                                                        <fieldset class="form-group">
                                                            <textarea rows="2" class="autosize form-control" name="descriptions" placeholder="# 사진과 관련된 여러 해시태그를 넣어주세요."></textarea>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                                <hr size="3" />
                                            </div>
                                        </div>
                                        <div class="col-12 col-xl-4" style="float: right; padding-left: 0px; display:none;">
                                            <button type="button" style="float: right;" data-repeater-create class="btn btn-primary add_photo">
                                                <i class="ft-plus"></i> 사진추가
                                            </button>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </fieldset>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="delete" class="btn btn-danger" type="button">
                        <i class="la ft-x"></i> 삭제
                    </button>
                    <button id="modify" class="btn btn-success" type="button">
                        <i class="la la-save"></i> 저장
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
