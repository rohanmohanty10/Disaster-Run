  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local ContentProvider = game:GetService("ContentProvider");

if game:GetService("RunService"):IsServer() then
    return function() -- Line: 8
    end;
end;

local _ = Players.LocalPlayer;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.Types);
local Trove = require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local u1 = Random.new();
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;
local LocalPlayer = Players.LocalPlayer;

local function _(p2, p3) -- Line: 36
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

local u4 = AnimationHandler.CreateAnimationById("Lab1", 137638972679792);
local u5 = AnimationHandler.CreateAnimationById("Lab2", 108237075549989);
task.spawn(function() -- Line: 43
    -- upvalues: ContentProvider (copy), u4 (copy), u5 (copy), AssetHandler (copy)
    ContentProvider:PreloadAsync({ u4, u5 });
    ContentProvider:PreloadAsync(AssetHandler.GetAsset("Universal/Interaction/Lab/Cutscene"):GetChildren());
    print("Preloaded");
end);

return function(p6, p7) -- Line: 52
    -- upvalues: u5 (copy), Trove (copy), LocalPlayer (copy), EffectsHandler (copy), AssetHandler (copy)
    local v8 = p6:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator"):LoadAnimation(u5);
    v8.Priority = Enum.AnimationPriority.Action4;
    local u9 = Trove.new();
    u9:AttachToInstance(p6);
    u9:Add(v8);
    LocalPlayer:SetAttribute("NoAmbienceMusic", true);
    u9:Add(function() -- Line: 63
        -- upvalues: LocalPlayer (ref)
        LocalPlayer:SetAttribute("NoAmbienceMusic", nil);
    end);
    u9:Add((EffectsHandler.CallEffect("Ambience Music", {
        Volume = 0.85,
        Sound = AssetHandler.GetAsset("Universal/Interaction/Lab/Cutscene/SFX"),
        TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    })));
    task.spawn(EffectsHandler.CallEffect, "C_CUTSCENECAMERA", {
        AbilityName = "Lab",
        AnimationName = "LabCutsceneCamera",
        AnimationId = 137638972679792,
        Bypass = true,
        FoVPropertyName = "MaxAxisFieldOfView",
        Character = p6,
        Origin = p7.Origin,
        MarkerEvents = {
            TransitionEnd = function() -- Line: 86
                -- upvalues: EffectsHandler (ref), u9 (copy)
                EffectsHandler.CallEffect("BlackScreen", 0.5, 0.75);
                u9:Destroy();
            end
        }
    });
    v8:Play(0.1);
    v8.Stopped:Wait();
end;