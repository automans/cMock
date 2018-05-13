class TApiData < ApplicationRecord
  self.table_name ="t_api_data"
  self.primary_key = "api_id"

  def getApiDataStatus
    self.status
  end 
  def getApiDataUserId
    self.mock_user_id
  end 
  def getApiParamDataApiId
    self.api_id
  end

  def getApiParamDataCaseId
    self.case_id
  end

  def getApiParamDataResponseCode
    self.response_code
  end
  def getApiParamDataResponseMsg
    self.response_msg
  end
  def getApiParamDataRemarks
    self.remarks
  end
  def getApiParamDataUpdateTime
    self.updated_at
  end

 #validates_format_of  :case_id, :with => /[A-Z]/

end
