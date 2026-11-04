 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);

return function(p1, p2) -- Line: 6
    -- upvalues: TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Highlight = Instance.new("Highlight", p2.Enemy);
    Highlight.Name = script.Name .. "Highlight";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = p2.Color;
    Highlight.OutlineColor = p2.Color;
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0.8;
    TweenService:Create(Highlight, TweenInfo.new(1.85 - v3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    VfxManager.DestroyEffect(Highlight, 1.85 - v3);
end;