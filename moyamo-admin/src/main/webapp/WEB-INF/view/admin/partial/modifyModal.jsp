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
    String strPostingType = request.getParameter("postingType");
    String menuName = request.getParameter("menuName");
    PostingType postingType = PostingType.valueOf(strPostingType);
    System.out.println("modify modal board : " + postingType);

    List<String> optionNames = new ArrayList<String>();
    if(PostingType.magazine.equals(postingType)) {

    }



%>

<div class="modal fade text-left" id="posting_modify_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="posting_modify_modal_dialog" style="cursor:move;">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b> <%= menuName %> 수정</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>
            <form name="posting_modify_form" id="posting_modify_form" action="/admin/modifyPosting" method="post" enctype="multipart/form-data">
                <input type="hidden" name="postingId" value="">
                <input type="hidden" name="postingType" value="<%= postingType.name() %>">
                <div class="modal-body" style="padding: 0;">
                    <div class="card-body">
                        <% if(postingType == PostingType.guidebook) { %>
                        <div class="custom-file" style="height: 100%; width: 100%; margin-bottom: 15px;">
                            <input type="file" accept="image/*" class="custom-file-input" name="poster" />
                            <label class="custom-file-label poster-label" aria-describedby="inputGroupFileAddon02">포스터 사진 선택</label>
                            <div class="viewPoster"></div>
                        </div>
                        <% } %>

                        <% if(postingType == PostingType.television) { %>
                        <div class="custom-file" style="height: 100%; width: 100%; margin-bottom: 15px;">
                            <input type="file" accept="image/*" class="custom-file-input" name="poster" />
                            <label class="custom-file-label poster-label" aria-describedby="inputGroupFileAddon02">포스터 사진 선택</label>
                            <div class="viewPoster"></div>
                        </div>
                        <fieldset class="form-group" style="display: block;">
                            <label for="projectinput4" class="font-weight-bold">유튜브주소</label>
                            <div class="row">
                                <div class="col-9">
                                    <input type="text" class="form-control" id="youtubeUrl" name="youtubeUrl" disabled="disabled">
                                </div>
                            </div>
                        </fieldset>

                        <%-- 유튜브 메타정보를 이용할 경우 썸네일 주소--%>
                        <input type="hidden" class="form-control" id="thunbnailUrl" name="thunbnailUrl">
                        <% } %>

                        <fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
                            <label for="projectinput4">제목</label> <input type="text" class="form-control" id="title" name="title">
                        </fieldset>
                        <fieldset class="form-group">
                            <label>내용</label>
                            <textarea rows="3" class="form-control autosize" name="text"></textarea>
                        </fieldset>

                        <fieldset class="form-group" style="display: block;">
                            <div class="row mb-1">
                                <div class="col-6 col-xl-6">
                                    <label for="projectinput4">상품 등록</label> <input type="text" class="form-control" id="goodsNo" name="goodsNo">
                                </div>
                                <div class="col-3 col-xl-3" style="float: right; padding-left: 0px;margin-top: 23px;margin-left: -30px;">
                                    <button type="button" onclick="findGoods(this);" style="float: right;" data-repeater-delete="" class="btn btn-icon btn-danger mr-1">
                                        조회
                                    </button>
                                </div>
                            </div>>
                        </fieldset>

                        <br><br>
                        <hr size="3">

                        <% if(postingType != PostingType.television) { /*television 은 사진등록 안함*/ %>
                        <fieldset class="form-group">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group file-repeater">
                                        <div data-repeater-list="repeater-list">
                                            <div data-repeater-item>
                                                <div class="row mb-1">
                                                    <div class="col-10 col-xl-11">
                                                        <div class="custom-file" style="height: 100%; width: 90%; margin-bottom: 15px;">
                                                            <input type="file" accept="image/*" class="custom-file-input" name="files" />
                                                            <label class="custom-file-label" aria-describedby="inputGroupFileAddon02">사진 선택</label>
                                                            <div class="view"></div>
                                                            <input type="hidden" name="id" id="modify_id">
                                                        </div>
                                                    </div>
                                                    <div class="col-2 col-xl-1" style="float: right; padding-left: 0px;">
                                                        <button type="button" style="float: right;" data-repeater-delete="" class="btn btn-icon btn-danger mr-1 delete_photo">
                                                            <i class="ft-x"></i>
                                                        </button>
                                                    </div>
                                                    <div class="col-10 col-xl-11">
                                                        <fieldset class="form-group">
                                                            <textarea rows="2" class="autosize form-control" name="descriptions" placeholder="사진설명"></textarea>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                                <hr size="3" />
                                            </div>
                                        </div>
                                        <div class="col-12 col-xl-4" style="float: right; padding-left: 0px;">
                                            <button type="button" style="float: right;" data-repeater-create class="btn btn-primary add_photo">
                                                <i class="ft-plus"></i> 사진추가
                                            </button>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </fieldset>
                        <% } /*television 은 사진등록 안함*/ %>
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
