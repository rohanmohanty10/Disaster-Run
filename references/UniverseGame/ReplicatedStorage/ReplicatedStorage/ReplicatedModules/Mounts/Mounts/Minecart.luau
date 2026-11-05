  

 

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
    Animator = "MinecartAnimator",
    ItemId = "MOUNT_26",
    MovementProperties = {
        CAMERA_LOCKED_MOUNT = true
    },

    OnSetup = function(p1) -- Line: 25, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
    end,

    OnMove = function(p2, p3) -- Line: 29, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p2.Model.PrimaryPart.Movement, p3);
        p2.Model.PrimaryPart.MovementSFX.Playing = p3;
    end
};