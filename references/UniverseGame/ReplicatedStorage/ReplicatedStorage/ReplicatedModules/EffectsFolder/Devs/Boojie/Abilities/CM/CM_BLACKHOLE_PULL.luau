  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = PathShortcuts.ClientAssets;
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3) -- Line: 13
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy)
    local v4 = p3 or {};
    local u5 = AssetHandler.GetAsset("Particles/BlackholePull", v4):Clone();
    ParticleHandler.Unusualify(u5, {
        Character = v4.Character
    });
    u5.CFrame = p2;
    u5.Parent = game.Workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = u5,
        SkinName = v4.SkinName
    });
    task.delay(3, function() -- Line: 28
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);
end;