$(document).ready(function(){

});
var member = member || {};
member.fn = {
    roleDel:function(_role_id){
        $.ajax({
            url:"/sysmin/roleDel",
            data:{
                "_role_id" :_role_id
            },
            type:"POST",
            sync:false,
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(getStatus){
                    member.fn.roleLableDel(_role_id);
                }else{
                    exit;
                }
            }
        });
    },
    roleLableDel:function(_role_id){
        var __role_tr = "roleLable_" + _role_id;
        if (document.getElementById(__role_tr)) {
            var __role_tr_ = document.getElementById(__role_tr)
            __role_tr_.remove();
        }
    },
    userDel:function(_user_id){
        $.ajax({
            url:"/sysmin/userDel",
            data:{
                "_user_id" :_user_id
            },
            type:"POST",
            sync:false,
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(getStatus){
                    member.fn.userLableDel(_user_id);
                }else{
                    exit;
                }
            }
        });
    },
    userLableDel:function(_user_id){
        var __user_tr = "userLable_" + _user_id;
        if (document.getElementById(__user_tr)) {
            var __user_tr_ = document.getElementById(__user_tr)
            __user_tr_.remove();
        }
    },
    deptDel:function(_dept_id){
        $.ajax({
            url:"/sysmin/deptDel",
            data:{
                "_dept_id" :_dept_id
            },
            type:"POST",
            sync:false,
            beforeSend:function(){
                var getStatus = confirm("确定删除吗？");
                if(getStatus){
                    member.fn.deptLableDel(_dept_id);
                }else{
                    exit;
                }
            }
        });
    },
    deptLableDel:function(_dept_id){
        var __dept_tr = "deptLable_" + _dept_id;
        if (document.getElementById(__dept_tr)) {
            var __dept_tr_ = document.getElementById(__dept_tr)
            __dept_tr_.remove();
        }
    }
};