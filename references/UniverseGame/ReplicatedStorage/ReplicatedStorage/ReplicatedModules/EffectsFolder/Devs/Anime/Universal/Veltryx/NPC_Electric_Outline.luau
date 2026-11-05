  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 14
    -- upvalues: AssetHandler (copy), TweenService (copy)
    local v2 = AssetHandler.CloneAsset("Models/Outline", {
        AbilityName = "Veltryx"
    });

    for _, child in v2:GetChildren() do
        child.Size = child.Size * 1.05;
        child.CFrame = p1[child.Name].CFrame;
        local ManualWeld = Instance.new("ManualWeld");
        ManualWeld.Part0 = child;
        ManualWeld.Part1 = p1[child.Name];
        ManualWeld.C0 = child.CFrame:ToObjectSpace(ManualWeld.Part1.CFrame);
        ManualWeld.Parent = child;
    end;

    v2.Parent = p1;
    task.delay(1, v2.Destroy, v2);

    for _, child in v2:GetChildren() do
        TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0.5), {
            Transparency = 1
        }):Play();
    end;
end;