  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3) -- Line: 12
    -- upvalues: u1 (copy), AssetHandler (copy)
    local v4 = p3 or {};
    local Torso = p2:FindFirstChild("Torso");

    if not Torso then
        return;
    end;

    u1({
        IgnoreData = true,
        Character = p2,
        Particle = AssetHandler.GetAsset("Particles/LesserInversion", v4):Clone(),
        Origin = Torso.CFrame,
        SkinName = v4.SkinName
    });
end;