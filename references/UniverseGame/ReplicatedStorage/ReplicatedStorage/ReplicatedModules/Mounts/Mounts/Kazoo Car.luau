  

 

return {
    Inherit = "Hoverboard",
    Animator = "NimbusAnimator",
    ItemId = "MOUNT_12",

    OnSetup = function(p1) -- Line: 7, Name: OnSetup
        p1.Model.Root.Music:Play();
    end,

    OnMove = function(p2) -- Line: 11, Name: OnMove
    end
};