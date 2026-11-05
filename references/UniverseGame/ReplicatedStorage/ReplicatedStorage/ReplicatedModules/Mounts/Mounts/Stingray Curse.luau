  

 

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
    Inherit = "Hoverboard",
    ItemId = "MOUNT_44",
    Animator = "StingrayAnimator",
    MovementProperties = {
        MAX_SPEED = 70,
        BACKWARD_MAX_SPEED = -20,
        MOTIONAL_ACCELERATION = 1,
        HOVER_HEIGHT = 5,
        MOTIONAL_DECELERATION = 0.5
    },

    OnSetup = function(p1) -- Line: 31, Name: OnSetup
        -- upvalues: Tween (copy)
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.AmbienceLoop.Playing = true;
        Tween(p1.Model.PrimaryPart.AmbienceLoop, 1, "Linear", "InOut", {
            Volume = 2
        });
    end,

    OnMove = function(p2, p3) -- Line: 37, Name: OnMove
        local _ = p2.Model;
        local PrimaryPart = p2.Model.PrimaryPart;

        if p3 then
            PrimaryPart.Movement:Play();
        end;
    end
};