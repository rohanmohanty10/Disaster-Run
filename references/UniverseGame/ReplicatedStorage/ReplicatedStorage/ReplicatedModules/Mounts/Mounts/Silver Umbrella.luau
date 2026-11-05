  

 

local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Hoverboard",
    Animator = "UmbrellaAnimator",
    ItemId = "MOUNT_24",
    MovementProperties = {
        MAX_SPEED = 65,
        HOVER_INFLUENCE = 2.5
    },

    OnSetup = function(p1) -- Line: 14, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
    end,

    OnMove = function(p2, p3) -- Line: 20, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        p2.Model.PrimaryPart.MovementLoop.Playing = p3;
        ParticleHandler.EnableAllParticles(p2.Model.PrimaryPart.Movement, p3);
    end
};