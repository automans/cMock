$(document).ready(function() {
    if (document.getElementById("apiType_inlineRadio1")) {
        var _apiType_inlineRadio1 = document.getElementById("apiType_inlineRadio1");
        _apiType_inlineRadio1.onclick = function () {
            $("#httpOptionStuff").removeClass("optionHiddenForApi");
            $("#WebServiceStuff").addClass("optionHiddenForApi");
        }
    }

    if(document.getElementById("apiType_inlineRadio2")){
        var _apiType_inlineRadio2 = document.getElementById("apiType_inlineRadio2");
        _apiType_inlineRadio2.onclick=  function () {
            $("#httpOptionStuff").addClass("optionHiddenForApi");
            $("#WebServiceStuff").removeClass("optionHiddenForApi");
        }
    }

});
var apiJs = apiJs || {};
apiJs.fn = {
    paramNewLableDel:function(){
        $("#apiParamNewLable").remove();
    },
    paramDataNewLableDel:function(){
        $("#apiParamDataNewLable").remove();
    },
    addNewParamLable:function(_id){
        console.log("apiJs.fn.addNewParamLable");
        var _html = ""
        _html += '<tr class="apiParamEditStatus" id="apiParamNewLable">';
        _html +=  '<td class="" style="display: none">';
        _html +=  '<input value="' + _id   +'" type="text" name="paramApiId_inputValue" id="paramName_inputValue" placeholder="" class="col-xs-10 col-sm-5 apiParamEditStyle">';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<input  value="" type="text" name="paramName_inputValue" id="paramName_inputValue" placeholder="" class="col-xs-10 col-sm-5 apiParamEditStyle">';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<input style="width:180px;" value="" type="text" name="paramDesc_inputValue" id="paramDesc_inputValue" placeholder="" class="col-xs-10 col-sm-5 apiParamEditStyle">';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<input style="width:180px;" value="" type="text" name="normalValue_inputValue" id="normalValue_inputValue" placeholder="" class="col-xs-10 col-sm-5 apiParamEditStyle" >';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<input style="width:100px;" value="" type="text" name="maxLength_inputValue" id="maxLength_inputValue" placeholder="" class="col-xs-10 col-sm-5 apiParamEditStyle" >';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<input style="width:100px;" value="" name="minLength_inputValue" type="text" id="minLength_inputValue" placeholder="" class="col-xs-10 col-sm-5 apiParamEditStyle">';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<select style="width:100px;" class="form-control apiParamEditStyle" id="isRequest_SelectValue"  name="isRequest_SelectValue">';
        _html +=  '<option value="">请选择</option>';
        _html +=  '<option value="1">Yes</option>';
        _html +=  '<option value="2">No</option>';
        _html +=  '</select>';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<select style="width:100px;" class="form-control apiParamEditStyle" id="isNumber_SelectValue" name="isNumber_SelectValue">';
        _html +=  '<option value="">请选择</option>';
        _html +=  '<option value="1">Yes</option>';
        _html +=  '<option value="2">No</option>';
        _html +=  '</select>';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<select style="width:100px;" class="form-control apiParamEditStyle" id="isSepcialChar_SelectValue" name="isSepcialChar_SelectValue">';
        _html +=  '<option value="">请选择</option>';
        _html +=  '<option value="1">Yes</option>';
        _html +=  '<option value="2">No</option>';
        _html +=  '</select>';
        _html +=  '</td>';
        _html +=  '<td class="">';
        _html +=  '<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">';
        _html +=  '<input type="submit" name="commit" value="保存" class="btn btn-info bigger-130 green" style="font-size:12px;border: none;">';
        //_html +=  '<a class="green" href="javascript:void(0)" onclick="apiJs.fn.sbumitParamValue()">';
       // _html +=  '<i class="icon-ok bigger-130" style="font-size:12px"> 保存</i>';
       // _html +=  '</a>';
        //_html +=  '<a class="green" href="#">';
        //_html +=  '<i class="icon-pencil bigger-130" style="font-size:12px"> 修改</i>';
        //_html +=  '</a>';
        _html +=  '<a class="red icon-trash bigger-130" style="font-size:12px" href="javascript:void(0)" onclick="apiJs.fn.paramNewLableDel()">';
        _html +=  ' 删除';
        _html +=  '</a>';
        //_html += '<input value="删除" class="btn btn-info bigger-130 red" style="font-size:12px;border: none;">';
        _html +=  '</div>';
        _html +=  '</td>';
        _html +=  '</tr>';
        $("#apiParamAddTable").append(_html);
    },
    addNewParamDataLable:function(_id,_param_list){
        console.log("apiJs.fn.addNewParamDataLable");
        
        if(_param_list.length > 0){
            var _param_lists = new Array();
            for(var j=0; j<_param_list.length;j++){
                console.log(_param_list[j]);
                _param_lists[j] = _param_list[j].split(",")[0];
            }
            var _html = ""
            _html +=  '<tr class="apiParamEditStatus" id="apiParamDataNewLable">';
            _html +=  '<td class="" style="display: none">';
            _html +=  '<input value="' + _id   +'" type="text" name="paramApiId_inputValue" id="paramName_inputValue" placeholder="" class="col-xs-10 col-sm-5 apiParamEditStyle">';
            _html +=  '</td>';

            _html +=  '<td class="" style="display: none">';
            _html +=  '<input value="' + _param_lists.join(",")   +'" type="text" name="paramList_inputValue" id="paramName_inputValue" placeholder="" class="col-xs-10 col-sm-5 apiParamEditStyle">';
            _html +=  '</td>';


            _html +=  '<td class="">';
            _html +=  '<input value="" type="text" name="caseId_inputValue" id="caseId_inputValue" placeholder="案件编号" class="col-xs-10 col-sm-5 apiParamEditStyle">';
            _html +=  '</td>';

            _html +=  '<td class="">';
            _html +=  '<input value="" type="text" name="caseTitle_inputValue" id="caseTitle_inputValue" placeholder="案件标题" class="col-xs-10 col-sm-5 apiParamEditStyle">';
            _html +=  '</td>';

            //_html +=  '<td class=""></td>'; //this is for case_id
            for(var i=0; i<_param_list.length;i++ )
            {
                _html +=  '<td class="">';
                _html +=  '<input value="" type="text" name="'+ _param_list[i].split(",")[0] +'" id="'+  _param_list[i].split(",")[0] +'" placeholder="'+  _param_list[i].split(",")[1] +'" class="col-xs-10 col-sm-5 apiParamEditStyle">';
                _html +=  '</td>';
            }
            _html +=  '<td class="">';
            _html +=  '<input value="" type="text" name="api_ResponseCode" id="api_ResponseCode" placeholder="响应代码" class="col-xs-10 col-sm-5 apiParamEditStyle" >';
            _html +=  '</td>';
            _html +=  '<td class="">';
            _html +=  '<input value="" type="text" name="api_reponseMsg" id="api_reponseMsg" placeholder="响应消息" class="col-xs-10 col-sm-5 apiParamEditStyle" >';
            _html +=  '</td>';
            _html +=  '<td class="">';
            _html +=  '<input value="" name="api_Remarks" type="text" id="api_Remarks" placeholder="Remarks" class="col-xs-10 col-sm-5 apiParamEditStyle">';
            _html +=  '</td>';
            _html +=  '<td class=""></td>'; //this is for update_time



            _html +=  '<td class="">';
            _html +=  '<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">';
            _html +=  '<input type="submit" name="commit" value="保存" class="btn btn-info bigger-130 green" style="font-size:12px;border: none;">';
            //_html +=  '<a class="green" href="javascript:void(0)" onclick="apiJs.fn.sbumitParamValue()">';
            // _html +=  '<i class="icon-ok bigger-130" style="font-size:12px"> 保存</i>';
            // _html +=  '</a>';
            //_html +=  '<a class="green" href="#">';
            //_html +=  '<i class="icon-pencil bigger-130" style="font-size:12px"> 修改</i>';
            //_html +=  '</a>';
            _html +=  '<a class="red icon-trash bigger-130" style="font-size:12px" href="javascript:void(0)" onclick="apiJs.fn.paramDataNewLableDel()">';
            _html +=  ' 删除';
            _html +=  '</a>';
            //_html += '<input value="删除" class="btn btn-info bigger-130 red" style="font-size:12px;border: none;">';
            _html +=  '</div>';
            _html +=  '</td>';
            _html +=  '</tr>';
            $("#apiParamDataAddTable").append(_html);
        }else{
            alert("请先添加请求参数字段!");
        }
    },
    projApiDel:function(_api_id){
        $.ajax({
            url:"/api/projApiDel",
            data:{
                "_api_id" :_api_id
            },
            type:"POST",
            async:false,
            dataType:'json',
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(!getStatus){
                    exit;
                }
            },
            success:function(data){
                if(data.status == 0){
                    apiJs.fn.apiLableDel(_api_id);
                    alert(data.msg);
                }else{
                    alert(data.msg);
                }
            }
        });
    },
    projDel:function(_proj_id){
        $.ajax({
            url:"/api/projDel",
            data:{
                "_proj_id" :_proj_id
            },
            type:"POST",
            async:false,
            dataType:'json',
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(!getStatus){
                    exit;
                }
            },
            success:function(data){
                if(data.status == 0){
                    apiJs.fn.projLableDel(_proj_id);
                    alert(data.msg);
                }else{
                    alert(data.msg);
                }
            }
        });
    },
    apiParamDataDel:function(_case_id,_api_id){
        $.ajax({
            url:"/api/paramDataDel",
            data:{
                "_case_id" : _case_id,
                "_api_id" : _api_id
            },
            type:"post",
            sync:false,
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(getStatus){
                    apiJs.fn.paramDataLableDel(_case_id);
                }else{
                    exit;
                }
            }
        });
    },
    apiParamDel:function(_param_li,_api_id){;
        $.ajax({
            url:"/api/apiParamDel",
            data:{
                "_api_id" : _api_id,
                "_param_li" : _param_li
            },
            type:"post",
            sync:false,
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(getStatus){
                    apiJs.fn.paramLableDel(_param_li);
                }else{
                    exit;
                }
            }
        });
    },
    paramLableDel:function(_param_li) {
        var __param_li = "interfaceParamLi_" + _param_li;
        if (document.getElementById(__param_li)) {
            var ___param_li = document.getElementById(__param_li)
            ___param_li.remove();
        }
    },
    paramDataLableDel:function(_case_id) {
        var _paramDataLi = "interfaceParamData_" + _case_id;
        if (document.getElementById(_paramDataLi)) {
            var __paramDataLi = document.getElementById(_paramDataLi)
            __paramDataLi.remove();
        }
    },
    projLableDel:function(_proj_id) {
        var projLiId = "projectId_" + _proj_id;
        if (document.getElementById(projLiId)) {
             var _projLi = document.getElementById(projLiId)
             _projLi.remove();
         }
    },
    apiLableDel:function(_api_id) {
        var apiLiId = "interfaceAPI_" + _api_id;
        if (document.getElementById(apiLiId)) {
            var _apiLiId = document.getElementById(apiLiId)
            _apiLiId.remove();
        }
    },
    scriptDel:function(_script_id){
        $.ajax({
            url:"/api/scriptDel",
            data:{
                "_script_id" : _script_id
            },
            type:"post",
            async:false,
            dataType:'json',
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(! getStatus){
                    exit;
                }
            },
            success:function(data){
                if(data.status == 0){
                    apiJs.fn.scriptLableDel(_script_id);
                    alert(data.msg);
                }else{
                    alert(data.msg);
                }
            }
        });
    },
    scriptLableDel:function(_script_id){
        var projLiId = "script_list_" + _script_id;
        if (document.getElementById(projLiId)) {
             var _projLi = document.getElementById(projLiId)
             _projLi.remove();
        }
    }
};