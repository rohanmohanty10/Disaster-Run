  

 

local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Minecart",
    ItemId = "MOUNT_29",
    MovementProperties = {
        MAX_SPEED = 70,
        MOTIONAL_ACCELERATION = 1.2,
        CAMERA_LOCKED_MOUNT = false
    },

    OnSetup = function(p1) -- Line: 13, Name: OnSetup
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p1.Model, false);
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.Loop:Play();
    end,

    OnMove = function(p2, p3) -- Line: 20, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p2.Model, p3);
        p2.Model.PrimaryPart.Movement.Playing = p3;
    end
};