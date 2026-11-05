  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local u1 = Knit.GetService("EffectService");
game:GetService("CollectionService");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsHandler);

return {
    Inherit = "Batbike",
    Animator = "BillowerAnimator",
    ItemId = "MOUNT_35",
    MovementProperties = {
        MAX_SPEED = 70,
        MOTIONAL_ACCELERATION = 1
    },

    OnSetup = function(p2) -- Line: 27, Name: OnSetup
        -- upvalues: ParticleHandler (copy), u1 (copy)
        ParticleHandler.EnableAllParticles(p2.Model.Body, false);
        ParticleHandler.EnableAllParticles(p2.Model.BikeRoot, false);
        task.delay(2, u1.FireAllClients, "Wheel Trails", p2.Character, { p2.Model.PrimaryPart.BikeControlBone.Wheels });
        p2.Model.PrimaryPart.Equip:Play();
    end,

    OnMove = function(p3, p4) -- Line: 39, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        p3.Model.PrimaryPart.MovementLoop.Playing = p4;
        p3.Model.PrimaryPart.MoveStart[p4 and "Play" or "Stop"](p3.Model.PrimaryPart.MoveStart);
        ParticleHandler.EnableAllParticles(p3.Model.Body, p4);
        ParticleHandler.EnableAllParticles(p3.Model.BikeRoot, p4);
    end
};