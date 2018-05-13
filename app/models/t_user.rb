class TUser < ApplicationRecord
  def getUserId
    self.user_id
  end
  def getUserLoginId
    self.user_login_id
  end
  def getUserPasswd
    self.user_passwd
  end
  def getUserName
    self.user_name
  end
  def getUserDetpId
    self.dept_id
  end
  def getUserSex
    self.sex
  end
  def getUserStatus
    self.status
  end
  def getUserRole
    self.role_id
  end
  def getUserPhone
    self.phone_no
  end
  def getUserLastModifyTime
    self.update_time
  end
  def getUserDeptName
    self.dept_name
  end
  def getUserRoleName
    self.role_name
  end

  def setUserStatus(st)
    self.status = st
  end
  validates_presence_of  :user_login_id, :user_passwd, :user_name, :dept_id, :role_id, :phone_no
  validates_length_of :user_login_id, :in => 0..16,:on => :create
  validates_length_of :user_passwd, :in => 0..64,:on => :create
  validates_length_of :user_name, :in => 0..64 , :on => :create
  validates_length_of :dept_id, :in => 0..11 , :on => :create
  validates_length_of :role_id, :in => 0..11 , :on => :create
  validates_length_of :phone_no, :in => 0..16, :on => :create
end
