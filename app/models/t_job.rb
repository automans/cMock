class TJob < ApplicationRecord
    self.table_name ="t_jobs"
    self.primary_key = "job_id"

    def getJobId
        self.job_id
    end

    def getJobName
        self.job_name
    end

    def getJobRuleIds
        self.rule_ids
    end

    def getJobOwnerId
        self.owner_user_id
    end 

    def getLastExecUserId
        self.last_exec_user_id
    end

    def getLastExecTime
        self.last_exec_time
    end

    def getUpdatedTime
        self.updated_time
    end    

    def getProjectId
        self.project_id
    end 
end
