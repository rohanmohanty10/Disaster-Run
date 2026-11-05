  

 

local PathShortcuts = require(game:GetService("ReplicatedStorage").ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 7
    -- upvalues: ParticleHandler (copy), TweenService (copy)
    local v3 = game:GetService("ReplicatedStorage")["Client Assets"].Yasuo.Cut:Clone();
    local v4 = ParticleHandler.GetUnusualHSVData({
        Character = p2
    });

    if v4 ~= nil then
        v3.Color = ParticleHandler.HSVShift(v3.Color, v4);
    end;

    local Size = v3.Size;
    v3.Size = Vector3.new();
    v3.CFrame = p1 * CFrame.new(0, 0, -Size.Z);
    v3.Parent = workspace.Effects;
    local v5 = TweenService:Create(v3, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
        Size = Size,
        CFrame = p1
    });
    v5:Play();
    v5.Completed:Wait();
    TweenService:Create(v3, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        Transparency = 1
    }):Play();
    game:GetService("Debris"):AddItem(v3, 0.5);
end;