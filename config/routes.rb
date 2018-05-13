Rails.application.routes.draw do
  get 'welcome/index'
  root "welcome#index"

  #get "welcome", :to=>"welcome#index", :as=>"welcome"
  get 'monitor', :to=>"welcome#monitor", :as=>"monitor"
  get "home", :to=>"welcome#index"

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #For API
  get "api",  :to=>"api#index", :as=>"api"
  get "scripts", :to=>"api#scripts", :as=>"scripts"
  post "api/scriptSave"
  get "api/proj"
  get "api/face"
  #post "api/face"
  get "api/info"
  get "api/apiResult"
  get "api/dataEdit"
  get "api/paramEdit"
  #get "api/projAdd"
  #post "api/projSave"
  get "api/ifaceAdd"
  post "api/ifaceSave"
  post "api/apiParamSave"
  post "api/apiParamDataSave"
  post "api/projDel"
  post "api/scriptDel"
  post "api/projApiDel"
  post "api/paramDataDel"
  post "api/apiParamDel"
  get "api/testAjax"
  get "api/infoView"
  get "api/scriptAdd"
  post "api/scriptUpload"
  #proj
  get "proj", :to=>"proj#index", :as=>"proj"
  get "proj/projAdd"
  post "proj/projSave"

  #for sysmin
  get "sysmin", :to=>"sysmin#index", :as=>"sysmin"

  get "users", :to=>"sysmin#user", :as=>"users"
  get "depts", :to=>"sysmin#dept", :as=>"depts"
  get "roles", :to=>"sysmin#role", :as=>"roles"
  get "userAdd", :to=>"sysmin#userAdd", :as=>"userAdd"
  get "roleAdd", :to=>"sysmin#roleAdd", :as=>"roleAdd"
  get "deptAdd", :to=>"sysmin#deptAdd", :as=>"deptAdd"
  post "userSave", :to=>"sysmin#userSave", :as=>"userSave"
  post "roleSave", :to=>"sysmin#roleSave", :as=>"roleSave"
  post "deptSave", :to=>"sysmin#deptSave", :as=>"deptSave"
  post "sysmin/userDel"
  post "sysmin/deptDel"
  post "sysmin/roleDel"


  #for testmin
  get "testmin", :to=>"testmin#index", :as=>"testmin"
  get "jobs", :to=>"testmin#jobs", :as=>"jobs"
  get "rules", :to=>"testmin#rule", :as=>"rules"
  get "ruleAdd", :to=>"testmin#ruleAdd", :as=>"ruleAdd"
  get "jobAdd", :to=>"testmin#jobAdd", :as=>"jobAdd"
  post "testmin/ruleDel"
  post "testmin/execJobs"
  post "testmin/jobDel"
  post "testmin/apiDataIsExist"
  post "ruleSave", :to=>"testmin#ruleSave", :as=>"ruleSave"
  post "jobSave", :to=>"testmin#jobSave", :as=>"jobSave"
  post "testmin/getApiNameList"
  post "testmin/getApiSystemNameList"
  post "testmin/getApiParamList"
  get "testmin/getDataRuleList"
  post "testmin/getRuleList"
  
end
