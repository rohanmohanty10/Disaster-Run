  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Tween = require(PathShortcuts.ReplicatedModules.Petal)("Util").Tween;

return {
    Inherit = "Bike",
    ItemId = "MOUNT_39",
    Animator = "HitsugibuneAnimator",
    MovementProperties = {
        MAX_SPEED = 70,
        BACKWARD_MAX_SPEED = -20,
        MOTIONAL_ACCELERATION = 0.75,
        MOTIONAL_DECELERATION = 0.2
    },

    OnSetup = function(p1) -- Line: 30, Name: OnSetup
        -- upvalues: ParticleHandler (copy)
        for _, child in pairs(p1.Model.PrimaryPart:GetChildren()) do
            if child.Name == "Particles" then
                ParticleHandler.EnableAllParticles(child, false);
            end;
        end;

        p1.Model.PrimaryPart.Summon:Play();
        p1.Model.PrimaryPart.IdleLoop.Playing = true;
        p1.Model.PrimaryPart.MovementLoop.Playing = true;
    end,

    OnDestroy = function(p2) -- Line: 42, Name: OnDestroy
        p2.Character:FindFirstChild("HumanoidRootPart");
        p2.Model.PrimaryPart.Unsummon:Play();
    end,

    OnMove = function(u3, p4) -- Line: 50, Name: OnMove
        -- upvalues: Tween (copy), ParticleHandler (copy)
        local _ = u3.Model;
        local PrimaryPart = u3.Model.PrimaryPart;

        if u3.MovementLoop then
            u3.MovementLoop:Disconnect();
        end;

        if p4 then
            u3.MovementLoop = u3.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 61
                -- upvalues: u3 (copy), PrimaryPart (copy)
                PrimaryPart.MovementLoop.Volume = (Vector3.new(1, 0, 1) * u3.Character.HumanoidRootPart.Velocity).Magnitude / 40;
            end);
        end;

        if p4 then
            Tween(PrimaryPart.IdleLoop, 1, "Linear", "InOut", {
                Volume = 0.3
            });
            Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
                Volume = 1
            });
        else
            Tween(PrimaryPart.IdleLoop, 1, "Linear", "InOut", {
                Volume = 1.5
            });
            Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
                Volume = 0
            });
        end;

        u3.Model.PrimaryPart.Movement[p4 and "Play" or "Stop"](u3.Model.PrimaryPart.Movement);

        for _, child in pairs(u3.Model.PrimaryPart:GetChildren()) do
            if child.Name == "Particles" then
                ParticleHandler.EnableAllParticles(child, p4);
            end;
        end;

        local _ = p4 == true;
    end
};