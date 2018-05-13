class TApiParamInfo < ApplicationRecord
  self.table_name ="t_api_param_info"
  self.primary_key = "api_id"

  def getApiParamTitle
    self.param_title
  end 
  def getApiId
    self.api_id
  end
  def getApiParamName
    self.api_param
  end
  def getApiParamMaxLength
    self.param_max_length
  end
  def getApiParamMinLength
    self.param_min_length
  end
  def getApiParamRequireFlag
    self.param_is_required
  end
  def getApiParamNumberFlag
    self.param_is_number
  end
  def getApiParamSpecialCharFlag
    self.param_allow_special_char
  end
  def getApiParamStatus
    self.status
  end
  def getApiParamCreateTime
    self.created_at
  end
  def getApiParamUpdateTime
    self.updated_at
  end
  def getApiParamValue
    self.param_value
  end
  def getApiParamUserId
    self.user_id
  end
  def getApiParamAliasName
    self.param_alias_name
  end

  validates_presence_of  :api_id, :param_alias_name, :api_param, :param_value,
                         :param_max_length, :param_min_length, :param_is_required, :param_is_number, :param_allow_special_char, :user_id
  validates_length_of :api_id, :in => 0..32,:on => :create
  validates_length_of :param_alias_name, :in => 0..32,:on => :create
  validates_length_of :api_param, :in => 0..32 , :on => :create
  validates_length_of :param_value, :in => 0..128 , :on => :create
  validates_length_of :param_max_length, :in => 0..5 , :on => :create
  validates_length_of :param_min_length, :in => 0..5, :on => :create
  validates_length_of :param_is_required, :in => 0..1, :on => :create
  validates_length_of :param_is_number, :in => 0..1, :on => :create
  validates_length_of :param_allow_special_char, :in => 0..1, :on => :create
  validates_length_of :user_id, :in => 0..11, :on => :create
end
