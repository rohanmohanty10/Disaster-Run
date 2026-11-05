  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);
Random.new();

return function(p2) -- Line: 17
    -- upvalues: u1 (ref), AssetHandler (copy), TweenService (copy)
    local v3 = p2 or {};
    local Player = v3.Player;
    local HumanoidRootPart = Player.Character.HumanoidRootPart;
    local v4 = v3.Speed or 1;
    u1.CallEffect("Emit Particle V3", {
        AutoSerialize = true,
        Path = "Particles/Rankyaku/Release",
        Player = Player,
        Origin = HumanoidRootPart
    });
    local v5 = AssetHandler.GetAbilityData(Player);
    local v6 = AssetHandler.CloneAsset("Particles/Rankyaku/Slash", v5);
    v6.Parent = workspace.Effects;
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(1.5707963267948966, 0.6981317007977318, -1.5707963267948966);
    TweenService:Create(v6, TweenInfo.new(0.2 / v4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = v6.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
    }):Play();

    for _, descendant in v6:GetDescendants() do
        if descendant:IsA("Beam") then
            TweenService:Create(descendant, TweenInfo.new(0.2 / v4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;

    u1.Wait(0.5 / v4);
    v6:Destroy();
end;