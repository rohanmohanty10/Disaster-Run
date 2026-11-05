  

 

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Tween = require(PathShortcuts.ReplicatedModules.Petal)("Util").Tween;
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 14
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
Random.new();

return {
    Type = "Hoverboard",
    Animator = "FishboneAnimator",
    Inherit = "Hoverboard",
    ItemId = "MOUNT_53",
    MovementProperties = {
        MAX_SPEED = 75,
        BACKWARD_MAX_SPEED = -20,
        MOTIONAL_ACCELERATION = 1,
        HOVER_HEIGHT = 6.25,
        MOTIONAL_DECELERATION = 0.25,
        SURFACECAST_WORLD_OFFSET = Vector3.new(0, 2.25, 0)
    },

    OnSetup = function(p2) -- Line: 32, Name: OnSetup
        p2.Model.PrimaryPart.Summon:Play();
        p2.Model.PrimaryPart["SummonVoiceline" .. math.random(1, 3)]:Play();
        p2.Model.PrimaryPart.MovementMusic.Playing = true;
        p2.Model.PrimaryPart.IdleLoop.Playing = true;
        p2.Model.PrimaryPart.MovementLoop.Playing = true;
    end,

    OnMove = function(u3, p4) -- Line: 40, Name: OnMove
        -- upvalues: Tween (copy)
        local _ = u3.Model;
        local PrimaryPart = u3.Model.PrimaryPart;

        if u3.MovementLoop then
            u3.MovementLoop:Disconnect();
        end;

        if p4 then
            u3.Model.PrimaryPart["MovementVoiceline" .. math.random(1, 3)]:Play();
        end;

        if p4 then
            PrimaryPart.Move:Play();
            u3.MovementLoop = u3.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 53
                -- upvalues: u3 (copy), PrimaryPart (copy)
                local Magnitude = (Vector3.new(1, 0, 1) * u3.Character.HumanoidRootPart.Velocity).Magnitude;
                PrimaryPart.MovementLoop.Volume = Magnitude / 40;
                PrimaryPart.MovementMusic.Volume = Magnitude / 40;
            end);
        end;

        Tween(PrimaryPart.IdleLoop, 1, "Linear", "InOut", {
            Volume = p4 and 0 or 2
        });
        Tween(PrimaryPart.MovementMusic, 1, "Linear", "InOut", {
            Volume = p4 and 2 or 0
        });
        Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
            Volume = p4 and 2 or 0
        });
    end
};