  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Hoverboard",
    Animator = "SubwayAnimator",
    ItemId = "MOUNT_20",
    MovementProperties = {
        MAX_SPEED = 75
    },

    OnSetup = function(p1) -- Line: 16, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.Music:Play();
    end,

    OnMove = function(p2, p3) -- Line: 21, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p2.Model, p3);
        p2.Model.PrimaryPart.MovementLoop.Playing = p3;
    end
};