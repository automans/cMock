class JmeterScriptLib

    def initialize()
        @_script = '<?xml version="1.0" encoding="UTF-8"?>'
    end

    def init
        "this is jmeter script lib init file"
    end

    def script_End(_script_body)
        @_script << '<jmeterTestPlan version="1.2" properties="3.2" jmeter="3.2 r1790748">'
        @_script << _script_body
        @_script << '</jmeterTestPlan>'
    end

    def echoScript
        return @_script
    end 
end