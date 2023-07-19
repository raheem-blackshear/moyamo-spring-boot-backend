<%@ page import="net.infobank.moyamo.enumeration.PostingType" %>
<%@ page import="net.infobank.moyamo.models.Posting" %>

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
    System.out.println("create modal board : " + postingType);
%>

<div class="modal fade text-left" id="posting_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="posting_add_modal_dialog" style="">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b> <%= menuName %> 등록</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  onclick="javascript:changeScroll(false);">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>
            <form name="posting_add_form" id="posting_add_form" action="/admin/registPosting" method="post" enctype="multipart/form-data">
                <input type="hidden" name="postingType" value="<%=strPostingType%>">
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
                        <div class="custom-file poster-label" style="height: 100%; width: 100%; margin-bottom: 15px;">
                            <input type="file" accept="image/*" class="custom-file-input" name="poster" />
                            <label class="custom-file-label poster-label" aria-describedby="inputGroupFileAddon02">포스터 사진 선택</label>
                            <div class="viewPoster"></div>
                        </div>
                        <fieldset class="form-group" style="display: block;">
                            <label for="projectinput4" class="font-weight-bold">유튜브주소</label>
                            <div class="row">
                                <div class="col-9">
                                    <input type="text" class="form-control" id="youtubeUrl" name="youtubeUrl">
                                </div>
                                <div class="col-3">
                                    <button type="button" class="btn btn-primary" id="youtube-meta-btn">정보 조회</button>
                                </div>
                            </div>
                        </fieldset>

                        <%-- 유튜브 메타정보를 이용할 경우 썸네일 주소--%>
                        <input type="hidden" class="form-control" id="thunbnailUrl" name="thunbnailUrl">
                        <% } %>

                        <% if(postingType.isAllowTitle()) { %>
                        <fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
                            <label for="projectinput4" class="font-weight-bold">제목</label> <input type="text" class="form-control" id="title" name="title">
                        </fieldset>
                        <% } %>
                        <fieldset class="form-group">
                            <label class="font-weight-bold">내용</label>
                            <textarea class="form-control autosize" name="text"></textarea>
                        </fieldset>

                        <fieldset class="form-group" style="display: block;">
                            <label for="projectinput4" class="font-weight-bold">상품 등록</label>
                            <div class="row pb-2">
                                <div class="col-12">
                                    <input type="text" class="form-control" id="goodsNo" name="goodsNo">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 text-right">
                                    <button onclick="findGoods(this);" type="button" data-repeater-delete="" class="btn btn-primary goodsSelect col-3" style="margin:0px;">
                                        	등록<!-- <i class="ft-check"></i> -->
                                    </button>
                                    <button onclick="removeGoods(this);" type="button" data-repeater-delete="" class="btn btn-danger goodsRemove col-3" style="margin:0px;">
                                        	삭제<!-- <i class="ft-check"></i> -->
                                    </button>
                                </div>
                            </div>
                        </fieldset>
						<br>
                        <hr size="3">
						<br>


                        <% if(postingType != PostingType.television) { /*television 은 사진등록 안함*/ %>
                        <fieldset class="form-group">
                        	<label for="projectinput4" class="font-weight-bold">사진 등록</label>
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group file-repeater">
                                        <!-- <div data-repeater-list="repeater-list"> -->

                                        <div data-repeater-list="repeater-list">
                                            <div data-repeater-item>
                                            	<div style="border: 1px solid #eee; padding: 10px; border-radius: 5px;">
	                                                <div class="row pb-2">
	                                                    <div class="col-12">
	                                                        <div class="custom-file" style="height: 100%;">
	                                                            <input type="file" accept="image/*" class="custom-file-input" name="files" />
	                                                            <label class="custom-file-label" aria-describedby="inputGroupFileAddon02">사진 선택</label>
	                                                            <input type="hidden" name="id">
	                                                            <div class="view"></div>
	                                                            <!-- <button type="button" data-repeater-delete="" class="btn btn-icon btn-danger col-12">
		                                                            <i class="ft-x"></i>
		                                                        </button> -->
	                                                        </div>
	                                                    </div>
	                                                    <!-- <div class="col-2">
	                                                        <button type="button" data-repeater-delete="" class="btn btn-icon btn-danger col-12">
	                                                            <i class="ft-x"></i>
	                                                        </button>
	                                                    </div> -->
	                                                 </div>
	                                                 <div class="row pb-2">
	                                                    <% if(postingType.isAllowDescription()) { %>
	                                                    <div class="col-12">
	                                                        <textarea class="form-control autosize" name="descriptions" placeholder="사진설명"></textarea>
	                                                    </div>
	                                                    <% } else { %>
	                                                    <div class="col-12" style="visibility: hidden">
	                                                        <textarea class="form-control autosize" name="descriptions" placeholder="사진설명"></textarea>
	                                                    </div>

	                                                    <% } %>
													</div>
													<div class="row pb-1">
	                                                    <div class="col-12 text-right">
	                                                        <button type="button" data-repeater-delete="" class="btn btn-danger col-3">
	                                                            	사진 삭제
	                                                        </button>
	                                                    </div>
	                                                </div>
                                            	</div>
                                                <hr size="3" />
                                            </div>
                                        </div>

                                        <div class="row">
                                        	<div class="col-12">
	                                            <button type="button" data-repeater-create class="btn btn-primary col-12 float-right">
	                                                <i class="ft-plus"></i> 사진추가
	                                            </button>
                                        	</div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </fieldset>
                        <% } /*television 은 사진등록 안함*/ %>

                    </div>
                </div>
                <div class="modal-footer">
                    <button id="regist" class="btn btn-success" type="button">
                        <i class="la la-save"></i> 등록
                    </button>
                </div>
            </form>
            <form name="posting_add_form" id="posting_add_form_template" action="/admin/registPosting" method="post" enctype="multipart/form-data" style="display:none">
                <input type="hidden" name="postingType" value="<%=strPostingType%>">
                <div class="modal-body" style="padding: 0;">
                    <div class="card-body">
                        <% if(postingType == PostingType.guidebook) { %>
                        <div class="custom-file" style="height: 100%; width: 100%; margin-bottom: 15px;">
                            <input type="file" accept="image/*" class="custom-file-input" name="poster" />
                            <label class="custom-file-label" aria-describedby="inputGroupFileAddon02">포스터 사진 선택</label>
                            <div class="viewPoster"></div>
                        </div>
                        <% } %>

                        <% if(postingType.isAllowTitle()) { %>
                        <fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
                            <label for="projectinput4">제목</label> <input type="text" class="form-control" id="title" name="title">
                        </fieldset>
                        <% } %>
                        <fieldset class="form-group">
                            <label>내용</label>
                            <textarea class="form-control autosize" name="text"></textarea>
                        </fieldset>

                        <fieldset class="form-group">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group file-repeater">
                                        <!-- <div data-repeater-list="repeater-list"> -->
                                        <div data-repeater-list="repeater-list">
                                            <div data-repeater-item>
                                                    <div class="row mb-1">
                                                        <div class="col-10 col-xl-11">
                                                            <div class="custom-file" style="height: 100%; width: 90%; margin-bottom: 15px;">
                                                                <input type="file" accept="image/*" class="custom-file-input" name="files" />
                                                                <label class="custom-file-label" aria-describedby="inputGroupFileAddon02">사진 선택</label>
                                                                <input type="hidden" name="id">
                                                                <div class="view"></div>
                                                            </div>
                                                        </div>
                                                        <div class="col-2 col-xl-1" style="float: right; padding-left: 0px;">
                                                            <button type="button" style="float: right;" data-repeater-delete="" class="btn btn-icon btn-danger mr-1">
                                                                <i class="ft-x"></i>
                                                            </button>
                                                        </div>
                                                        <% if(postingType.isAllowDescription()) { %>
                                                        <div class="col-10 col-xl-11">
                                                            <fieldset class="form-group">
                                                                <textarea rows="2" class="form-control autosize" name="descriptions" placeholder="사진설명"></textarea>
                                                            </fieldset>
                                                        </div>
                                                        <% } else { %>
                                                        <div class="col-10 col-xl-11" style="visibility: hidden">
                                                            <fieldset class="form-group">
                                                                <textarea rows="2" class="form-control autosize" name="descriptions" placeholder="사진설명"></textarea>
                                                            </fieldset>
                                                        </div>

                                                        <% } %>
                                                    </div>
                                                <hr size="3" />
                                            </div>
                                        </div>
                                        <div class="col-12 col-xl-4" style="float: right; padding-left: 0px;">
                                            <button type="button" style="float: right;" data-repeater-create class="btn btn-primary">
                                                <i class="ft-plus"></i> 사진추가
                                            </button>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </fieldset>

                        <fieldset class="form-group" id="fieldsethospital_name_kr" style="display: block;">
                            <label for="projectinput4">상품 등록</label> <input type="text" class="form-control" id="goodsNo" name="title">
                        </fieldset>
                    </div>
                </div>

                <div class="modal-footer">
                    <button id="regist" class="btn btn-success" type="button">
                        <i class="la la-save"></i> 등록
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
