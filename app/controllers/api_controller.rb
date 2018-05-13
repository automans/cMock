class ApiController < ApplicationController
  
  #protect_from_forgery :except => :projDel

  protect_from_forgery :only => :index
  
  def index
    @projList = TProj.where(:status=>0).all
    @projApiCount = Array.new
     for proj_li in @projList
        @projApiCount[proj_li.getProjId] = self.getApiCountByProjId(proj_li.getProjId)
     end
=begin
    @interfaceList  = TApi.find_by_sql(
        "SELECT a.api_id,
                a.api_name,
                a.api_proj_id,
                a.exec_status,
                a.api_sys_name,
                a.last_exec_time,
                a.exec_user_name,
                a.exec_count,
                b.proj_name
          FROM  t_api a
          LEFT JOIN t_projs b on a.api_proj_id = b.proj_id
          where b.status = 0 and a.status=0 ")
=end
  end

  def getApiCountByProjId(_proj_id)
    _count = TApi.find_by_sql(
        "SELECT *
          FROM  t_api a
          where a.api_proj_id=#{_proj_id} and a.status=0 ")
    return _count.count
  end

  def proj
    
    @projList = TProj.where(:status=>0).all
    @projApiCount = Array.new
    for proj_li in @projList
      #logger.info(proj_li.getProjId)
      #logger.info(TApi.where(:api_proj_id=>proj_li.getProjId).all)
      @projApiCount[proj_li.getProjId] = self.getApiCountByProjId(proj_li.getProjId)
    end
  end

  def face
    @interfaceList  = TApi.find_by_sql(
        "SELECT a.api_id,
                a.api_name,
                a.api_proj_id,
                a.exec_status,
                a.api_sys_name,
                a.last_exec_time,
                a.exec_user_name,
                a.exec_count,
                b.proj_name
          FROM  t_api a
          LEFT JOIN t_projs b on a.api_proj_id = b.proj_id
          where a.api_proj_id=#{params[:proj_id]} and a.status=0 ")
    @interfaceProjInfo = TProj.find(params[:proj_id])
  end

  def info
  end

  def dataEdit
    @interfaceProjInfo = TProj.find(params[:proj_id])

    @interfaceApi = TApi.find(params[:api_id])


    @interfaceApiParamInfo  = TApiParamInfo.find_by_sql(
        "SELECT a.api_param,a.api_id,a.param_alias_name,a.param_title
          FROM  t_api_param_info a
          where a.api_id=#{params[:api_id]} and a.status = 0 order by a.created_at")

    data_param_query_sql = ""
    @param_alias_name_list = Array.new
    i = 0
    for param in @interfaceApiParamInfo do
      data_param_query_sql += "#{param['param_alias_name']}  as #{ param['api_param']}, "
      #@param_alias_name_list[i] = param['param_alias_name']
      @param_alias_name_list[i] = "#{param['param_alias_name']},#{ param['api_param']}"
      i=i+1
    end
    _sql_ = "SELECT #{data_param_query_sql} case_id,case_title,api_id,response_code,response_msg,remarks,updated_at,status
          FROM  t_api_data
          where api_id=#{params[:api_id]} and status = 0 order by updated_at";
    @interfaceApiParamDataList  = TApiData.find_by_sql(_sql_)
    logger.info(_sql_)
    logger.info(@interfaceApiParamDataList)
  end

  def paramEdit
    @interfaceProjInfo = TProj.find(params[:proj_id])
    if @interfaceProjInfo.nil?
      @interfaceProjInfo = ""
    end
    @interfaceApi = TApi.find(params[:api_id])
    if @interfaceApi.nil?
      @interfaceApi = ""
    end
    @interfaceApiParamInfo = TApiParamInfo.where(:api_id=>params[:api_id],:status=>0).order("created_at").all
   # @interfaceApiParamInfo  = TApiParamInfo.find_by_sql(
   #      "SELECT *
   #       FROM  t_api_param_info a
   #       where a.api_id=#{params[:api_id]}")

  end

  def apiResult

  end

  def ifaceAdd
    @interfaceProjInfo = TProj.find(params[:proj_id])
    #@_t_id_rule = TIdRule.all
    #@next_api_id = ""
    #for rule_id in @_t_id_rule
    #  @next_api_id = rule_id.getApiNextId
    #end
  end
  def projAdd
    #@_t_id_rule = TIdRule.all
   # @next_proj_id = ""
   # for rule_id in @_t_id_rule
   #   @next_proj_id = rule_id.getProjNextId
    #end
  end

  def ifaceSave
    @_iface = TApi.new
    #@_iface.api_id = params[:tft_iface_id]
    @_iface.api_name = params[:tft_iface_name]
    @_iface.api_proj_id = params[:tft_project_id]
    @_iface.api_url = (! params[:tft_iface_url].empty?) ? params[:tft_iface_url] : (( ! params[:tft_wsdl_url].empty?) ? params[:tft_wsdl_url] : "-")
    begin
      @_iface.api_sys_name = (! @_iface.api_url.to_s.split("//")[1].split("/")[1].empty? ) ? ( ! @_iface.api_url.to_s.split("//")[1].split("/")[1].empty? ? @_iface.api_url.to_s.split("//")[1].split("/")[1] : "No Mapping!") : "No Mapping!"
      #@_iface.api_sys_name = (! @_iface.api_url.to_s.split("//")[1].split("/")[1].empty? ) ? @_iface.api_url.to_s.split("//")[1].split("/")[1].empty? : "No Mapping!"
    rescue
      @_iface.api_sys_name = "No Mapping!"
    end

    @_iface.api_sampler_type = case params[:inlineRadioOptions]
                                 when "httpOption"  then 1
                                 when "webServiceOption" then 2
                                 else  0
                               end
    @_iface.api_protocol = (! params[:tft_api_protocol].empty?) ? params[:tft_api_protocol] : "HTTP"
    @_iface.api_request_method = (! params[:st_protocol_name].empty?) ? params[:st_protocol_name] : "GET"
    @_iface.soap_request_tpl = params[:soap_xml_data]
    @_iface.user_id = "10000002"
    @_iface.user_name = "huweihua"
    @_iface.created_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    if @_iface.save
      #@_t_id_rule3 = TIdRule.first
      #@_t_id_rule3['api_id_next_num'] = @_t_id_rule3.getApiNextId + 1
      #@_t_id_rule3.save
      redirect_to(:controller => "api",:action => "face",:proj_id=>params[:tft_project_id])
    end
  end
  def projSave
    @_proj = TProj.new
    #@_proj.proj_id = params[:tft_project_id]
    @_proj.user_id = "10000002"
    @_proj.user_name = "huweihua"
    @_proj.proj_name = params[:tft_project_name]
    @_proj.proj_code = params[:tft_project_code]
    @_proj.proj_stage = params[:st_project_current_stage]
    @_proj.proj_url = params[:tft_project_url]
    @_proj.proj_created_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    if @_proj.save
      #@_t_id_rule2 = TIdRule.first
      #@_t_id_rule2['proj_id_next_num'] = @_t_id_rule2.getProjNextId + 1
      #@_t_id_rule2.save
      redirect_to(:action => 'proj')
    end
  end

  def apiParamSave
      @apiParamInfo = TApiParamInfo.new
      nextParamId = TApiParamInfo.where(:api_id=>params[:paramApiId_inputValue]).all
      uri = params[:cur_request_url].split("/")[4]
      _action = uri.split("?")[0]
      _api_id = uri.split("?")[1].split("&")[0].split("=")[1]
      _proj_id = uri.split("?")[1].split("&")[1].split("=")[1]
      @apiParamInfo.param_alias_name = "param_#{nextParamId.count+1}"
      @apiParamInfo.api_id = params[:paramApiId_inputValue]
      @apiParamInfo.api_param = params[:paramName_inputValue]
      @apiParamInfo.param_title = params[:paramDesc_inputValue]
      @apiParamInfo.param_value = params[:normalValue_inputValue]
      @apiParamInfo.param_max_length = params[:maxLength_inputValue]
      @apiParamInfo.param_min_length = params[:minLength_inputValue]
      @apiParamInfo.param_is_required = params[:isRequest_SelectValue]
      @apiParamInfo.param_is_number = params[:isNumber_SelectValue]
      @apiParamInfo.param_allow_special_char = params[:isSepcialChar_SelectValue]
      @apiParamInfo.user_id = "1000002"
    if @apiParamInfo.save
      redirect_to(:action=> _action, :api_id=>_api_id, :proj_id=>_proj_id)
    end
  end

  def apiParamDataSave
    @apiParamDataInfo = TApiData.new
    uri = params[:cur_request_url].split("/")[4]
    _action = uri.split("?")[0]
    _api_id = uri.split("?")[1].split("&")[0].split("=")[1]
    _proj_id = uri.split("?")[1].split("&")[1].split("=")[1]
    @apiParamDataInfo.api_id = params[:paramApiId_inputValue]
    @apiParamDataInfo.response_code = params[:api_ResponseCode]
    @apiParamDataInfo.response_msg = params[:api_reponseMsg]
    @apiParamDataInfo.remarks = params[:api_Remarks]
    @apiParamDataInfo.created_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    @apiParamDataInfo.case_id = params[:caseId_inputValue]
    @apiParamDataInfo.case_title = params[:caseTitle_inputValue]
    params[:paramList_inputValue].split(",").each do |li|
      str = "@apiParamDataInfo.#{li} =  (params[:#{li}].empty?) ? '' : params[:#{li}]"
      eval(str)
    end
    @apiParamDataInfo.mock_user_id = "1000002"
    if @apiParamDataInfo.save
      redirect_to(:action=> _action, :api_id=>_api_id, :proj_id=>_proj_id)
    end
  end

  def apiParamDel
    _sql_ = "SELECT *
            FROM  t_api_param_info
            where api_id=#{params[:_api_id]} and param_alias_name='"+ params[:_param_li]+"'";
    @_t_api_param_info = TApiParamInfo.find_by_sql(_sql_)
    if(@_t_api_param_info.count > 0)
      _sql_update = "update t_api_param_info set status = 1
            where api_id=#{params[:_api_id]} and param_alias_name='"+ params[:_param_li]+"'";
      @_t_api_param_info = TApiParamInfo.find_by_sql(_sql_update)
    end

  end
  def paramDataDel
   # @_t_api_data = TApiData.where(:api_id=>params[:_api_id],:case_id=>params[:_case_id]).delete_all
    ## @_t_api_data['status'] = 1
    ## @_t_api_data.save
   # render json: "{'status':1,'errorMsg':'操作成功'}", status:"200"

   # logger.info(params)
   # @_t_api_data = TApiData.find(:api_id=>params[:_api_id],:case_id=>params[:_case_id])
    
   # @_t_api_data['status'] = 1
   # @_t_api_data.save
   

    _sql_update = "update t_api_data set status = 1
            where api_id='" + params[:_api_id] + "' and case_id='" + params[:_case_id] + "'";
    @_t_api_data = TApiData.find_by_sql(_sql_update)
    render json: "{'status':1,'errorMsg':'操作成功'}", status:"200"
  end
  def projDel
    @__proj = TProj.find(params[:_proj_id])
    @__proj['status'] = 1
    if(@__proj.save)
      render json: {'status':0,'msg':'删除成功'}, status:"200"
    else
      render json: {'status':1,'msg':'删除失败'}, status:"200"
    end
  end
  def projApiDel
    @__t_api = TApi.find(params[:_api_id])
    if(@__t_api.getApiLockFlag == 0)
      @__t_api['status'] = 1
      if(@__t_api.save)
        render json: {'status':0,'msg':"删除成功"}, status:"200"
      else
        render json: {'status':1,'msg':"删除成功"}, status:"200"
      end 
    else
      render json: {'status':1,'msg':"接口被纳入规则或者任务，禁止删除！"}, status:"200"
    end
  end

  def infoView
    @__proj_info = TProj.find(params[:proj_id])
    @__api_info = TApi.find(params[:api_id])
    logger.info(@__api_info);
    @__api_param_info = TApiParamInfo.where(:api_id=>params[:api_id],:status=>0).order("created_at").all

    data_param_query_sql = ""
    @param_alias_name_list = Array.new
    i = 0
    for param in @__api_param_info do
      data_param_query_sql += "#{param['param_alias_name']}  as #{ param['api_param']}, "
      @param_alias_name_list[i] = param['param_alias_name']
      i=i+1
    end
    _sql_ = "SELECT #{data_param_query_sql} case_id,case_title,api_id,response_code,response_msg,remarks,updated_at,status
          FROM  t_api_data
          where api_id=#{params[:api_id]} order by updated_at";
    @__api_data_info  = TApiData.find_by_sql(_sql_)

    @_param_index = 1
    @_param_data_index = 1
  end 


  def apiExec
      @_test = ApiHelper.jmxInit
  end

  def testAjax
      @_test = JmeterScriptLib.new
      @_test.scriptEnd("this is script body")
      
  end

  def scriptDel
    @_script = TScript.find(params[:_script_id])
    logger.info(@_script.getScriptLockFlag)
    if(@_script.getScriptLockFlag == 0)
      @_script['status'] = 1
      if(@_script.save)
        render json: {'status':0,'msg':"删除成功"}, status:"200"
      else
        render json: {'status':1,'msg':"删除失败"}, status:"200"
      end 
    else
      render json: {'status':1,'msg':"脚本被纳入规则或者任务，禁止删除！"}, status:"200"
    end
  end 
  def scripts
    @_script_list = TScript.where(:status=>0).all
  end
  def scriptAdd

    @projList = TProj.where(:status=>0).all
    @project_select_list = "<option value="">请选择</option>"
    for name in @projList
         @project_select_list = @project_select_list + "<option value=" + name.getProjId.to_s + ">"+name.getProjName+"</option>";
    end
  end 
  def scriptSave
    @_script = TScript.new
    @_script.system_id = params[:st_script_belong_system]
    @_script.script_file = params[:upload_script_file]
    @_script.script_name = params[:tft_script_name]
    @_script.cmock_user_id = "10000001"
    @_script.created_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    @_root_dir = Rails.root
    __time_to_s = Time.new.to_i.to_s
    _file_path = @_root_dir.to_s + "/public/script/" + __time_to_s.to_s + ".jmx"
    @_script.file_path = _file_path
    @_script.data_file_path = _data_file_path = @_root_dir.to_s + "/public/script/data/" + __time_to_s.to_s + ".txt"
    file = File.new(_file_path,"w")
    file.puts(params[:upload_script_file].to_s.gsub('_CSV_DATA_FILE_PATH_',_data_file_path))
    file.close()
    file = File.new(_data_file_path,"w")
    file.close()

    if @_script.save
      redirect_to(:action => 'scripts')
    end
  end

end
