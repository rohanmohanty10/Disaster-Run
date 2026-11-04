 

 

local u1 = {
    TickRate = 0.05,
    ViewReportSeconds = 0.5
};
local u2 = nil;

function u1.start() -- Line: 9
    -- upvalues: u2 (ref), u1 (copy)
    if u2 ~= nil then
        return u2 or nil;
    end;

    u2 = false;

    if not require(game.ReplicatedFirst:WaitForChild("FFlags")).Chrono then
        return nil;
    end;

    local chrono = require(game.ReplicatedStorage:WaitForChild("chrono"));
    local Config = chrono.Config;
    Config.SetConfig("CHECK_NEW_VERSION", false);
    Config.SetConfig("WARNING_SEVERITY", "HIGH");
    Config.SetConfig("REPLICATE_DEATHS", "NONE");
    Config.SetConfig("PLAYER_REPLICATION", "AUTOMATIC");
    Config.RegisterEntityType("PLAYER", {
        NAME = "PLAYER",
        MODEL_REPLICATION_MODE = "NATIVE",
        BUFFER = 0,
        HALF_TICK_DISTANCE = (1 / 0),
        ASSEMBLY_ROOT_PART_CHECK = true,
        STORE_SNAPSHOTS = true,
        TICK_RATE = u1.TickRate
    });
    chrono.Start();
    u2 = chrono;

    return chrono;
end;

return u1;