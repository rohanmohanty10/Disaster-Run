 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local actionUtil = require(ReplicatedStorage.util.actionUtil);

return {
    statemachine = function(p1, p2) -- Line: 7, Name: statemachine
        -- upvalues: actionUtil (copy)
        if p2 == "skill5" and actionUtil.is_disabled() then
            local Value = actionUtil.getworkspace().personWhoDisabled.Value;

            if Value and Value ~= p1.character then
                return Enum.TriStateBoolean.True, true;
            end;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};