  

 

local CollectionService = game:GetService("CollectionService");

return function(p1, p2) -- Line: 3
    -- upvalues: CollectionService (copy)
    local BodyVelocity = p2.BodyVelocity;
    local v3 = p2.Speed or 40;
    local HumanoidRootPart = p1.HumanoidRootPart;

    if not BodyVelocity then
        return;
    end;

    while BodyVelocity.Parent ~= nil and CollectionService:HasTag(p1, "BoxClientVelocity") do
        BodyVelocity.Velocity = HumanoidRootPart.CFrame.LookVector * v3;
        task.wait();
    end;
end;