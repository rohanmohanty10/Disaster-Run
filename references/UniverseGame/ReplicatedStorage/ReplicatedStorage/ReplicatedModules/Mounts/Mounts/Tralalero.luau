  

 

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
    ItemId = "MOUNT_54",
    Animator = "TralaleroAnimator",
    MovementProperties = {
        MAX_SPEED = 70,
        BACKWARD_MAX_SPEED = -20,
        MOTIONAL_ACCELERATION = 0.75,
        MOTIONAL_DECELERATION = 0.2
    },

    OnSetup = function(p1) -- Line: 30, Name: OnSetup
        p1.Character:FindFirstChild("HumanoidRootPart");
        local _ = p1.Model.PrimaryPart;
        p1.Model.PrimaryPart.Summon:Play();
        p1.Model.PrimaryPart.MovementLoop.Playing = true;
        p1.Model.PrimaryPart.MovementMusic.Playing = true;
    end,

    OnDestroy = function(p2) -- Line: 40, Name: OnDestroy
        p2.Character:FindFirstChild("HumanoidRootPart");
        local _ = p2.Model.PrimaryPart;
    end,

    OnMove = function(u3, p4) -- Line: 48, Name: OnMove
        -- upvalues: ParticleHandler (copy), Tween (copy)
        local _ = u3.Model;
        local PrimaryPart = u3.Model.PrimaryPart;

        if u3.MovementLoop then
            u3.MovementLoop:Disconnect();
        end;

        if u3.MovementMusic then
            u3.MovementMusic:Disconnect();
        end;

        if p4 then
            u3.MovementLoop = u3.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 62
                -- upvalues: u3 (copy), PrimaryPart (copy)
                local Magnitude = (Vector3.new(1, 0, 1) * u3.Character.HumanoidRootPart.Velocity).Magnitude;
                PrimaryPart.MovementLoop.Volume = Magnitude / 40;
                PrimaryPart.MovementMusic.Volume = Magnitude / 40;
            end);
        end;

        if p4 then
            PrimaryPart.MovementInit:Play();
        end;

        ParticleHandler.EnableAllParticles(u3.Model, p4);
        Tween(PrimaryPart.MovementMusic, 1, "Linear", "InOut", {
            Volume = p4 and 1 or 0
        });
        Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
            Volume = p4 and 1 or 0
        });
    end
};