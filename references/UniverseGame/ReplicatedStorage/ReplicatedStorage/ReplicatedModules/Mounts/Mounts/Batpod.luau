  

 

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
    Animator = "BatpodAnimator",
    ItemId = "MOUNT_36",
    MovementProperties = {
        MAX_SPEED = 75,
        FOV_SHIFT = 30,
        MOTIONAL_ACCELERATION = 1.75
    },

    OnSetup = function(p2) -- Line: 29, Name: OnSetup
        -- upvalues: ParticleHandler (copy), u1 (copy)
        local PrimaryPart = p2.Model.PrimaryPart;
        ParticleHandler.EnableAllParticles(PrimaryPart, false);
        PrimaryPart.Equip:Play();
        PrimaryPart.IdleLoop:Play();
        task.delay(2, u1.FireAllClients, "Wheel Trails", p2.Character, { PrimaryPart.BikeControlBone.BackTire, PrimaryPart.BikeControlBone.BikeHandleBone.FrontTire });
    end,

    OnMove = function(u3, p4) -- Line: 42, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(u3.Model.PrimaryPart, p4);
        u3.Model.PrimaryPart.MoveStart[p4 and "Play" or "Stop"](u3.Model.PrimaryPart.MoveStart);

        if u3.MovementLoop then
            u3.MovementLoop:Disconnect();
        end;

        if p4 then
            u3.MovementLoop = u3.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 52
                -- upvalues: u3 (copy)
                u3.Model.PrimaryPart.MovementLoop.Volume = (Vector3.new(1, 0, 1) * u3.Character.HumanoidRootPart.Velocity).Magnitude / 35;
            end);
        end;

        u3.Model.PrimaryPart.MovementLoop.Playing = p4;
    end
};