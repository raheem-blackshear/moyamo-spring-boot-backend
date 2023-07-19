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
%>

<div class="modal fade text-left" id="album_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="album_add_modal_dialog" style="">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b>앨범 등록</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  onclick="javascript:changeScroll(false);">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>
            <form name="album_add_form" id="album_add_form" action="/rest/photoAlbum/regist" method="post" enctype="multipart/form-data">
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
                    <button id="registAlbum" class="btn btn-success" type="button">
                        <i class="la la-save"></i> 등록
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
