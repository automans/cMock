class TestminController < ApplicationController
    protect_from_forgery :only => :index

    def index

    end

    def jobs
        @jobs_list = TJob.where(:status=>0).all

        @jobsNameList = Hash.new
        for job_li in @jobs_list
            _jobRules = job_li.getJobRuleIds
            @_jobNames_temp= Array.new
            if(_jobRules.length>0)
                _i = 0;
                _jobRules.split(",").each do |li|
                    _data_rule = TDataRule.find(li);
                    if(_data_rule)
                        @_jobNames_temp[_i] = _data_rule.getDataRuleName,_i
                        _i = _i + 1
                    end
                end
            end
            @jobsNameList[job_li.getJobId] = @_jobNames_temp
        end
        
        @_projs = TProj.where(:status=>0).all
        @_proj_hashs = Hash.new;
        for proj in @_projs
            @_proj_hashs[proj.getProjId] = proj.getProjName
        end 
    end
    
    def jobDel
        @__job = TJob.find(params[:_job_id])
        @__job['status'] = 1
        @__job.save
        render json: "{'status':0,'errorMsg':'操作成功'}", status:"200"
    end
    def jobAdd
        @projList = TProj.where(:status=>0).all
        @project_select_list = "<option value="">请选择</option>"
        for name in @projList
             @project_select_list = @project_select_list + "<option value=" + name.getProjId.to_s + ">"+name.getProjName+"</option>";
        end
    end
    def execJobs
        @_root_dir = Rails.root
        _jmeter_bin = @_root_dir.to_s + "/app/apache-jmeter/bin/jmeter.bat"
        logger.info(_jmeter_bin)
        
        thread=Thread.start do   
            system("#{_jmeter_bin} -n -t E:/rails-dev/project/cmock/public/script/1505557417.jmx")
        end
        render json: {'status':0,'msg':"后台执行"}, status:"200"
    end
    def jobSave
        if(params[:st_job_project_id].length == 0 || params[:tft_job_name].length == 0 )
            return
        end 
        @_t_job = TJob.new
        @_t_job.owner_user_id = "10000002"
        @_t_job.rule_ids =
            (!params[:data_rule_ids_list].nil?) ? 
                if(params[:data_rule_ids_list].length > 1) 
                    params[:data_rule_ids_list][1,params[:data_rule_ids_list].length]
                end
            : "nil"
        @_t_job.job_name = params[:tft_job_name]
        @_t_job.project_id = params[:st_job_project_id]
       # @_t_job.created_time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
        
        if @_t_job.save 
            redirect_to(:action => 'jobs')
         end
    end

    def rule
        _sql_ = "SELECT 
                    a.data_rule_id,a.data_rule_name,a.param_desc,a.data_from_api_system,
                    b.api_id,b.api_name,b.status
                FROM  t_data_rule a
                LEFT JOIN t_api b ON a.api_id = b.api_id
                WHERE a.status = 0
                ORDER BY a.updated_at";
        @_data_rules  = TDataRule.find_by_sql(_sql_)
        @_apiDetailInfo = Hash.new
        for line in @_data_rules
            _sql_2_ = "SELECT api_id,api_param,param_title FROM t_api_param_info WHERE api_id=#{line['api_id']} AND status=0"
            @_param_list  = TApiParamInfo.find_by_sql(_sql_2_)
            paramsList = "参数列表\n";
            if @_param_list.length > 0
                for line2 in @_param_list
                    paramsList = paramsList + line2.getApiParamName + " : " + line2.getApiParamTitle + "\n"
                end
                #logger.info(paramsList)
            else
                paramsList = paramsList  + "参数空！"
            end
            @_apiDetailInfo[line['api_id']] = paramsList.to_s
            
        end
         logger.info(@_apiDetailInfo)
    end

    def ruleDel
        @__data_rule = TDataRule.find(params[:_data_rule_id])
        @__data_rule['status'] = 1
        @__data_rule.save
        render json: "{'status':0,'errorMsg':'操作成功'}", status:"200"
    end
    def ruleAdd
        @projList = TProj.where(:status=>0).all
        @project_select_list = "<option value="">请选择</option>"
        for name in @projList
             @project_select_list = @project_select_list + "<option value=" + name.getProjId.to_s + ">"+name.getProjName+"</option>";
        end

        #@_sys_name_list = TApi.find_by_sql("SELECT api_sys_name FROM t_api WHERE status = 0 GROUP BY api_sys_name ")
        #@sys_select_list = "<option value="">请选择</option>"
        #for name in @_sys_name_list
        #     @sys_select_list = @sys_select_list + "<option value=" + name['api_sys_name'] + ">"+name['api_sys_name']+"</option>";
        #end
    end
    def getApiSystemNameList
        _sql_ = 'SELECT api_sys_name FROM t_api WHERE status = 0 and api_proj_id ="'+ params[:_sys_id] +'" GROUP BY api_sys_name ';
        @_sys_name_list = TApi.find_by_sql(_sql_)
        @sys_select_list = "<option value="">请选择</option>"
        for name in @_sys_name_list
             @sys_select_list = @sys_select_list + "<option value=" + name['api_sys_name'] + ">"+name['api_sys_name']+"</option>";
        end
        render json: {'status':0,'msg':"#{@sys_select_list}"}, status:"200"
    end
    def getApiNameList
        _sql_ = 'SELECT a.api_name,a.api_id FROM t_api a
                left join t_api_param_info b on a.api_id = b.api_id
                WHERE a.api_proj_id ="'+ params[:_sys_id] +'" and a.api_sys_name = "' + params[:_sys_name] + '" and a.status = 0 and b.status=0 group by a.api_id order by a.created_at'
        logger.info(_sql_)
        @_api_name_list = TApi.find_by_sql(_sql_)
        #logger.info(@_api_name_list)
        @api_select_list = "<option value="">请选择</option>"
        for name in @_api_name_list
            #logger.info(name['api_id'])
            @api_select_list = @api_select_list + "<option value=#{name['api_id']}>" + name['api_name'] + "</option>"
        end
        render json: {'status':0,'msg':"#{@api_select_list}"}, status:"200"
    end
    def getApiParamList
        _sql_ = 'SELECT api_id,api_param FROM t_api_param_info WHERE api_id = "' + params[:_api_id] + '" and status = 0 order by updated_at'
        @_api_param_list = TApiParamInfo.find_by_sql(_sql_)
        paramList = Array.new
        i = 0;
        for param in @_api_param_list
            paramList[i] = param.getApiParamName
            i = i+1
        end
        #logger.info(paramList.join(","));
        render json: {'status':0,'count':@_api_param_list.count,'msg':"#{paramList.join(",")}"}, status:"200"
    end
    def getDataRuleList
        @rules = TRule.where(:status=>0).all

    end
    def getRuleList
        @dataRules = TDataRule.where(:status=>0,:proj_id=>params[:_proj_id]).all
        @_data_rule_checkbox_list = "";
        @_data_rule_ids_list = ""
        for dataRule in @dataRules
            @_data_rule_checkbox_list = @_data_rule_checkbox_list + '<div class="checkbox">';
            @_data_rule_checkbox_list = @_data_rule_checkbox_list + '    <label style="word-wrap:break-word" name="dataRuleCheckBox_'+dataRule.getDataRuleId.to_s+'" >';
            @_data_rule_checkbox_list = @_data_rule_checkbox_list + '        <input type="checkbox" onclick="testmin.fn.toGetSelectRule('+dataRule.getDataRuleId.to_s+',this)" id="dataRuleCheckBox_'+dataRule.getDataRuleId.to_s+'" value="'+dataRule.getDataRuleName+'">'+dataRule.getDataRuleName;
            @_data_rule_checkbox_list = @_data_rule_checkbox_list + '    </label>';
            @_data_rule_checkbox_list = @_data_rule_checkbox_list + '</div>';

        end
       # @_data_rule_checkbox_list = @_data_rule_checkbox_list + '<input type="hidden" id="data_rule_ids_list" value="">';
        render json: {'status':0,'msg':"#{@_data_rule_checkbox_list}"}, status:"200"
    end 

    def ruleSave
        @_dataRule = TDataRule.new
        @_dataRule.cmock_user_id = "10000002"
        
        if(params[:tft_data_rule_name].length==0 || params[:st_api_id].length==0 || params[:st_system_id].length == 0)
           return
        end
        @_dataRule.data_rule_name = params[:tft_data_rule_name]
        @_dataRule.api_id = params[:st_api_id]
        @_dataRule.proj_id = params[:st_system_id]
        @_dataRule.data_from_api_system = (!params[:dataFromApiSystem].nil? &&!params[:dataFromApiSystem].empty?) ? params[:dataFromApiSystem] : "false";
        @param_desc = Hash.new;
        _param_list = (!params[:tft_data_rule_param_list].nil? && !params[:tft_data_rule_param_list].empty?) ? params[:tft_data_rule_param_list].split(",") : "";
        
        if(_param_list.count > 0)
            _param_list.each do |line|
                str = "@param_desc[line] = params[:tft_data_rule_param_#{line}]"
                eval(str)
            end
        end 

        logger.info(@param_desc.class)
        @_dataRule.param_desc = JSON.generate(@param_desc)
        @_dataRule.updated_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
        logger.info(params)
        if @_dataRule.save 
           redirect_to(:action => 'rule')
        end
    end

    def apiDataIsExist
        @_api_exist = TApiData.where(:api_id=>params[:_api_id],:status=>0).all
        if(@_api_exist.count > 0)
            render json: {'status':0,'msg':"存在测试数据"}, status:"200"
        else
            render json: {'status':1,'msg':"不存在源数据，请添加源数据后再设置规则！"}, status:"200"
        end
    end
end
