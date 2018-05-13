class TDataRule < ApplicationRecord
    self.table_name ="t_data_rule"
    self.primary_key = "data_rule_id"

    def getDataRuleId
        self.data_rule_id
    end

    def getDataRuleName
        self.data_rule_name
    end

    def getDataRuleApiId
        self.api_id
    end

    def getDataRuleParamDesc
        self.param_desc
    end
    def getDataFromFlag
        self.data_from_api_system
    end 
    def getDataRuleProjId
        self.proj_id
    end 
end
