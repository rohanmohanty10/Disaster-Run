  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Bike",
    ItemId = "MOUNT_32",
    Animator = "StrikerAnimator",
    MovementProperties = {
        MAX_SPEED = 70,
        BACKWARD_MAX_SPEED = -20,
        MOTIONAL_ACCELERATION = 0.75,
        MOTIONAL_DECELERATION = 0.2
    },

    OnSetup = function(p1) -- Line: 28, Name: OnSetup
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p1.Model, false);
        p1.Model.PrimaryPart.Equip:Play();
    end,

    OnMove = function(p2, p3) -- Line: 35, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p2.Model, p3);

        if p3 == true then
            p2.Model.PrimaryPart.MoveStart:Play();
            ParticleHandler.Emit(p2.Model.Particles.ImpactBurst, ParticleHandler.GenerateEmitInfo(p2.Model.Particles.ImpactBurst));
        end;

        p2.Model.PrimaryPart.MovementLoop.Playing = p3;
    end
};