  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Minecart",
    ItemId = "MOUNT_30",
    MovementProperties = {
        CAMERA_LOCKED_MOUNT = false
    },

    OnSetup = function(p1) -- Line: 22, Name: OnSetup
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p1.Model.PrimaryPart.Beams, false);
        ParticleHandler.EnableAllParticles(p1.Model.PrimaryPart.Particles, false);
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.Loop:Play();
    end,

    OnMove = function(p2, p3) -- Line: 30, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p2.Model.PrimaryPart.Beams, p3);
        ParticleHandler.EnableAllParticles(p2.Model.PrimaryPart.Particles, p3);
        p2.Model.PrimaryPart.MovementStart[p3 and "Play" or "Stop"](p2.Model.PrimaryPart.MovementStart);
    end
};