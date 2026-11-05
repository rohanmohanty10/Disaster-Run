  

 

local RunService = game:GetService("RunService");

return function(p1, p2, p3, p4) -- Line: 3
    -- upvalues: RunService (copy)
    local v5 = p1:Clone();
    v5.Parent = workspace.Effects;
    local v6 = 0;

    while v6 <= p4 do
        v5.CFrame = (p2 and p2.CFrame or CFrame.new()) * p3;
        v6 = v6 + RunService.RenderStepped:Wait();
    end;

    v5:Destroy();
end;