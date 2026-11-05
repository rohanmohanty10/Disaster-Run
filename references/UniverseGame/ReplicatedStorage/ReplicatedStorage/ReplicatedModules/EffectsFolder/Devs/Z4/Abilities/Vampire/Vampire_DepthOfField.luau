  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return function() -- Line: 9
    -- upvalues: Trove (copy), TweenService (copy)
    local v1 = Trove.new();
    local v2 = v1:Add(Instance.new("BlurEffect"));
    v2.Enabled = true;
    v2.Parent = game.Lighting;
    local v3 = v1:Add(Instance.new("DepthOfFieldEffect"));
    v3.Enabled = true;
    TweenService:Create(v2, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        Size = 10
    }):Play();
    TweenService:Create(v3, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        FarIntensity = 0,
        FocusDistance = 0,
        InFocusRadius = 0,
        NearIntensity = 0
    }):Play();
    task.delay(0.7, v1.Destroy, v1);
end;