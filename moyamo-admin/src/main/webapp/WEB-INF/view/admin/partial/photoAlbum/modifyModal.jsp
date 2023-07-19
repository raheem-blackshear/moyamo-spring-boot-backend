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

%>

<div class="modal fade text-left" id="album_modify_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="album_modify_modal_dialog" style="cursor:default;">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b> 앨범 편집</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:changeScroll(false);">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>
            <form name="album_modify_form" id="album_modify_form" action="/admin/photoAlbum/modify" method="post" enctype="multipart/form-data">
                <input type="hidden" name="albumId" value="">
                <div class="modal-body" style="padding: 0;">
                    <div class="card-body">
                        <fieldset class="form-group">
                            <div class="row">
                                <div class="col-12">
                                    <textarea class="form-control autosize" name="name" placeholder="앨범명"></textarea>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="deleteAlbum" class="btn btn-danger" type="button">
                        <i class="la ft-x"></i> 앨범 삭제
                    </button>
                    <button id="modifyAlbum" class="btn btn-success" type="button">
                        <i class="la la-save"></i> 저장
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
