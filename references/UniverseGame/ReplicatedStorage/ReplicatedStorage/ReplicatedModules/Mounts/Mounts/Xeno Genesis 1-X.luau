  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
game:GetService("CollectionService");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsHandler);

return {
    Inherit = "Batbike",
    Animator = "MotorcycleAnimator",
    ItemId = "MOUNT_21",
    MovementProperties = {
        MAX_SPEED = 90,
        FOV_SHIFT = 40,
        MOTIONAL_ACCELERATION = 1.85
    },

    OnSetup = function(p1) -- Line: 29, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.IdleLoop:Play();
    end,

    OnMove = function(u2, p3) -- Line: 34, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        local BikeControlBone = u2.Model.PrimaryPart.BikeControlBone;
        ParticleHandler.EnableAllParticles(BikeControlBone.Muffler, p3);
        ParticleHandler.EnableAllParticles(BikeControlBone.Attachment.WheelTrail, p3);
        ParticleHandler.EnableAllParticles(BikeControlBone.BikeHandleBone.WheelTrail, p3);
        local PrimaryPart = u2.Model.PrimaryPart;

        if u2.MovementLoop then
            u2.MovementLoop:Disconnect();
        end;

        if p3 then
            u2.MovementLoop = u2.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 51
                -- upvalues: u2 (copy), PrimaryPart (copy)
                PrimaryPart.MovementLoop.Volume = (Vector3.new(1, 0, 1) * u2.Character.HumanoidRootPart.Velocity).Magnitude / 45;
            end);
        end;

        PrimaryPart.MovementLoop.Playing = p3;
        u2.Model.PrimaryPart.Movement[p3 and "Play" or "Stop"](u2.Model.PrimaryPart.Movement);
    end
};