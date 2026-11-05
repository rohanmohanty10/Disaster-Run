  

 

local v1 = game:GetService("RunService"):IsClient() and "Client" or "Server";
local Services = game.ReplicatedStorage:WaitForChild("ReplicatedRoot").Services;
local v2 = game:GetService("RunService"):IsServer() and game.ServerStorage:WaitForChild("ServerRoot").Services;
local v3;

if v1 == "Server" then
    v3 = game.ServerScriptService:WaitForChild("ServerLibrary");
else
    v3 = false;
end;

local ReplicatedModules = game.ReplicatedStorage:WaitForChild("ReplicatedModules");
local v4 = v3 and v3.PathShortcuts or (ReplicatedModules and ReplicatedModules.PathShortcuts or nil);
local v5 = v4 and require(v4) or nil;

return {
    Knit = {
        Services = v1 == "Server" and ({
            PingService = v2.PingService,
            TagService = Services.TagService
        } or {}) or {},
        Controllers = v1 == "Client" and ({
            PingController = Services.PingController,
            CombatController = Services.CombatService
        } or {}) or {}
    },
    Middleware = {
        Services = v1 == "Server" and ({
            CombatService = v2.CombatService,
            HandlerService = Services.HandlerService
        } or {}) or {},
        Controllers = v1 == "Client" and ({
            CombatService = Services.CombatService
        } or {}) or {}
    },
    PathShortcuts = v5,
    Flags = {
        UseNewHitboxSystem = true,
        UseNewTagService = true,
        UseNewTimescale = true,
        UseNewActionable = true,
        UseNewMeter = true,
        TimestopUsesNewTimescale = true,
        PerfectBlockRework = false,
        CompensationUsesRegulateByDefault = false,
        UseNewMovesetUI = true
    }
};