  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p1, p2) -- Line: 9
    -- upvalues: Trove (copy), TweenService (copy), RunService (copy)
    if not p1 then
        return;
    end;

    local STH_LockCrosshair = p1:FindFirstChild("STH_LockCrosshair");

    if STH_LockCrosshair then
        STH_LockCrosshair:Destroy();
    end;

    if p2 then
        return;
    end;

    local u3 = Trove.new();
    local HumanoidRootPart = p1.HumanoidRootPart;
    local v4 = script.LockCrosshair:Clone();
    v4.Name = "STH_LockCrosshair";
    v4.Parent = p1;
    v4.Adornee = HumanoidRootPart;
    local Icon = v4.Icon;
    Icon.Size = UDim2.fromScale(6, 6);
    Icon.ImageTransparency = 1;
    v4.Enabled = true;
    TweenService:Create(Icon, TweenInfo.new(0.275, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0,
        Size = UDim2.fromScale(1, 1)
    }):Play();
    u3:Connect(RunService.Heartbeat, function() -- Line: 37
        -- upvalues: Icon (copy)
        Icon.Rotation = -(tick() * 90 % 360);
    end);
    u3:AttachToInstance(p1);
    v4.Destroying:Once(function() -- Line: 42
        -- upvalues: u3 (copy)
        if u3 then
            u3:Destroy();
        end;
    end);
end;