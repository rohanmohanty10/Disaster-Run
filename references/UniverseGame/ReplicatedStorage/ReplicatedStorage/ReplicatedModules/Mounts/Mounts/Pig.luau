  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local u1 = Knit.GetService("EffectService");
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Minecart",
    Animator = "PigAnimator",
    ItemId = "MOUNT_33",
    MovementProperties = {
        CAMERA_LOCKED_MOUNT = false
    },

    OnSetup = function(p2) -- Line: 23, Name: OnSetup
        -- upvalues: u1 (copy)
        u1.FireAllClients("PigInstructor", p2.Character, -1);
        p2.Model.PrimaryPart["Equip" .. math.random(1, 3)]:Play();
    end,

    OnMove = function(p3, p4) -- Line: 29, Name: OnMove
        p3.Model.PrimaryPart.MovementLoop.Playing = p4;
    end
};