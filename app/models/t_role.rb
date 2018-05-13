class TRole < ApplicationRecord
  def getRoleName
    self.role_name
  end
  def getRolestatus
    self.status
  end
  def getRoleId
    self.role_id
  end
  def getRoleCreateTime
    self.created_at
  end
  def getRoleUpdateTime
    self.updated_at
  end

  def setRoleStatus(st)
    self.status = st
  end

  validates_presence_of  :role_name
end
