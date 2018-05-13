class TIdRule < ApplicationRecord
  self.table_name ="t_id_rule"
  self.primary_key = "id"

  def getProjNextId
    self.proj_id_next_num
  end

  def getApiNextId
    self.api_id_next_num
  end
end
