  

 

return {
    RigModel = nil,
    Operations = {
        WeldModel = {
            Priority = 1,
            Type = "WeldModel",
            Model = "RigModel"
        },
        EditModel = {
            Priority = 2,
            Type = "EditModel",
            Model = "RigModel",
            Physics = {
                Anchored = false,
                Massless = true,
                CanCollide = false
            }
        },
        RigModel = {
            Priority = 3,
            Type = "Bind",
            Rig = "RigModel",
            TargetRig = "WorldParent",

            Callback = function(p1, p2, p3) -- Line: 25, Name: Callback
                p2.Size = p3.Size;
            end
        }
    }
};