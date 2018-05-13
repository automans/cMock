class TDept < ApplicationRecord
  def getDeptId
    self.dept_id
  end
  def getDeptName
    self.dept_name
  end
  def getDeptPid
    self.dept_pid
  end
  def getDeptStatus
    self.status;
  end
  def getCreateTime
    self.updated_at
  end
  def getUpdateTime
    self.updated_at
  end

  def setDeptStatus(st)
    self.status = st;
  end
  validates_presence_of  :dept_name, :dept_pid
end
