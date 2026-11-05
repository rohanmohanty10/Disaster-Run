  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Kars = ReplicatedStorage:FindFirstChild("Client Assets").Kars;

return function(p1) -- Line: 7
    -- upvalues: Kars (copy), TweenService (copy)
    if p1 == nil then
        return;
    end;

    local HumanoidRootPart = p1.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    local v2 = Kars.Thrust:Clone();
    v2.Parent = workspace.Effects;
    task.delay(0.65, v2.Destroy, v2);

    for _, child in ipairs(v2:GetChildren()) do
        child.CFrame = HumanoidRootPart.CFrame;
        local v3 = TweenInfo.new(0.65, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
        local v4 = {
            Transparency = 1
        };
        local Angles = CFrame.Angles;
        local v5 = math.random(-180, 180);
        v4.CFrame = CFrame2 * Angles(0, math.rad(v5), 0) * CFrame.new(0, child.Size.Y / 1.5, 0);
        v4.Size = child.Size * 1.65;
        TweenService:Create(child, v3, v4):Play();
    end;
end;