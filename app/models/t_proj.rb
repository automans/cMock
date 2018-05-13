class TProj < ApplicationRecord
  self.primary_key="proj_id"
  
  def getProjId
    self.proj_id;
  end

  def getProjName
    self.proj_name
  end

  def getProjCode
    self.proj_code
  end

  def getProjCreateTime
    self.proj_created_at
  end

  def getProjUpdateTime
    self.proj_updated_at
  end

  def getProjLastExecTime
    self.proj_last_exec_time
  end

  def getProjExecCount
    self.proj_exec_count
  end

  def getProjStage
    self.proj_stage
  end

  def getProjUrl
    self.proj_url
  end

  def getProjUserId
    self.user_id
  end

  def getProjUserName
    self.user_name
  end

  validates_presence_of :proj_name, :proj_code, :proj_url
  validates_length_of :proj_name, :in => 1..256,:on => :create
  validates_length_of :proj_name, :in => 1..256,:on => :save
  validates_length_of :proj_name, :in => 1..256,:on => :update
  validates_length_of :proj_code, :in => 1..32 , :on => :create
  validates_length_of :proj_code, :in => 1..32 , :on => :save
  validates_length_of :proj_code, :in => 1..32 , :on => :update
  validates_length_of :proj_url, :in => 1..128, :on => :create
  validates_length_of :proj_url, :in => 1..128, :on => :save
  validates_length_of :proj_url, :in => 1..128, :on => :update
=begin
  validates_uniqueness_of :proj_id, :on => :create
  #validates_confirmation_of :password

  validates_length_of :proj_code, :within => 5..40 , :on => :create
  validates_length_of :proj_stage,:within => 1..2, :on => :create
  validates_length_of :proj_url, :within => 2..200, :on => :create
=end

end
