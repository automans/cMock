class TApi < ApplicationRecord
  self.table_name ="t_api"
  self.primary_key="api_id"

  def getApiId
    self.api_id
  end
  def getApiName
    self.api_name
  end
  def getApiProjId
    self.api_proj_id
  end
  def getApiUrl
    self.api_url
  end
  def getApiSystemName
    self.api_sys_name
  end
  def getApiSamplerType
    self.api_sampler_type
  end
  def getApiProtocol
    self.api_protocol
  end
  def getApiRequestMethod
    self.api_request_method
  end
  def getApiUserId
    self.user_id
  end
  def getApiUserName
    self.user_name
  end
  def getApiLastExecTime
    self.last_exec_time
  end

  def getApiExecUserId
    self.exec_user_id
  end
  def getApiExecUserName
    self.exec_user_name
  end

  def getApiExecCount
    self.exec_count
  end
  def getApiExecStatus
    self.exec_status
  end
  def getApiExecPassCaseCount
    self.exec_pass_case_count
  end
  def getApiExecFailCaseCount
    self.exec_fail_case_count
  end
  def getApiSoapXmlDataTpl
    self.soap_request_tpl
  end
  def getApiLockFlag
    self.lock
  end 

  validates_presence_of  :api_name, :api_proj_id, :api_url, :api_sys_name, :api_protocol, :api_request_method, :api_sampler_type
  validates_length_of :api_name, :in => 0..64,:on => :create
  validates_length_of :api_proj_id, :in => 0..11,:on => :create
  validates_length_of :api_url, :in => 0..256 , :on => :create
  validates_length_of :api_sys_name, :in => 0..64 , :on => :create
  validates_length_of :api_protocol, :in => 0..10 , :on => :create
  validates_length_of :api_request_method, :in => 0..10, :on => :create
  validates_length_of :api_sampler_type, :in => 0..2, :on => :create

end
