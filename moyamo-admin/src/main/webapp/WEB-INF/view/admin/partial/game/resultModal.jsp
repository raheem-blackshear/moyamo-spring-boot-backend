<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal fade text-left" id="gamble_result_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
    <div class="modal-dialog" role="document" id="gamble_result_modal_dialog" style="cursor:move;">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h3 class="modal-title white" style="font-size: 1.1rem;">
                    <b> 결과 조회</b>
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true" style="color: white;">&times;</span>
                </button>
            </div>

            <!-- modal-body -->
            <div class="modal-body" style="padding: 0;">
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <label for="maxAttempt">최대참여횟수</label>
                            <select class="form-control" id="maxAttempt">
                                <option value="0">무제한</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <!-- modal-body END -->

            <div class="modal-footer">
                <button id="delete" class="btn btn-danger" type="button">
                    <i class="la ft-x"></i> 삭제
                </button>
                <button id="modify" class="btn btn-success" type="button">
                    <i class="la la-save"></i> 저장
                </button>
            </div>
        </div>
    </div>
</div>




