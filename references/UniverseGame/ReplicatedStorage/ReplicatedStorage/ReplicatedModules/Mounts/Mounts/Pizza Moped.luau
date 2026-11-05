  

 

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
    Animator = "MopedAnimator",
    ItemId = "MOUNT_34",
    MovementProperties = {
        MAX_SPEED = 70,
        MOTIONAL_ACCELERATION = 1.25
    },

    OnSetup = function(p1) -- Line: 27, Name: OnSetup
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p1.Model.PizzaBox, false);
        p1.Model.PrimaryPart["Equip" .. math.random(1, 2)]:Play();
    end,

    OnMove = function(u2, p3) -- Line: 33, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(u2.Model.PizzaBox, p3);

        if u2.MovementLoop then
            u2.MovementLoop:Disconnect();
        end;

        if p3 then
            u2.Model.PrimaryPart.MovementStart:Play();
            u2.MovementLoop = u2.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 43
                -- upvalues: u2 (copy)
                u2.Model.PrimaryPart.Movement.Volume = (Vector3.new(1, 0, 1) * u2.Character.HumanoidRootPart.Velocity).Magnitude / 40;
            end);
        end;

        u2.Model.PrimaryPart.Movement.Playing = p3;
    end
};