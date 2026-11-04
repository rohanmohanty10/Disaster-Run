 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local actionUtil = require(ReplicatedStorage.util.actionUtil);

return {
    bufferable = { "skill4" },

    statemachine = function(p1, p2) -- Line: 9, Name: statemachine
        -- upvalues: actionUtil (copy)
        if p2 == "baseAwaken" and p1.character:GetAttribute("rebel") then
            local workspace = actionUtil.getworkspace();
            local Value = workspace.personWhoDisabled.Value;

            if workspace.disabledIsAwakening.Value and (actionUtil.is_disabled() and (Value and Value:FindFirstChild("FlowCancel"))) then
                return Enum.TriStateBoolean.True, true;
            end;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};