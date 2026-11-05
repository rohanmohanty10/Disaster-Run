  

 

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
    Inherit = "Batbike",
    Animator = "C90Animator",
    ItemId = "MOUNT_46",
    MovementProperties = {
        MAX_SPEED = 70,
        MOTIONAL_ACCELERATION = 1
    },

    OnSetup = function(p1) -- Line: 27, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.MovementLoop.Playing = true;
    end,

    OnMove = function(u2, p3) -- Line: 32, Name: OnMove
        -- upvalues: Tween (copy)
        local _ = u2.Model;
        local PrimaryPart = u2.Model.PrimaryPart;

        if u2.MovementLoop then
            u2.MovementLoop:Disconnect();
        end;

        if p3 then
            u2.MovementLoop = u2.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 41
                -- upvalues: u2 (copy), PrimaryPart (copy)
                PrimaryPart.MovementLoop.Volume = (Vector3.new(1, 0, 1) * u2.Character.HumanoidRootPart.Velocity).Magnitude / 40;
            end);
        end;

        if not p3 then
            Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
                Volume = 0
            });

            return;
        end;

        Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
            Volume = 1
        });
        PrimaryPart.Move:Play();
    end
};