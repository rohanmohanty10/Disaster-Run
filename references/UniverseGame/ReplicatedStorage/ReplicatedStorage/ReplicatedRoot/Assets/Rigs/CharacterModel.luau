  

 

return {
    Name = "CharacterModel",
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
        BindModel = {
            Priority = 3,
            Type = "Bind",
            Rig = "RigModel",
            TargetRig = "WorldParent"
        }
    }
};