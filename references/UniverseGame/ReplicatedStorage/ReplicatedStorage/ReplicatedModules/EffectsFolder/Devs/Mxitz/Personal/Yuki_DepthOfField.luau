  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);

return function(p1) -- Line: 23
    -- upvalues: TableUtil (copy), TweenService (copy), Lighting (copy)
    local v2 = TableUtil.Reconcile(p1 or {}, {
        LifeTime = 0.3,
        FarIntensity = 0.75,
        FocusDistance = 0.05,
        InFocusRadius = 10,
        NearIntensity = 0.75,
        TweenIn = { 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
        TweenOut = { 0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut }
    });
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    TweenService:Create(DepthOfFieldEffect, TweenInfo.new(unpack(v2.TweenIn)), {
        FarIntensity = v2.FarIntensity,
        FocusDistance = v2.FocusDistance,
        InFocusRadius = v2.InFocusRadius,
        NearIntensity = v2.NearIntensity
    }):Play();
    DepthOfFieldEffect.Parent = Lighting;
    task.wait(v2.LifeTime);
    TweenService:Create(DepthOfFieldEffect, TweenInfo.new(unpack(v2.TweenOut)), {
        FarIntensity = 0,
        FocusDistance = 0,
        InFocusRadius = 0,
        NearIntensity = 0
    }):Play();
    task.delay(v2.TweenOut[1] + 0.1, DepthOfFieldEffect.Destroy, DepthOfFieldEffect);
    table.clear(v2);
    table.freeze({});
end;