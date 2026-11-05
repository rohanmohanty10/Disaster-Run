  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 4
    -- upvalues: u1 (copy), TweenService (copy)
    local v3;

    if p2 then
        v3 = p2:FindFirstChild("HumanoidRootPart") or p2.PrimaryPart;
        p2:FindFirstChild("Humanoid");
    else
        v3 = nil;
    end;

    local v4 = u1["Mero Mero"].Heart:Clone();
    v4.Anchored = true;
    v4.Size = Vector3.new();
    v4.CFrame = v3.CFrame * CFrame.new(0, -2.85, 0) * CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966);
    v4.Parent = workspace.Effects;
    TweenService:Create(v4, TweenInfo.new(0.25), {
        Size = Vector3.new(0, 50, 0.25)
    }):Play();
    wait(0.25);
    TweenService:Create(v4, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Size = Vector3.new(0, 50, 50)
    }):Play();
    wait(3);
    TweenService:Create(v4, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
        Size = Vector3.new(0, 50, 0.25)
    }):Play();
    wait(0.25);
    TweenService:Create(v4, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
        Size = Vector3.new()
    }):Play();
end;