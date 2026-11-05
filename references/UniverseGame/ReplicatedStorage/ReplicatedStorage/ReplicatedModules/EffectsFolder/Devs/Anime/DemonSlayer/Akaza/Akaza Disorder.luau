  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local Player = p1.Player;
    local Character = p1.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v2 = AssetHandler.GetAbilityData(Player);
    local v3 = AssetHandler.CloneAsset("Particles/Disorder/Barrage", v2);
    ParticleHandler.Unusualify(v3, {
        Player = Player
    });
    v3.Parent = HumanoidRootPart;
    ParticleHandler.AttachTo(v3, {
        Part = HumanoidRootPart
    });
    ParticleHandler.Emit(v3, ParticleHandler.GenerateEmitInfo(v3));
    ParticleHandler.EnableAllParticles(v3, true);

    repeat
        local v4 = HumanoidRootPart.CFrame * CFrame.new(math.random(-2, 2), math.random(-2, 2), math.random(-5, -3));
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Disorder/RandomImpact",
            BypassRenderCap = true,
            Player = Player,
            Origin = v4
        });
        EffectsHandler.CallEffect("Mesh Emit", {
            Effect = "Akaza Disorder Barrage Hit",
            Origin = v4 * CFrame.new(0, 0, 2)
        });
        EffectsHandler.Wait(0.02);
    until HumanoidRootPart.Parent == nil or not Character:GetAttribute("Disorder");

    ParticleHandler.EnableAllParticles(v3, false);
    ParticleHandler.DestroyEmit(v3);
end;