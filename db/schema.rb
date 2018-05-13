# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170913141641) do

  create_table "t_api", primary_key: "api_id", id: :integer, comment: "接口ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "api_name", limit: 64, comment: "接口名称"
    t.integer "api_proj_id", comment: "接口所属项目ID"
    t.string "api_url", limit: 256, comment: "接口地址"
    t.string "api_sys_name", limit: 64, comment: "接口所属系统名称"
    t.integer "api_sampler_type", comment: "接口类型：1: http, 2:webservice"
    t.string "api_protocol", limit: 10, comment: "协议名称"
    t.string "api_request_method", limit: 10, comment: "请求方法：1: GET, 2:POST,3:HEAD,4:PUT,"
    t.text "soap_request_tpl"
    t.integer "user_id", comment: "接口创建者ID"
    t.string "user_name", limit: 64, comment: "接口创建者姓名"
    t.datetime "created_at", comment: "接口创建时间"
    t.integer "status", default: 0, comment: "0:正常，1代表删除"
    t.datetime "last_exec_time", comment: "最后执行时间"
    t.integer "exec_user_id", comment: "接口执行者ID"
    t.string "exec_user_name", limit: 64, comment: "接口执行者姓名"
    t.integer "exec_count", comment: "执行次数"
    t.integer "exec_status", default: 0, comment: "0：未执行-已阅，1: 成功，2：失败, 3：执行中"
    t.integer "exec_pass_case_count", comment: "执行用例成功数"
    t.integer "exec_fail_case_count", comment: "执行用例失败数"
    t.integer "lock", default: 0, comment: "0-正常使用，1-被用作规则，2-被用作计划任务"
  end

  create_table "t_api_data", primary_key: ["id", "api_id", "case_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false, comment: "自增ID"
    t.integer "api_id", null: false, comment: "接口ID"
    t.string "case_id", limit: 32, null: false, comment: "用例ID"
    t.string "case_title", limit: 512
    t.string "response_code", limit: 32, comment: "校验的值,多个校验值用“,”隔开"
    t.string "response_msg", limit: 128
    t.string "remarks", limit: 64, comment: "数据说明"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "mock_user_id"
    t.integer "status", default: 0, comment: "0-正常，1-删除"
    t.string "param_1", limit: 32, comment: "param_1 - param_50: 参数名称 "
    t.string "param_2", limit: 32
    t.string "param_3", limit: 32
    t.string "param_4", limit: 32
    t.string "param_5", limit: 32
    t.string "param_6", limit: 32
    t.string "param_7", limit: 32
    t.string "param_8", limit: 32
    t.string "param_9", limit: 32
    t.string "param_10", limit: 32
    t.string "param_11", limit: 32
    t.string "param_12", limit: 32
    t.string "param_13", limit: 32
    t.string "param_14", limit: 32
    t.string "param_15", limit: 32
    t.string "param_16", limit: 32
    t.string "param_17", limit: 32
    t.string "param_18", limit: 32
    t.string "param_19", limit: 32
    t.string "param_20", limit: 32
    t.string "param_21", limit: 32
    t.string "param_22", limit: 32
    t.string "param_23", limit: 32
    t.string "param_24", limit: 32
    t.string "param_25", limit: 32
    t.string "param_26", limit: 32
    t.string "param_27", limit: 32
    t.string "param_28", limit: 32
    t.string "param_29", limit: 32
    t.string "param_30", limit: 32
    t.string "param_31", limit: 32
    t.string "param_32", limit: 32
    t.string "param_33", limit: 32
    t.string "param_34", limit: 32
    t.string "param_35", limit: 32
  end

  create_table "t_api_exec_log", id: :integer, comment: "自增序列", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "api_id", null: false, comment: "接口ID"
    t.integer "case_id", comment: "用例ID"
    t.string "request_protocol", limit: 10, comment: "请求协议"
    t.string "request_header", limit: 512, comment: "请求报文头"
    t.text "request_data", comment: "请求报文"
    t.string "response_header", limit: 512, comment: "响应报文头"
    t.string "response_code", limit: 10, comment: "响应状态"
    t.text "response_data", comment: "响应报文"
    t.text "exec_check_script", comment: "校验结果执行的脚本"
    t.integer "exec_expect_value", comment: "校验响应值"
    t.integer "exec_result", comment: "执行结果：0: pass,  9: fail"
    t.integer "exec_user_id", comment: "执行者ID"
    t.string "exec_time", limit: 32, comment: "执行时间"
  end

  create_table "t_api_param_info", primary_key: ["api_id", "api_param", "param_alias_name"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "api_id", null: false, comment: "接口ID"
    t.string "param_alias_name", limit: 32, null: false
    t.string "api_param", limit: 32, null: false, comment: "api参数名"
    t.string "param_title", limit: 256, comment: "字段中文说明"
    t.string "param_value", limit: 128, comment: "参数取样值"
    t.integer "param_max_length", comment: "字符最长数"
    t.integer "param_min_length", default: 0, comment: "字符最小数"
    t.integer "param_is_required", comment: "是否必填: Yes: 1 ,  No: 0"
    t.integer "param_is_number", comment: "是否为数字：Yes: 1 ,  No: 0"
    t.integer "param_allow_special_char", comment: "是否允许特殊字符：Yes: 1 ,  No: 0"
    t.integer "status", default: 0, comment: "参数状态： 0:正常， 1：停用"
    t.datetime "created_at", comment: "创建时间"
    t.datetime "updated_at", comment: "更新时间"
    t.integer "user_id", comment: "创建或修改者ID"
  end

  create_table "t_data_rule", primary_key: "data_rule_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "data_rule_name", limit: 64, comment: "rule名称"
    t.integer "proj_id"
    t.integer "api_id"
    t.string "data_from_api_system", limit: 6, comment: "数据来源"
    t.text "param_desc", comment: "结果参数规则描述"
    t.integer "status", default: 0, comment: "0-正常，1-删除"
    t.integer "cmock_user_id"
    t.datetime "updated_at"
  end

  create_table "t_depts", primary_key: "dept_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "部门ID，自增序列，唯一标识" do |t|
    t.string "dept_name", limit: 20, comment: "部门名称"
    t.string "dept_pid", limit: 20, comment: "上级部门ID"
    t.integer "status", default: 0, comment: "0:正常，1：关闭"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_id_rule", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id_pre_num"
    t.integer "user_id_begin_num"
    t.integer "user_id_next_num"
    t.integer "role_id_pre_num"
    t.integer "role_id_begin_num"
    t.integer "role_id_next_num"
    t.integer "dept_id_pre_num"
    t.integer "dept_id_begin_num"
    t.integer "dept_id_next_num"
    t.integer "proj_id_pre_num"
    t.integer "proj_id_begin_num"
    t.integer "proj_id_next_num"
    t.integer "api_id_pre_num"
    t.integer "api_id_begin_num"
    t.integer "api_id_next_num"
    t.integer "data_rule_id_begin_num"
    t.integer "data_rule_id_pre_num"
  end

  create_table "t_jobs", primary_key: "job_id", id: :integer, comment: "自增ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "job_name", limit: 32
    t.string "rule_ids", limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_exec_time"
    t.integer "last_exec_user_id"
    t.integer "owner_user_id"
    t.string "project_id", limit: 32
    t.integer "status", default: 0, comment: "0:正常，1-删除"
  end

  create_table "t_projs", primary_key: "proj_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "proj_name", limit: 256
    t.string "proj_code", limit: 32
    t.datetime "proj_created_at"
    t.datetime "proj_updated_at"
    t.datetime "proj_last_exec_time"
    t.integer "proj_exec_count", default: 0, comment: "执行次数"
    t.integer "proj_stage", default: 0, comment: "项目阶段，0-defaults,1-一期，2-二期，3-三期，9-已发布"
    t.string "proj_url", limit: 128, comment: "项目访问地址"
    t.integer "user_id", comment: "创建者ID"
    t.string "user_name", limit: 64, comment: "创建者姓名"
    t.integer "status", default: 0, comment: "0:正常，1代表删除"
  end

  create_table "t_roles", primary_key: "role_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "角色ID，自增序列，唯一标识" do |t|
    t.string "role_name", limit: 16, comment: "角色名称"
    t.string "status", limit: 1, default: "0", comment: "角色状态，0代表正常，1代表删除"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_rule", primary_key: "rule_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "rule_name", limit: 64, comment: "rule名称"
    t.string "rule_code", limit: 64, comment: "规则编号"
    t.integer "status", default: 0, comment: "0-正常，1-删除"
  end

  create_table "t_script", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "system_id"
    t.string "script_name", limit: 64
    t.text "script_file"
    t.string "file_path", limit: 64
    t.string "data_file_path", limit: 64
    t.integer "cmock_user_id"
    t.datetime "created_at"
    t.integer "status", default: 0, comment: "0-正常，1-删除"
    t.integer "lock", default: 0, comment: "0-未关联，1-已管理，禁止删除"
  end

  create_table "t_special_char", id: :integer, comment: "id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "char", limit: 5, comment: "特殊字符"
    t.string "char_name", limit: 50, comment: "名称"
    t.string "cn_name", limit: 50, comment: "中文名"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "user_name", limit: 64
  end

  create_table "t_users", primary_key: "user_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "用户ID，自增序列，唯一标识" do |t|
    t.string "user_login_id", limit: 16, comment: "登录ID，登录用户名"
    t.string "user_passwd", limit: 64, comment: "登录密码"
    t.string "user_name", limit: 64, comment: "用户名"
    t.string "dept_id", limit: 11, comment: "所属的部门id"
    t.string "sex", limit: 2, default: "0", comment: "性别：0女，1男，2其他"
    t.string "status", limit: 2, default: "0", comment: "用户状态，0代表正常，1代表关闭"
    t.string "role_id", limit: 11, comment: "用户角色ID"
    t.string "phone_no", limit: 16, comment: "电话"
    t.datetime "created_at", comment: "创建时间"
    t.datetime "updated_at", comment: "修改时间"
    t.string "login_ip", limit: 36, comment: "用户最后一次登陆的ip地址"
  end

end
