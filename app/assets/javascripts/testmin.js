$(document).ready(function(){
    if (document.getElementById("st_api_sys_name")) {
        var _st_api_sys_name = document.getElementById("st_api_sys_name");
        _st_api_sys_name.onchange = function () {
            testmin.fn.getApiNameList($("#st_system_id").val(),$("#st_api_sys_name").val());
        }
    }
    if (document.getElementById("st_system_id")) {
        var _st_system_id = document.getElementById("st_system_id");
        _st_system_id.onchange = function () {
            testmin.fn.getApiSystemNameList($("#st_system_id").val());
        }
    }
    if (document.getElementById("st_api_id")) {
        var _st_api_id = document.getElementById("st_api_id");
        _st_api_id.onchange = function () {
            testmin.fn.getApiParamList($("#st_api_id").val());
        }
    }
    if (document.getElementById("job_rule_list")) {
        var _job_rule_list = document.getElementById("job_rule_list");
        _job_rule_list.onclick = function () {
            testmin.fn.getRuleList($("#st_job_project_id").val());
        }
    }

    
});
var testmin = testmin || {};
testmin.fn = {
    jobRuleDel:function(_job_id){
        $.ajax({
            url:"/testmin/jobDel",
            data:{
                "_job_id" :_job_id
            },
            type:"POST",
            sync:false,
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(getStatus){
                    testmin.fn.jobRuleLableDel(_job_id);
                }else{
                    exit;
                }
            }
        });
    },
    jobRuleLableDel:function(_job_id){
        $("#jobRuleLi_"+_job_id).remove();
    },
    getRuleList:function(_proj_id){
        $.ajax({
            url:"/testmin/getRuleList",
            data:{
                "_proj_id" :_proj_id
            },
            type:"POST",
            async:false,
            dataType:'json',
            success:function(data){
                if(data.status== 0){
                    $("#dataRuleList").html("");
                    $("#dataRuleList").append(data.msg);
                    $("#ruleListPopUp").css('display','block'); 
                    $("#job_rule_list").html("");
                    $("#data_rule_ids_list").val("");
                }else{
                    alert("数据获取失败！");
                }
            }
        });
    },
    toGetSelectRule:function(_id,_this){
        //alert(_id);
        //alert(_this.value);
        if($("#dataRuleCheckBox_"+_id).is(":checked")){
            _html = '<div id="selectedRule_'+_id+'" style="word-wrap:break-word" value="'+_id+'">'+_this.value+'</div> '
            $("#job_rule_list").append(_html);
            $("#data_rule_ids_list").val($("#data_rule_ids_list").val()+','+_id);
        }else{
            $("#selectedRule_"+_id).remove();
            $("#data_rule_ids_list").val($("#data_rule_ids_list").val().replace(","+_id,""));
        }
    },
    ruleListDetailFormHidden:function(){
        $("#ruleListPopUp").css('display','none'); 
       // _html = "";
        //_html = _html + '<input type="hidden" name="job_rule_ids_list" value="' + $("#job_rule_popup_ids_list").val() +'">'
        //$("#job_rule_list").append(_html);
    },
    getApiSystemNameList:function(_sys_id){
        $.ajax({
            url:"/testmin/getApiSystemNameList",
            data:{
                "_sys_id" :_sys_id
            },
            type:"POST",
            async:false,
            dataType:'json',
            success:function(data){
                if(data.status== 0){
                    $("#st_api_sys_name").html("");
                    $("#st_api_sys_name").append(data.msg);
                }else{
                    alert("数据获取失败！");
                }
            }
        });
    },
    getApiNameList:function(_sys_id,_sys_name){
        $.ajax({
            url:"/testmin/getApiNameList",
            data:{
                "_sys_id" : _sys_id,
                "_sys_name" :_sys_name
            },
            type:"POST",
            async:false,
            dataType:'json',
            success:function(data){
                if(data.status== 0){
                    $("#st_api_id").html("");
                    $("#st_api_id").append(data.msg);
                }else{
                    alert("数据获取失败！");
                }
            }
        });
    },
    getApiParamList:function(_api_id){
        $.ajax({
            url:"/testmin/getApiParamList",
            data:{
                "_api_id" :_api_id
            },
            type:"POST",
            async:false,
            dataType:'json',
            success:function(data){
                if(data.status== 0){
                    if(data.count > 0){
                        var param_array = new Array();
                        param_array = data.msg.split(",");
                        var _html = "";
                        _html = _html +'<div id="apiParamList" style="height:'+ data.count*40 +'px;" >';
                        _html = _html +'    <label class="col-sm-1 control-label" style="width: 76px;margin-left:60px;padding:0;font-weight:normal;height:'+ data.count*40 +'px">接口参数：</label>';
                        _html = _html +'<input type="hidden" id="tft_data_rule_param_list" name="tft_data_rule_param_list" value="'+ data.msg +'">';
                        for(var i=0; i< param_array.length; i++){
                        
                            _html = _html +'    <div class="col-sm-9" style="padding-bottom: 9px;" id="dataRuleDetail_'+param_array[i]+'">';
                            //_html = _html +'    <span style="float:left;margin-right:10px;height:30px;line-height:30px;width:80px;">'+param_array[i]+'：</span>';
                            _html = _html +'    <input type="text" name="tft_data_rule_param_'+param_array[i]+'" id="tft_data_rule_param_'+param_array[i]+'" class="col-xs-10 col-sm-5" placeholder="'+param_array[i]+'" style="width:300px;margin-right: 5px;height:30px;line-height:30px;">';
                            //_html = _html +'    <input type="checkbox" name="cbt_'+param_array[i]+'" id="cbt_'+param_array[i]+'" value="'+param_array[i]+'" style="vertical-align:middle;margin:0;">';
                            _html = _html +'    <a id="getRuleDetailBtn_'+param_array[i]+'" style="line-height: 28px;height: 28px;" href="javascript:void(0)" onclick="testmin.fn.getDataRuleDetail2('+"'"+param_array[i]+"'"+')">采用规则&gt;&gt;</a>';
                            _html = _html +'    </div>';
                            
                        }
                        _html = _html +'</div>';
                        $("#apiParamList").remove();
                        $("#ruleAddTableList").append(_html);
                    }else
                    {
                        $("#apiParamList").remove();
                    }
                }else{
                    
                    alert("数据获取失败！");
                }
            }
        });
    },
    getDataRuleDetail2:function(_param_name){
        if($("#tft_data_rule_param_"+_param_name).val().length>0){
            $("#tft_data_rule_param_"+_param_name).val("");
            //$("#tft_data_rule_param_"+_param_name).removeAttr("value");
        }
        var _html = '';


        _html = _html + '  <div id="dataRuleDetailForm"  class="dataRuleDetailForm"> <div style="margin-left:15px;">';
        _html = _html + '  <div class="checkbox">1. <label><input type="checkbox" name="randomGeneration" id="randomGeneration" value="false"> 随机生成 </label> </div>';
        _html = _html + '  <div class="checkbox"> 2. <label> <input type="checkbox" name="firstCharUpper" id="firstCharUpper" value="false"> 首字符大写 </label> </div>';
        _html = _html + '  <div class="radio"> 3. <label> <input type="radio" name="repeatable" id="repeatable" value="false"> 不可重复 </label> <label style="margin-left:10px;"> <input type="radio" name="repeatable" id="repeatable" value="true">可重复 </label> </div>';
        _html = _html + '  <div style="30px;"> 4. 限定字符长度 : <input type="textfield" name="strMaxLength" id="strMaxLength" value="" style="width:50px;height:25px;line-height:25px;"> ~  <input type="textfield" name="strMinLength" id="strMinLength" value="" placeholder="" style="width:50px;height:25px;line-height:25px;"></div>';
        _html = _html + '  <div style="height:40px; float:right;margin-top:10px; margin-right: 20px;"> <a class="btn btn-info" style="height: 30px;margin-right:10px;" href="javascript:void(0)" onclick="testmin.fn.ruleDetailCreat('+"'" + _param_name + "'"+')">确定</a><a class="btn btn-default" style="height:30px;" href="javascript:void(0)" onclick="testmin.fn.ruleDetailHidden()">取消</a></div>';
        _html = _html + '  </div></div>';

        
        $("#dataRuleDetailPopUp").append(_html);
        //$("#dataRuleDetailPopUp").attr({ display: 'block' });
        $("#dataRuleDetailPopUp").css('display','block'); 
        
    },
    ruleDetailHidden:function(){
        $("#dataRuleDetailPopUp").css('display','none');
        $("#dataRuleDetailForm").remove();
    },
    getDataRuleDetail:function(_param_name){
        if($("#getRuleDetailBtn_"+_param_name).text()=="采用规则>>"){
             if($("#tft_data_rule_param_"+_param_name).val().length>0){
                 $("#tft_data_rule_param_"+_param_name).val("");
                 //$("#tft_data_rule_param_"+_param_name).removeAttr("value");
             }
            var _html = '';
            _html = _html + '<div style=" position: fixed; z-index: 9999; background: #ffffff;     border: 1px solid #bcb1b1;width: 300px; height: 120px;width: 500px; height: 200px; top: 22%; left: 30%;" id="dataRuleDetailForm">';
            _html = _html + '<div style="padding-left: 7px;">'
            _html = _html + '   <input type="checkbox" name="randomGeneration" id="randomGeneration" value="false"> 随机生成';
            _html = _html + '   <input type="checkbox" name="firstCharUpper" id="firstCharUpper" value="false"> 首字符大写';
            _html = _html + '   <br><input type="radio" name="repeatable" id="repeatable" value="false"> 不可重复';
            _html = _html + '   <input type="radio" name="repeatable" id="repeatable" value="true"> 可重复';
            _html = _html + '   <br>限定字符长度 <input type="textfield" name="strMaxLength" id="strMaxLength" value="" style="width:50px;height:30px;line-height:30px;">';
            _html = _html + '   ~ <input type="textfield" name="strMinLength" id="strMinLength" value="" placeholder="" style="width:50px;height:30px;line-height:30px;">';
            _html = _html + '</div>';
            _html = _html + '<a class="btn btn-info" style="width: 60px;height: 30px;text-align: center;vertical-align: middle;font-size: 12px;margin-top:0px;float:right;margin-right:10px;" href="javascript:void(0)" onclick="testmin.fn.ruleDetailCreat('+"'" + _param_name + "'"+')">确定</a>';
            _html = _html + '</div>';
            $("#dataRuleDetail_"+_param_name).append(_html);
            //$("#getRuleDetailBtn").addClass("linkDisable");
            $("#getRuleDetailBtn_"+_param_name).text("取消规则<<");
            $("#tft_data_rule_param_"+_param_name).attr({ readonly: 'true' });
        }else if($("#getRuleDetailBtn_"+_param_name).text()=="取消规则<<"){
            if($("#tft_data_rule_param_"+_param_name).val().length>0){
                $("#tft_data_rule_param_"+_param_name).val("").focus();
                //$("#tft_data_rule_param_"+_param_name).removeAttr("value");
            }
            $("#getRuleDetailBtn_"+_param_name).text("采用规则>>");
            $("#dataRuleDetailForm").remove();
            $("#tft_data_rule_param_"+_param_name).removeAttr("readonly");
        }else{
            alert("无法获取操作!");
        }
    },
    ruleDetailCreat:function(_param_name){
        var ruleDetail = '';
        var _randomGeneration = $("#randomGeneration").is(':checked');
        ruleDetail = ruleDetail +  'randomGeneration:'+_randomGeneration+',';
        var _firstCharUpper = $("#firstCharUpper").is(':checked');
        ruleDetail = ruleDetail +  'firstCharUpper:'+_firstCharUpper+',';
        var _repeatable = $('input:radio[name="repeatable"]:checked').val();
        ruleDetail = ruleDetail +  'repeatable:'+_repeatable+',';
        var _strMaxLength = $("#strMaxLength").val();
        ruleDetail = ruleDetail +  'strMaxLength:'+_strMaxLength+',';
        var _strMinLength = $("#strMinLength").val();
        ruleDetail = ruleDetail +  'strMinLength:'+_strMinLength+'';
        $("#tft_data_rule_param_"+_param_name).val(ruleDetail.toString());

        $("#dataRuleDetailPopUp").css('display','none');
        $("#dataRuleDetailForm").remove();
        //$("#tft_data_rule_param_"+_param_name).removeAttr("placeholder");
        //$("#getRuleDetailBtn_"+_param_name).text("采用规则>>");
        //$("#getRuleDetailBtn_"+_param_name).addClass("linkDisable");
    },
    dataRuleDel:function(_data_rule_id){
        $.ajax({
            url:"/testmin/ruleDel",
            data:{
                "_data_rule_id" :_data_rule_id
            },
            type:"POST",
            sync:false,
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(getStatus){
                    testmin.fn.dataRuleLableDel(_data_rule_id);
                }else{
                    exit;
                }
            }
        });
    },
    dataRuleLableDel:function(_data_rule_id){
        var __data_rule_id = "dataRuleLable_" + _data_rule_id;
        if (document.getElementById(__data_rule_id)) {
            var __data_rule_id_ = document.getElementById(__data_rule_id)
            __data_rule_id_.remove();
        }
    },
    getDataFromApiSystem:function(){
        if(!$("#dataFromApiSystem").is(':checked')){
            //alert($("#tft_data_rule_param_list").val());
            $("#apiParamList").removeClass("hidden_opertion");
        }else{
            $.ajax({
                url:"/testmin/apiDataIsExist",
                data:{
                    "_api_id" :$("#st_api_id").val()
                },
                type:"POST",
                async:false,
                dataType:'json',
                success:function(data){
                    if(data.status==0){
                        $("#apiParamList").addClass("hidden_opertion");
                    }else{
                        $("[name = 'dataFromApiSystem']:checkbox").prop("checked",false);
                        alert(data.msg);
                    }
                }
            });
            
        }
    },
    execScript:function(_script_id){
        $.ajax({
            url:"/testmin/execJobs",
            data:{
                "_script_id" :_script_id
            },
            type:"POST",
            async:false,
            dataType:'json',
            success:function(data){
                if(data.status==0){
                    alert(data.msg);
                }else{
                    alert("error");
                }
            }
        });
    }

}