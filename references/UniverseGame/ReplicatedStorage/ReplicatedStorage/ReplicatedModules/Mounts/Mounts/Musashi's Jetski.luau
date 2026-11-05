  

 

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
    Inherit = "Bike",
    Animator = "JetskiAnimator",
    ItemId = "MOUNT_17",
    MovementProperties = {
        MAX_SPEED = 75,
        FOV_SHIFT = 30,
        MOTIONAL_ACCELERATION = 1.5
    },

    OnSetup = function(p1) -- Line: 29, Name: OnSetup
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p1.Model, false);
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.IdleLoop:Play();
    end,

    OnMove = function(u2, p3) -- Line: 36, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        if u2.MovementLoop then
            u2.MovementLoop:Disconnect();
        end;

        local PrimaryPart = u2.Model.PrimaryPart;

        if p3 then
            u2.MovementLoop = u2.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 44
                -- upvalues: u2 (copy), PrimaryPart (copy)
                PrimaryPart.MovementLoop.Volume = (Vector3.new(1, 0, 1) * u2.Character.HumanoidRootPart.Velocity).Magnitude / 75;
            end);
        end;

        ParticleHandler.EnableAllParticles(u2.Model, p3);
        u2.Model.PrimaryPart.MovementLoop.Playing = p3;
    end
};