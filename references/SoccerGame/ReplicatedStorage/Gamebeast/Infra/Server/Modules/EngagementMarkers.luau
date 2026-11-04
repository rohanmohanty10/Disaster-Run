  

local u1 = {};
game:GetService("Players");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Timer = require(script.Parent.Parent.Parent.Shared.Modules.Timer);
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local Cleaner = require(script.Parent.Parent.Parent.Shared.Modules.Cleaner);
local Utilities = require(script.Parent.Utilities);
local DataCache = require(script.Parent.Parent.Parent.Shared.Modules.DataCache);
local ServerGate = require(script.Parent.ServerGate);
local GBRequests = require(script.Parent.GBRequests);
local InternalExperiments = require(script.Parent.InternalExperiments);
local InternalConfigs = require(script.Parent.InternalConfigs);
local SignalConnection = require(script.Parent.Parent.Parent.Shared.Modules.Signal.SignalConnection);
local LocalizationCache = require(script.Parent.LocalizationCache);
local LaunchDataResolver = require(script.Parent.LaunchDataResolver);
local ServerClientInfoHandler = require(script.Parent.ServerClientInfoHandler);
local u2 = RunService:IsStudio() and 10 or 45;
local u3 = {
    string = true,
    number = true,
    boolean = true,
    table = true
};
local u4 = {
    INVALID_MARKERS = true,
    SUBSCRIPTION_LIMIT_EXCEEDED = true,
    SUBSCRIPTION_UNPAID = true
};
local u5 = {};
local u6 = {};
local Cache = ServerGate:GetCache();
local u7 = 0;
local u8 = false;

local function GetSessionIdForPlayer(p9) -- Line: 73
    -- upvalues: Cache (copy), HttpService (copy), ServerClientInfoHandler (copy)
    if Cache[p9] == nil and p9.Parent then
        Cache[p9] = HttpService:GenerateGUID(false);
        ServerClientInfoHandler:UpdateClientData(p9, "sessionId", Cache[p9]);
    end;

    return Cache[p9];
end;

local function EncodeVector3(p10) -- Line: 82
    -- upvalues: Utilities (copy)
    local v11 = { p10.X, p10.Y, p10.Z };
    v11[1] = Utilities.roundNum(v11[1], 0.0001);
    v11[2] = Utilities.roundNum(v11[2], 0.0001);
    v11[3] = Utilities.roundNum(v11[3], 0.0001);

    return v11;
end;

local function isMarkerDataValid(p12: table) -- Line: 92
    -- upvalues: u3 (copy), isMarkerDataValid (copy)
    for _, v in p12 do
        local v13 = type(v);

        if u3[v13] == nil then
            return false;
        end;

        if v13 == "table" and not isMarkerDataValid(v) then
            return false;
        end;
    end;

    return true;
end;

local function AddMarker(p14) -- Line: 107
    -- upvalues: u6 (ref), u1 (copy)
    table.insert(u6, p14);

    if #u6 >= 1000 then
        task.spawn(function() -- Line: 112
            -- upvalues: u1 (ref)
            u1:SendMarkers();
        end);
    end;
end;

u1.MarkersFailed = Signal.new();

function u1.SendMarkers(p15: table, p16: table?) -- Line: 123
    -- upvalues: u6 (ref), u7 (ref), GBRequests (copy), Utilities (copy), isMarkerDataValid (copy), u4 (copy)
    local v17 = p16 ~= nil;
    local v18 = p16 or u6;

    if #v18 <= 0 then
        return true;
    end;

    u7 = tick();
    local v19 = {
        markers = v18
    };

    if not v17 then
        u6 = {};
    end;

    local v20, v21 = GBRequests:GBRequestAsync("v1/markers", v19);

    if v20 and (v21 and (v21.rejectedMarkersCount or 0) > 0) then
        local v22 = {};

        for i, v in v21.rejectedMarkers or {} do
            if i > 5 then
                break;
            end;

            local v23 = `{type(v.marker) == "table" and (v.marker.type or "unknown") or "unknown"}: {v.reason}`;
            table.insert(v22, v23);
        end;

        Utilities.GBWarn((`{v21.rejectedMarkersCount} of the {#v19.markers} markers sent were rejected by Gamebeast: {table.concat(v22, "; ")}`));
    end;

    if not v20 then
        local v24 = {};
        local v25 = 0;

        for _, v in v19.markers do
            if isMarkerDataValid(v) then
                if not v17 then
                    table.insert(v24, v);
                end;
            else
                v25 = v25 + 1;
            end;
        end;

        if v24[1] then
            p15.MarkersFailed:Fire(v24);
        end;

        if v25 > 0 then
            Utilities.GBWarn((`{v25} of the {#v19.markers} sent are invalid and will not be retried.`));
        end;

        if v21 and (v21.errorCode and u4[v21.errorCode]) then
            return false, v21;
        end;

        Utilities.GBWarn("Failed to send engagement markers to Gamebeast.");
    end;

    return v20, v21;
end;

function u1._createMarker(p26: table, p27: string, p28: string, p29: any, p30: table) -- Line: 191
    -- upvalues: Utilities (copy), u3 (copy), HttpService (copy), EncodeVector3 (copy), InternalConfigs (copy), u6 (ref), u1 (copy), Cleaner (copy), ServerClientInfoHandler (copy), Cache (copy), u5 (copy), SignalConnection (copy), Timer (copy), u2 (copy), u8 (ref), LaunchDataResolver (copy), LocalizationCache (copy), InternalExperiments (copy)
    local u31 = p30 or {};
    local v32 = p27 == "server" and "Usage: FireMarker(MarkerType, Value (optional), Parameters (optional))" or (p27 == "client" and "Usage: FireMarker(MarkerType, Value (optional), Parameters (optional))" or nil);

    if typeof(p28) ~= "string" then
        Utilities.GBWarn("MarkerType argument should be a string.");

        return;
    end;

    local player = u31.player;
    local position = u31.position;

    if player ~= nil and (not player:IsA("Player") and typeof(player) ~= "number") then
        Utilities.GBWarn("Player argument for " .. p27 .. " marker \"" .. p28 .. "\" should be a player instance, string/numeric identifier, or nil.\n" .. v32);

        return;
    end;

    if position ~= nil and typeof(position) ~= "Vector3" then
        Utilities.GBWarn("Position argument for " .. p27 .. " marker \"" .. p28 .. "\" should be Vector3 or nil.\n" .. v32);

        return;
    end;

    local v33 = type(p29);

    if v33 == "table" and #p29 > 0 then
        Utilities.GBWarn("Value argument for " .. p27 .. " marker \"" .. p28 .. "\" should not be an array. Use a dictionary instead.");

        return;
    end;

    if p29 ~= nil and u3[v33] == nil then
        Utilities.GBWarn("Value argument for " .. p27 .. " marker \"" .. p28 .. "\" be a primitive type or dictionary, got: " .. v33);

        return;
    end;

    local u34 = p29 ~= nil and v33 ~= "table" and {
        value = p29
    } or p29;
    local u35 = Utilities.resolvePlayerObject(player);
    local u36 = {
        markerId = HttpService:GenerateGUID(false),
        timestamp = u31.timestampOverride or DateTime.now().UnixTimestampMillis,
        type = p28,
        serverId = Utilities.getServerId()
    };
    local v37;

    if u35 then
        v37 = u35.UserId;
    else
        v37 = u35;
    end;

    u36.userId = v37;
    u36.sessionId = nil;
    u36.value = u34;
    local v38 = {
        sdkPlatform = "roblox",
        placeId = game.PlaceId,
        placeVersion = game.PlaceVersion,
        origin = p27,
        device = nil,
        deviceSubType = nil,
        inputType = nil,
        deeplinkData = nil
    };
    local v39;

    if position == nil then
        v39 = nil;
    else
        v39 = EncodeVector3(position) or nil;
    end;

    v38.position = v39;
    v38.language = nil;
    v38.country = nil;
    u36.properties = v38;
    InternalConfigs:OnReady(function() -- Line: 267
        -- upvalues: u35 (copy), u36 (copy), u6 (ref), u1 (ref), Cleaner (ref), ServerClientInfoHandler (ref), Cache (ref), HttpService (ref), u5 (ref), u31 (ref), SignalConnection (ref), u34 (ref), Timer (ref), u2 (ref), u8 (ref), Utilities (ref), LaunchDataResolver (ref), LocalizationCache (ref), InternalExperiments (ref)
        if not u35 then
            table.insert(u6, u36);

            if #u6 >= 1000 then
                task.spawn(function() -- Line: 112
                    -- upvalues: u1 (ref)
                    u1:SendMarkers();
                end);
            end;

            return;
        end;

        local u40 = {
            activeTasks = 0,
            resolved = nil,
            pendingCleaner = Cleaner.new(),
            tasks = {}
        };

        local function resolved(p41: boolean?) -- Line: 280
            -- upvalues: u40 (copy), u36 (ref), ServerClientInfoHandler (ref), u35 (ref), Cache (ref), HttpService (ref), u6 (ref), u1 (ref), u5 (ref)
            u40.pendingCleaner:Clean();
            u36.properties.device = ServerClientInfoHandler:GetClientInfo(u35, "device");
            u36.properties.deviceSubType = ServerClientInfoHandler:GetClientInfo(u35, "deviceSubType");
            u36.properties.inputType = ServerClientInfoHandler:GetClientInfo(u35, "inputType");
            local ClientInfo = ServerClientInfoHandler:GetClientInfo(u35, "sessionId");

            if ClientInfo and ClientInfo ~= "" then
                u36.sessionId = ClientInfo;

                if u35.Parent then
                    Cache[u35] = ClientInfo;
                end;
            else
                local v42 = u35;

                if Cache[v42] == nil and v42.Parent then
                    Cache[v42] = HttpService:GenerateGUID(false);
                    ServerClientInfoHandler:UpdateClientData(v42, "sessionId", Cache[v42]);
                end;

                u36.sessionId = Cache[v42];
            end;

            table.insert(u6, u36);

            if #u6 >= 1000 then
                task.spawn(function() -- Line: 112
                    -- upvalues: u1 (ref)
                    u1:SendMarkers();
                end);
            end;

            local v43 = not p41 and table.find(u5, u40);

            if v43 then
                table.remove(u5, v43);
            end;
        end;

        u40.resolved = resolved;

        local function addTask(p44: string, p45: userdata?) -- Line: 315
            -- upvalues: u40 (copy)
            if not (u40.tasks[p44] or (p45 == nil or p45.Connected ~= true)) then
                local v46 = u40;
                v46.activeTasks = v46.activeTasks + 1;
                u40.tasks[p44] = p45;

                if p45 then
                    u40.pendingCleaner:Add(p45);
                end;
            end;
        end;

        local function completeTask(p47: string) -- Line: 326
            -- upvalues: u40 (copy), resolved (copy)
            if u40.tasks[p47] then
                u40.tasks[p47] = nil;
                local v48 = u40;
                v48.activeTasks = v48.activeTasks - 1;

                if u40.activeTasks <= 0 then
                    resolved();
                end;
            end;
        end;

        if u31.tasks then
            for i, v in u31.tasks do
                local u51 = SignalConnection.new(function() -- Line: 340
                    -- upvalues: i (copy), u40 (copy), resolved (copy)
                    local v49 = i;

                    if u40.tasks[v49] then
                        u40.tasks[v49] = nil;
                        local v50 = u40;
                        v50.activeTasks = v50.activeTasks - 1;

                        if u40.activeTasks <= 0 then
                            resolved();
                        end;
                    end;
                end);

                if not (u40.tasks[i] or (u51 == nil or u51.Connected ~= true)) then
                    u40.activeTasks = u40.activeTasks + 1;
                    u40.tasks[i] = u51;

                    if u51 then
                        u40.pendingCleaner:Add(u51);
                    end;
                end;

                task.spawn(function() -- Line: 346
                    -- upvalues: v (copy), u34 (ref), u51 (copy), i (copy), u40 (copy), resolved (copy)
                    v(u34);
                    u51:Disconnect();
                    local v52 = i;

                    if u40.tasks[v52] then
                        u40.tasks[v52] = nil;
                        local v53 = u40;
                        v53.activeTasks = v53.activeTasks - 1;

                        if u40.activeTasks <= 0 then
                            resolved();
                        end;
                    end;
                end);
            end;
        end;

        local v54 = Timer.new(u2);
        u40.pendingCleaner:Add(v54);
        u40.pendingCleaner:Add(v54:OnEnd(function() -- Line: 357
            -- upvalues: u40 (copy), ServerClientInfoHandler (ref), u35 (ref), u8 (ref), Utilities (ref), resolved (copy)
            if u40.tasks.clientInfo then
                if not ServerClientInfoHandler:IsClientInfoResolved(u35) and u8 == false then
                    Utilities.GBWarn("Failed to resolve client info, did you forget to :Setup() Gamebeast SDK on the client?");
                    u8 = true;
                end;

                if u40.tasks.clientInfo then
                    u40.tasks.clientInfo = nil;
                    local v55 = u40;
                    v55.activeTasks = v55.activeTasks - 1;

                    if u40.activeTasks <= 0 then
                        resolved();
                    end;
                end;
            end;

            if u40.tasks.localization then
                u40.tasks.localization = nil;
                local v56 = u40;
                v56.activeTasks = v56.activeTasks - 1;

                if u40.activeTasks <= 0 then
                    resolved();
                end;
            end;

            if u40.tasks.launchData then
                u40.tasks.launchData = nil;
                local v57 = u40;
                v57.activeTasks = v57.activeTasks - 1;

                if u40.activeTasks <= 0 then
                    resolved();
                end;
            end;

            if u40.tasks.experimentAssignments then
                u40.tasks.experimentAssignments = nil;
                local v58 = u40;
                v58.activeTasks = v58.activeTasks - 1;

                if u40.activeTasks <= 0 then
                    resolved();
                end;
            end;
        end));
        local v60 = ServerClientInfoHandler:OnClientInfoResolved(u35, function() -- Line: 376
            -- upvalues: u40 (copy), resolved (copy)
            if u40.tasks.clientInfo then
                u40.tasks.clientInfo = nil;
                local v59 = u40;
                v59.activeTasks = v59.activeTasks - 1;

                if u40.activeTasks <= 0 then
                    resolved();
                end;
            end;
        end);

        if not (u40.tasks.clientInfo or (v60 == nil or v60.Connected ~= true)) then
            u40.activeTasks = u40.activeTasks + 1;
            u40.tasks.clientInfo = v60;

            if v60 then
                u40.pendingCleaner:Add(v60);
            end;
        end;

        local v63 = LaunchDataResolver:OnResolved(u35, function(p61) -- Line: 381
            -- upvalues: u36 (ref), u40 (copy), resolved (copy)
            if p61 and p61._gbDeeplink then
                u36.properties.deeplinkData = {
                    id = p61._gbDeeplink.deeplinkId,
                    interactionId = p61._gbDeeplink.interactionId
                };
            end;

            if u40.tasks.launchData then
                u40.tasks.launchData = nil;
                local v62 = u40;
                v62.activeTasks = v62.activeTasks - 1;

                if u40.activeTasks <= 0 then
                    resolved();
                end;
            end;
        end);

        if not (u40.tasks.launchData or (v63 == nil or v63.Connected ~= true)) then
            u40.activeTasks = u40.activeTasks + 1;
            u40.tasks.launchData = v63;

            if v63 then
                u40.pendingCleaner:Add(v63);
            end;
        end;

        local v66 = LocalizationCache:OnResolved(u35, function(p64) -- Line: 394
            -- upvalues: u36 (ref), u40 (copy), resolved (copy)
            u36.properties.language = p64.localeId;
            u36.properties.country = p64.regionId;

            if u40.tasks.localization then
                u40.tasks.localization = nil;
                local v65 = u40;
                v65.activeTasks = v65.activeTasks - 1;

                if u40.activeTasks <= 0 then
                    resolved();
                end;
            end;
        end);

        if not (u40.tasks.localization or (v66 == nil or v66.Connected ~= true)) then
            u40.activeTasks = u40.activeTasks + 1;
            u40.tasks.localization = v66;

            if v66 then
                u40.pendingCleaner:Add(v66);
            end;
        end;

        local v68 = InternalExperiments:OnAssignmentsResolvedForPlayer(u35, function() -- Line: 403
            -- upvalues: u40 (copy), resolved (copy)
            if u40.tasks.experimentAssignments then
                u40.tasks.experimentAssignments = nil;
                local v67 = u40;
                v67.activeTasks = v67.activeTasks - 1;

                if u40.activeTasks <= 0 then
                    resolved();
                end;
            end;
        end);

        if not (u40.tasks.experimentAssignments or (v68 == nil or v68.Connected ~= true)) then
            u40.activeTasks = u40.activeTasks + 1;
            u40.tasks.experimentAssignments = v68;

            if v68 then
                u40.pendingCleaner:Add(v68);
            end;
        end;

        if u40.activeTasks <= 0 then
            resolved();

            return;
        end;

        table.insert(u5, u40);
    end);
end;

function u1.FireMarker(p69, ...) -- Line: 417
    p69:_createMarker("server", ...);
end;

function u1.SDKMarker(p70, ...) -- Line: 422
    p70:_createMarker("sdk", ...);
end;

function u1.Init(u71) -- Line: 427
    -- upvalues: DataCache (copy), u7 (ref), Utilities (copy), GBRequests (copy), u5 (copy)
    task.spawn(function() -- Line: 429
        -- upvalues: DataCache (ref), u7 (ref), u71 (copy), Utilities (ref)
        while true do
            local v72;

            repeat
                v72 = DataCache:Get("Settings").markerFlushRate;
                task.wait((math.min(5, v72)));
            until v72 <= tick() - u7;

            local success, result = pcall(u71.SendMarkers, u71);

            if not success then
                Utilities.GBWarn("Failed to send engagement markers:", result);
            end;
        end;
    end);
    GBRequests:OnFinalRequestCall(function() -- Line: 446
        -- upvalues: u5 (ref), u71 (copy)
        for _, v in u5 do
            v.resolved(true);
        end;

        u71:SendMarkers();
    end);
end;

return u1;