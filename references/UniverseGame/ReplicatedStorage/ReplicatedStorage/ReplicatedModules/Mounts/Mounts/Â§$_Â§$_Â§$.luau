  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local _ = require(PathShortcuts.ReplicatedModules.Petal)("Util").Tween;

return {
    Inherit = "Hoverboard",
    ItemId = "MOUNT_45",
    Animator = "NueAnimator",
    MovementProperties = {
        MAX_SPEED = 80,
        BACKWARD_MAX_SPEED = -40,
        MOTIONAL_ACCELERATION = 2,
        HOVER_HEIGHT = 9,
        MOTIONAL_DECELERATION = 1
    },

    OnSetup = function(p1) -- Line: 31, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.Loop.Playing = true;
    end,

    OnMove = function(p2, p3) -- Line: 36, Name: OnMove
    end
};