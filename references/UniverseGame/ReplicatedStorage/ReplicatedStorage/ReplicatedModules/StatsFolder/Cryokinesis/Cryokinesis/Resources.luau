  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);

return {
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    Hit = {
        Name = "Output",
        Arguments = {
            "FX",
            "Shadow_Hit",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                Particle = PathShortcuts.ClientAssets.Universal.BloodVFX
            }
        }
    }
};