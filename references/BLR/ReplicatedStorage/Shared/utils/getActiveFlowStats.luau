  

game:GetService("ReplicatedStorage");
local getFlowData = require(script.Parent.getFlowData);
local u1 = {
    Stats = {}
};

return function(p2: userdata, p3: boolean) -- Line: 7, Name: getActiveFlowStats
    -- upvalues: getFlowData (copy), u1 (copy)
    if p2:FindFirstChild("PlayerStats") then
        if not (p2.PlayerStats.InFlow.Value or p3) then
            return nil, nil;
        end;

        local Value = p2.PlayerStats.Flow.Value;
        local v4 = getFlowData(Value);

        if v4 then
            return Value, v4;
        end;

        return Value, u1;
    end;
end;