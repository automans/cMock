class MemberController < ApplicationController

  protect_from_forgery :except => :roleDel
  protect_from_forgery :except => :userDel
  protect_from_forgery :except => :deptDel

  #protect_from_forgery :only => :index

  def user
    @userList  = TUser.find_by_sql(
      "SELECT a.user_id, a.user_login_id, a.user_passwd, a.user_name, a.dept_id, c.dept_name, a.role_id, b.role_name, a.sex, a.phone_no, a.status
          FROM  t_users a
          LEFT JOIN t_roles b on a.role_id = b.role_id
          LEFT JOIN t_depts c on a.dept_id = c.dept_id
          WHERE a.status=0
          ")
  end
  def dept
    @deptList = TDept.where(:status=>0).all
  end
  def role
    @roleList = TRole.where(:status=>0).all
  end
  def userDel
    @_user = TUser.find(params[:_user_id])
    @_user.setUserStatus(1);
   # @_user['status'] = 1
    if @_user.save
      render json: "{'status':0,'errorMsg':'操作成功'}", status:"200"
    else
      render json: "{'status':1,'errorMsg':'操作失败'}", status:"4001"
    end
  end
  def deptDel
    @_dept = TDept.find(params[:_dept_id])
    @_dept.setDeptStatus(1)
    #@_dept['status'] = 1
    if @_dept.save
      render json: "{'status':0,'errorMsg':'操作成功'}", status:"200"
    else
      render json: "{'status':1,'errorMsg':'操作失败'}", status:"4001"
    end
  end
  def roleDel
    @_role = TRole.find(params[:_role_id])
    @_role['status'] = 1
    logger.info(@_role);
    if @_role.save
      render json: "{'status':0,'errorMsg':'操作成功'}", status:"200"
    else
      render json: "{'status':1,'errorMsg':'操作失败'}", status:"4001"
    end
  end

  def userAdd
    @deptInfo = TDept.where(:status=>0).all
    @deptSelectList = "";
    for deptLi in @deptInfo
        #logger.info( deptLi.getDeptId)
        @deptSelectList += "<option value=#{deptLi.getDeptId}>#{deptLi.getDeptName}</option>"
    end
    @roleInfo = TRole.where(:status=>0).all
    @roleSelectList = "";
    for roleLi in @roleInfo
        @roleSelectList += "<option value=#{roleLi.getRoleId}>#{roleLi.getRoleName}</option>"
    end
      logger.info(@roleSelectList)
  end
  def userSave
      @_user = TUser.new
      @_user.user_login_id = params[:tft_user_login_id]
      @_user.user_passwd = params[:tft_user_login_passwd]
      @_user.user_name = params[:tft_login_user_name]
      @_user.dept_id = params[:st_user_dept_beloog_to]
      @_user.role_id = params[:st_user_role_beloog_to]
      @_user.sex = params[:st_user_sex_beloog_to]
      @_user.phone_no = params[:tft_login_user_phone]
      @_user.created_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
      @_user.updated_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
      if @_user.save
          redirect_to(:controller => "member",:action => "user")
      end 
  end

  def roleAdd
  end
  def roleSave
      @_role = TRole.new
      @_role.role_name = params[:tft_role_name]
      @_role.created_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
      @_role.updated_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
      if @_role.save
          redirect_to(:controller => "member",:action => "role")
      end 
  end 

  def deptAdd
    @deptInfo = TDept.where(:status=>0).all
    @deptSelectList = "";
    for deptLi in @deptInfo
        #logger.info( deptLi.getDeptId)
        @deptSelectList += "<option value=#{deptLi.getDeptId}>#{deptLi.getDeptName}</option>"
    end
  end

  def deptSave
      @_dept = TDept.new
      @_dept.dept_name = params[:tft_dept_name]
      @_dept.dept_pid = params[:st_dept_pid]
      @_dept.created_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
      @_dept.updated_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
      if @_dept.save
          redirect_to(:controller => "member",:action => "dept")
      end 
  end

end
