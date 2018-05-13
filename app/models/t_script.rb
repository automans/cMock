class TScript < ApplicationRecord
    self.table_name ="t_script"
    self.primary_key = "id"

    def getScriptId
        self.id
    end
    def getSystemId
        self.system_id
    end

    def getScriptName
        self.script_name
    end
    def getScriptFile
        self.script_file
    end

    def getScriptFilePath
        self.file_path
    end
    def getDataFilePath
        self.data_file_path
    end 
    def getUserId
        self.cmock_user_id
    end
    def getCreateTime
        self.created_at
    end
    def getScriptLockFlag
        self.lock
    end 
    validates_presence_of  :script_name, :system_id, :script_file
end
