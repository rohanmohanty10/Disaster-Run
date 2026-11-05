  

 

return {
    Inherit = "Hoverboard",
    Animator = "PodAnimator",
    ItemId = "MOUNT_8",
    MovementProperties = {
        MAX_SPEED = 65
    },

    OnSetup = function(p1) -- Line: 11, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.IdleLoop:Play();
    end,

    OnMove = function(p2, p3) -- Line: 16, Name: OnMove
        p2.Model.PrimaryPart.MovementLoop.Playing = p3;
    end
};