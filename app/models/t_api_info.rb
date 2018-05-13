class TApiInfo < ApplicationRecord
  self.table_name ="t_api_info"
  self.primary_key = "api_id"

  def getApiId
    self.api_id
  end
  def getApiName
    self.api_name
  end
  def getApiUrl
    self.api_url
  end
  def getApiRequestDataTpl
    self.request_data_tpl
  end
  def getUserId
    self.user_id
  end
  def getUserName
    self.user_name
  end
end
