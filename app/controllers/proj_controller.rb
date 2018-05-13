class ProjController < ApplicationController


    def index
        @projList = TProj.where(:status=>0).all
        #@projApiCount = Array.new
        #for proj_li in @projList
        #logger.info(proj_li.getProjId)
        #logger.info(TApi.where(:api_proj_id=>proj_li.getProjId).all)
        #@projApiCount[proj_li.getProjId] = self.getApiCountByProjId(proj_li.getProjId)
        #end
    end

    def getApiCountByProjId(_proj_id)
        _count = TApi.find_by_sql(
            "SELECT *
            FROM  t_api a
            where a.api_proj_id=#{_proj_id} and a.status=0 ")
        return _count.count
    end

    def projAdd

    end
    def projDel
        @__proj = TProj.find(params[:_proj_id])
        @__proj['status'] = 1
        @__proj.save
        render json: "{'status':1,'errorMsg':'操作成功'}", status:"200"
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
        redirect_to(:action => 'index')
    end
  end
end
