  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Tween = require(PathShortcuts.ReplicatedModules.Petal)("Util").Tween;

return {
    Inherit = "Bike",
    Animator = "TotalityAnimator",
    ItemId = "MOUNT_42",
    MovementProperties = {
        MAX_SPEED = 75,
        CAMERA_LOCKED_MOUNT = 2,
        MOTIONAL_ACCELERATION = 3,
        MOTIONAL_DECELERATION = 7
    },

    OnSetup = function(p1) -- Line: 32, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.IdleLoop.Playing = true;
        p1.Model.PrimaryPart.MovementLoop.Playing = true;
        p1.Model.PrimaryPart.AmbienceLoop.Playing = true;
    end,

    OnMove = function(u2, p3) -- Line: 39, Name: OnMove
        -- upvalues: Tween (copy)
        local _ = u2.Model;
        local PrimaryPart = u2.Model.PrimaryPart;

        if u2.MovementLoop then
            u2.MovementLoop:Disconnect();
        end;

        if p3 then
            u2.MovementLoop = u2.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 48
                -- upvalues: u2 (copy), PrimaryPart (copy)
                local Magnitude = (Vector3.new(1, 0, 1) * u2.Character.HumanoidRootPart.Velocity).Magnitude;
                PrimaryPart.MovementLoop.Volume = Magnitude / 40;
                PrimaryPart.AmbienceLoop.Volume = Magnitude / 40;
            end);
        end;

        if p3 then
            PrimaryPart.Move:Play();
        end;

        Tween(PrimaryPart.IdleLoop, 1, "Linear", "InOut", {
            Volume = p3 and 0 or 2
        });
        Tween(PrimaryPart.AmbienceLoop, 1, "Linear", "InOut", {
            Volume = p3 and 2 or 0
        });
        Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
            Volume = p3 and 2 or 0
        });
    end
};