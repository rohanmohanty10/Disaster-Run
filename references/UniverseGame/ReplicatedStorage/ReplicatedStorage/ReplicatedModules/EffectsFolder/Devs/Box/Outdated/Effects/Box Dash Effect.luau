  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(p2) -- Line: 2
    -- upvalues: u1 (copy)
    local v3;

    if p2 then
        v3 = p2:FindFirstChild("HumanoidRootPart") or p2.PrimaryPart;
        p2:FindFirstChild("Humanoid");
    else
        v3 = nil;
    end;

    for _ = 1, math.random(7, 10) do

    end;

    local v4 = u1.Ring:Clone();
    v4.CFrame = v3.CFrame;
    v4.Parent = workspace.Effects;
end;