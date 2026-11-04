  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local FlowBalancing = require(ReplicatedStorage.FlowBalancing);
ReplicatedStorage.ChildAdded:Connect(function(p1) -- Line: 4
    -- upvalues: FlowBalancing (ref)
    if p1:IsA("ModuleScript") and p1.Name == "FlowBalancing" then
        FlowBalancing = require(p1);
    end;
end);

return function(p2: string) -- Line: 29
    -- upvalues: FlowBalancing (ref)
    return FlowBalancing[p2];
end;