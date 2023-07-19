<%@ page import="net.infobank.moyamo.enumeration.PostingType" %>
<%@ page import="net.infobank.moyamo.models.Posting" %>
<%@ page import="java.util.List" %>
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
//    String menuName = request.getParameter("menuName");
    PostingType postingType = PostingType.photo;

//    System.out.println("createModal album : " + request.getParameter("album"));
//    System.out.println("createModal albums : " + request.getParameter("albums"));

%>

<div class="modal fade text-left" id="posting_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="posting_add_modal_dialog" style="">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b> 포토 등록</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  onclick="javascript:changeScroll(false);">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>
            <form name="posting_add_form" id="posting_add_form" action="/admin/registPhoto" method="post" enctype="multipart/form-data">
                <input type="hidden" name="postingType" value="photo">
                <div class="modal-body" style="padding: 0;">
                    <div class="card-body">

                        <fieldset class="form-group">
                            <div class="row">
                                <div class="col-12">
                                    <label>앨범 선택</label>
                                    <select class="form-control select " name="album" id="album" style="height:36px;" multiple title="전체">
                                        <c:forEach items="${albums}" var="a">
                                            <c:if test="${a ne '전체'}">
                                            <option>${a}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </fieldset>

                        <fieldset class="form-group">
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
	                                                        </div>
	                                                    </div>
	                                                 </div>
	                                                 <div class="row pb-2">
	                                                    <% if(postingType.isAllowDescription()) { %>
	                                                    <div class="col-12">
	                                                        <textarea class="form-control autosize" name="descriptions" placeholder="# 사진과 관련된 여러 해시태그를 넣어주세요."></textarea>
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
	                                                <i class="ft-plus add_photo"></i> 사진추가
	                                            </button>
                                        	</div>
                                        </div>
                                    </div>

                                </div>
                            </div>
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

<script type="application/javascript">

    function initSelectAlbum(albumName) {
        console.log('initSelectAlbum', albumName);
        $("#album").selectpicker('val', albumName)
    }

    $(document).ready(function(){
        //album 멀티선택 UI 활성화
        initSelectAlbum([]);
    });

</script>
