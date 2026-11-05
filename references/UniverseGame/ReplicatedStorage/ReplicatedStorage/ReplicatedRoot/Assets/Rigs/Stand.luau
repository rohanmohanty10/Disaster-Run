  

 

return {
    RigModel = script.Stand,
    Operations = {
        CreateStandJoint = {
            Priority = 1,
            Type = "CreateJoint",
            ClassName = "Motor6D",
            Name = "StandJoint",
            Part0 = "WorldParent/HumanoidRootPart",
            Part1 = "RigModel/StandHumanoidRootPart"
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
        }
    }
};