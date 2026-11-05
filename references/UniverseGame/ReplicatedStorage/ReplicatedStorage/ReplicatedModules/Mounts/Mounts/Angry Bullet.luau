  

 

local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Nimbus",
    ItemId = "MOUNT_28",
    Animator = "BulletAnimator",
    MovementProperties = {
        MAX_SPEED = 72
    },

    OnSetup = function(p1) -- Line: 12, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
    end,

    OnMove = function(p2, p3) -- Line: 16, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        ParticleHandler.EnableAllParticles(p2.Model.PrimaryPart.Movement, p3);
        ParticleHandler.EnableAllParticles(p2.Model.PrimaryPart.Trails, p3);

        if p3 == true then
            ParticleHandler.Emit(p2.Model.PrimaryPart.ImpactBurst, ParticleHandler.GenerateEmitInfo(p2.Model.PrimaryPart.ImpactBurst));
        end;

        p2.Model.PrimaryPart.MovementSFX.Playing = p3;
        p2.Model.PrimaryPart.MovementLoop.Playing = p3;
    end
};