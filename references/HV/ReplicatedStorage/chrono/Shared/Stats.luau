 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Config = require(script.Parent.Config);
local Entity = require(script.Parent.Entity);
local Holder = require(script.Parent.Holder);
require(script.Parent.Types);
local u1 = {
    REPLICATE_PERMISSIONS = {},
    CLIENT = {
        _PAUSE = false,
        TOTAL_ENTITIES_CULLED = 0,
        ENTITIES_MOVED_THIS_FRAME = 0,
        TOTAL_CLIENT_ENTITIES_CHECKED_THIS_FRAME = 0,
        TOTAL_CLIENT_ENTITIES = 0,
        AVG_INTERPOLATION_TIME_MS = 0,
        BYTES_RECEIVED_PER_SEC = 0,
        NEW_ENTITIES_PER_SEC = 0,
        ENTITY_CHANGES_PER_SEC = 0,
        ENTITY_REMOVALS_PER_SEC = 0,
        CLIENT_ENTITIES = {}
    },
    SERVER = {
        _SHOULD_REPLICATE = false,
        AVG_TICKER_TIME_MS = 0,
        ENTITY_GRID_UPDATE_TIME_MS = 0,
        GRID_UPDATE_SECTIONS = 0,
        NUMBER_OF_ENTITIES = 0,
        NON_TICKED = 0,
        ENTITIES_FULL_TICKED = 0,
        ENTITIES_HALF_TICKED = 0,
        REPLICATE_PLAYER_TIME_MS = 0,
        BYTES_RECEIVED_PER_SEC = 0,
        BYTES_SENT_PER_SEC = 0,
        PACKETS_SENT_PER_SEC = 0,
        SERVER_ENTITIES = {},
        GRID_STATS = {}
    }
};

local function processID(p2: number, p3: any) -- Line: 53
    script:SetAttribute(tostring(p2), p3);
end;

function u1.HasPermissionToReplicate(p4) -- Line: 57
    if typeof(p4) == "Instance" and p4:IsA("Player") then
        p4 = p4.UserId;
    end;

    return script:GetAttribute((tostring(p4))) == true;
end;

function u1.ReplicateStatsForPlayer(p5) -- Line: 64
    -- upvalues: RunService (copy), u1 (copy)
    if RunService:IsClient() then
        warn("Stats.ReplicateStatsForPlayer should only be called on the server.");

        return;
    end;

    if typeof(p5) == "Instance" and p5:IsA("Player") then
        p5 = p5.UserId;
    end;

    u1.REPLICATE_PERMISSIONS[p5] = true;
    script:SetAttribute(tostring(p5), true);
end;

function u1.StopReplicatingStatsForPlayer(p6) -- Line: 76
    -- upvalues: RunService (copy), u1 (copy)
    if RunService:IsClient() then
        warn("Stats.StopReplicatingStatsForPlayer should only be called on the server.");

        return;
    end;

    if typeof(p6) == "Instance" and p6:IsA("Player") then
        p6 = p6.UserId;
    end;

    u1.REPLICATE_PERMISSIONS[p6] = nil;
    script:SetAttribute(tostring(p6), false);
end;

local u7 = {};

for i, v in u1.REPLICATE_PERMISSIONS do
    script:SetAttribute(tostring(i), v);
end;

local function updateStat(p8: string, p9: string, p10: any) -- Line: 92
    -- upvalues: Config (copy)
    if p9 == "WARNING_SEVERITY" then
        Config.SetWarningSeverity(p10);
    end;

    if p8 == "FFLAG" then
        Config.FLAGS[p9] = p10;
    end;
end;

if RunService:IsServer() then
    local RemoteEvent = Instance.new("RemoteEvent", script);
    RemoteEvent.Name = "Stats";
    RunService.Heartbeat:Connect(function() -- Line: 112
        -- upvalues: u1 (copy), Players (copy), u7 (copy), RemoteEvent (copy)
        local v11 = false;

        if next(u1.REPLICATE_PERMISSIONS) then
            for _, v in Players:GetPlayers() do
                if u1.REPLICATE_PERMISSIONS[v.UserId] and u7[v.UserId] then
                    RemoteEvent:FireClient(v, "REPLICATE_SERVER_STATS", u1.SERVER);
                    v11 = true;
                end;
            end;
        end;

        u1.SERVER._SHOULD_REPLICATE = v11;
    end);
    RemoteEvent.OnServerEvent:Connect(function(p12: userdata, p13: string, ...) -- Line: 126
        -- upvalues: u7 (copy), u1 (copy), Config (copy), RemoteEvent (copy), Holder (copy), Entity (copy)
        if p13 == "DEBUGGER_OPENED" then
            u7[p12.UserId] = ...;

            return;
        end;

        if u1.REPLICATE_PERMISSIONS and not u1.REPLICATE_PERMISSIONS[p12.UserId] then
            return;
        end;

        if p13 ~= "UPDATE_STAT" then
            if p13 == "CLIENT_STATS_ACTION" then
                local v14, v15 = ...;
                local EntityFromId = Holder.GetEntityFromId(v15);

                if not EntityFromId then
                    return;
                end;

                if v14 == "CHANGE_NATIVE" then
                    local ModelReplicationType = Entity.GetModelReplicationType(EntityFromId);

                    if ModelReplicationType == "NATIVE" then
                        Entity.LockNativeServerCFrameReplication(EntityFromId);

                        return;
                    end;

                    if ModelReplicationType == "NATIVE_WITH_LOCK" then
                        Entity.UnlockNativeServerCFrameReplication(EntityFromId);

                        return;
                    end;
                else
                    if v14 == "TOGGLE_PAUSE" then
                        if EntityFromId.paused then
                            Entity.ResumeReplication(EntityFromId);

                            return;
                        end;

                        Entity.PauseReplication(EntityFromId);

                        return;
                    end;

                    if v14 == "CHANGE_CONFIG" then
                        local v16 = select(3, ...);
                        Entity.SetConfig(EntityFromId, v16);

                        return;
                    end;

                    if v14 == "SET_INTERPOLATION_MODE" then
                        local v17 = select(3, ...);
                        Entity.SetInterpolationMode(EntityFromId, v17);
                    end;
                end;
            end;

            return;
        end;

        local v18, v19, v20 = ...;

        if v19 == "WARNING_SEVERITY" then
            Config.SetWarningSeverity(v20);
        end;

        if v18 == "FFLAG" then
            Config.FLAGS[v19] = v20;
        end;

        RemoteEvent:FireAllClients("UPDATE_STAT", v18, v19, v20);
    end);

    return u1;
end;

local Stats = script:WaitForChild("Stats");
Stats.OnClientEvent:Connect(function(p21: string, ...) -- Line: 172, Name: handleServerEvent
    -- upvalues: u1 (copy), Config (copy)
    if p21 ~= "REPLICATE_SERVER_STATS" then
        if p21 == "UPDATE_STAT" then
            local v22, v23, v24 = ...;

            if v23 == "WARNING_SEVERITY" then
                Config.SetWarningSeverity(v24);
            end;

            if v22 == "FFLAG" then
                Config.FLAGS[v23] = v24;
            end;
        end;

        return;
    end;

    local v25 = ...;

    if u1.CLIENT._PAUSE then
        return;
    end;

    for i, v in v25 do
        u1.SERVER[i] = v;
    end;
end);

function u1._openedDebugger() -- Line: 189
    -- upvalues: u1 (copy), Stats (copy)
    u1.SERVER._SHOULD_REPLICATE = true;
    Stats:FireServer("DEBUGGER_OPENED", true);
end;

function u1._closedDebugger() -- Line: 193
    -- upvalues: u1 (copy), Stats (copy)
    u1.SERVER._SHOULD_REPLICATE = false;
    Stats:FireServer("DEBUGGER_OPENED", false);
end;

function u1._updateStat(p26: string, p27: string, p28: any) -- Line: 198
    -- upvalues: Stats (copy)
    Stats:FireServer("UPDATE_STAT", p26, p27, p28);
end;

function u1._fireClientStatsEvent(...) -- Line: 202
    -- upvalues: Stats (copy)
    Stats:FireServer("CLIENT_STATS_ACTION", ...);
end;

return u1;