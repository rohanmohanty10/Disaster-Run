 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Config = require(ReplicatedStorage.chrono).Config;
Config.SetConfig("CHECK_NEW_VERSION", false);
Config.SetConfig("REPLICATE_DEATHS", "NONE");
Config.SetConfig("MAX_SNAPSHOT_COUNT", 60);
Config.SetConfig("WARNING_SEVERITY", "MEDIUM");
Config.SetConfig("MIN_BUFFER", 0.05);
Config.RegisterEntityType(
    "PLAYER",
    {
        NAME = "PLAYER",
        MODEL_REPLICATION_MODE = "NATIVE",
        BUFFER = 0,
        HALF_TICK_DISTANCE = (1 / 0),
        TICK_RATE = 0.016666666666666666,
        ASSEMBLY_ROOT_PART_CHECK = true,
        FULL_ROTATION = true
    }
);

return {
    tickRate = 0.016666666666666666,
    sanityDistance = 28,
    sanitySpeedAllowance = 0.25,
    sanityMaxSpeed = 150,
    sanitySpeedWindow = 0.25,
    teleportJump = 10,
    teleportWindow = 0.5
};