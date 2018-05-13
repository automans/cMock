class TRule < ApplicationRecord
    self.table_name ="t_rule"
    self.primary_key = "rule_id"

    def getRuleId
        self.rule_id
    end

    def getRuleName
        self.rule_name
    end

    def getRuleCode
        self.rule_code
    end


end
