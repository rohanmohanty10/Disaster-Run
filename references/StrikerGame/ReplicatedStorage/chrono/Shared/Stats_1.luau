 
 

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

local function processID(p2: number, p3: any) -- Line: 52
    script:SetAttribute(tostring(p2), p3);
end;

local function ToUserId(p4) -- Line: 56
    if typeof(p4) == "Instance" then
        return p4.UserId;
    end;

    return p4;
end;

function u1.HasPermissionToReplicate(p5) -- Line: 60
    local l_script = script;

    if typeof(p5) == "Instance" then
        p5 = p5.UserId;
    end;

    return l_script:GetAttribute((tostring(p5))) == true;
end;

function u1.ReplicateStatsForPlayer(p6) -- Line: 64
    -- upvalues: RunService (copy), u1 (copy)
    if RunService:IsClient() then
        warn("Stats.ReplicateStatsForPlayer should only be called on the server.");

        return;
    end;

    if typeof(p6) == "Instance" then
        p6 = p6.UserId;
    end;

    u1.REPLICATE_PERMISSIONS[p6] = true;
    script:SetAttribute(tostring(p6), true);
end;

function u1.StopReplicatingStatsForPlayer(p7) -- Line: 74
    -- upvalues: RunService (copy), u1 (copy)
    if RunService:IsClient() then
        warn("Stats.StopReplicatingStatsForPlayer should only be called on the server.");

        return;
    end;

    if typeof(p7) == "Instance" then
        p7 = p7.UserId;
    end;

    u1.REPLICATE_PERMISSIONS[p7] = nil;
    script:SetAttribute(tostring(p7), false);
end;

local u8 = {};

for i, v in u1.REPLICATE_PERMISSIONS do
    script:SetAttribute(tostring(i), v);
end;

local function updateStat(p9: string, p10: string, p11: any) -- Line: 88
    -- upvalues: Config (copy)
    if p10 == "WARNING_SEVERITY" then
        Config.SetWarningSeverity(p11);
    end;

    if p9 == "FFLAG" then
        Config.FLAGS[p10] = p11;
    end;
end;

if RunService:IsServer() then
    local RemoteEvent = Instance.new("RemoteEvent", script);
    RemoteEvent.Name = "Stats";
    RunService.Heartbeat:Connect(function() -- Line: 108
        -- upvalues: u1 (copy), Players (copy), u8 (copy), RemoteEvent (copy)
        local v12 = false;

        if next(u1.REPLICATE_PERMISSIONS) then
            for _, v in Players:GetPlayers() do
                if u1.REPLICATE_PERMISSIONS[v.UserId] and u8[v.UserId] then
                    RemoteEvent:FireClient(v, "REPLICATE_SERVER_STATS", u1.SERVER);
                    v12 = true;
                end;
            end;
        end;

        u1.SERVER._SHOULD_REPLICATE = v12;
    end);
    RemoteEvent.OnServerEvent:Connect(function(p13: userdata, p14: string, ...) -- Line: 122
        -- upvalues: u8 (copy), u1 (copy), Config (copy), RemoteEvent (copy), Holder (copy), Entity (copy)
        if p14 == "DEBUGGER_OPENED" then
            u8[p13.UserId] = ...;

            return;
        end;

        if u1.REPLICATE_PERMISSIONS and not u1.REPLICATE_PERMISSIONS[p13.UserId] then
            return;
        end;

        if p14 ~= "UPDATE_STAT" then
            if p14 == "CLIENT_STATS_ACTION" then
                local v15, v16 = ...;
                local EntityFromId = Holder.GetEntityFromId(v16);

                if not EntityFromId then
                    return;
                end;

                if v15 == "CHANGE_NATIVE" then
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
                    if v15 == "TOGGLE_PAUSE" then
                        if EntityFromId.paused then
                            Entity.ResumeReplication(EntityFromId);

                            return;
                        end;

                        Entity.PauseReplication(EntityFromId);

                        return;
                    end;

                    if v15 == "CHANGE_CONFIG" then
                        local v17 = select(3, ...);
                        Entity.SetConfig(EntityFromId, v17);

                        return;
                    end;

                    if v15 == "SET_INTERPOLATION_MODE" then
                        local v18 = select(3, ...);
                        Entity.SetInterpolationMode(EntityFromId, v18);
                    end;
                end;
            end;

            return;
        end;

        local v19, v20, v21 = ...;

        if v20 == "WARNING_SEVERITY" then
            Config.SetWarningSeverity(v21);
        end;

        if v19 == "FFLAG" then
            Config.FLAGS[v20] = v21;
        end;

        RemoteEvent:FireAllClients("UPDATE_STAT", v19, v20, v21);
    end);

    return u1;
end;

local Stats = script:WaitForChild("Stats");
Stats.OnClientEvent:Connect(function(p22: string, ...) -- Line: 168, Name: handleServerEvent
    -- upvalues: u1 (copy), Config (copy)
    if p22 ~= "REPLICATE_SERVER_STATS" then
        if p22 == "UPDATE_STAT" then
            local v23, v24, v25 = ...;

            if v24 == "WARNING_SEVERITY" then
                Config.SetWarningSeverity(v25);
            end;

            if v23 == "FFLAG" then
                Config.FLAGS[v24] = v25;
            end;
        end;

        return;
    end;

    local v26 = ...;

    if u1.CLIENT._PAUSE then
        return;
    end;

    for i, v in v26 do
        u1.SERVER[i] = v;
    end;
end);

function u1._openedDebugger() -- Line: 185
    -- upvalues: u1 (copy), Stats (copy)
    u1.SERVER._SHOULD_REPLICATE = true;
    Stats:FireServer("DEBUGGER_OPENED", true);
end;

function u1._closedDebugger() -- Line: 189
    -- upvalues: u1 (copy), Stats (copy)
    u1.SERVER._SHOULD_REPLICATE = false;
    Stats:FireServer("DEBUGGER_OPENED", false);
end;

function u1._updateStat(p27: string, p28: string, p29: any) -- Line: 194
    -- upvalues: Stats (copy)
    Stats:FireServer("UPDATE_STAT", p27, p28, p29);
end;

function u1._fireClientStatsEvent(...) -- Line: 198
    -- upvalues: Stats (copy)
    Stats:FireServer("CLIENT_STATS_ACTION", ...);
end;

return u1;