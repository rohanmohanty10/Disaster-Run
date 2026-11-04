 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local actionUtil = require(ReplicatedStorage.util.actionUtil);

return {
    bufferable = { "skill2" },

    statemachine = function(p1, p2) -- Line: 9, Name: statemachine
        -- upvalues: actionUtil (copy)
        if p2 == "baseAwaken" then
            local workspace = actionUtil.getworkspace();
            local Value = workspace.personWhoDisabled.Value;

            if workspace.disabledIsAwakening.Value and (actionUtil.is_disabled() and Value) then
                if Value:FindFirstChild("FlowCancel") then
                    print("Got flow cancel");

                    return Enum.TriStateBoolean.True, true;
                end;

                print("No flow cancel found");
            end;
        elseif table.find({ "dribble", "drib" }, p2) and (p1.character:FindFirstChild("movements") and p1.character.movements:FindFirstChild("stepovers_movement")) then
            return Enum.TriStateBoolean.True;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};