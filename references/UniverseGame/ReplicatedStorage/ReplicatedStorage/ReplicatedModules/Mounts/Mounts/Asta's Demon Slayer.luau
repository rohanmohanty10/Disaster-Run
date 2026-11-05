  

 

return {
    Inherit = "Hoverboard",
    ItemId = "MOUNT_31",

    OnSetup = function(p1) -- Line: 5, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
    end,

    OnMove = function(p2, p3) -- Line: 9, Name: OnMove
        p2.Model.PrimaryPart.Loop.Playing = p3;
    end
};