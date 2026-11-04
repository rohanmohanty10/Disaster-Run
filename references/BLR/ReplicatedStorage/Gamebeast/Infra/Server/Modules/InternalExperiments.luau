  

local u1 = {};
local Players = game:GetService("Players");
local GBRequests = require(script.Parent.GBRequests);
local DataCache = require(script.Parent.Parent.Parent.Shared.Modules.DataCache);
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local Utilities = require(script.Parent.Utilities);
local SignalConnection = require(script.Parent.Parent.Parent.Shared.Modules.Signal.SignalConnection);
local ServerGate = require(script.Parent.ServerGate);
local ServerClientInfoHandler = require(script.Parent.ServerClientInfoHandler);
local Cleaner = require(script.Parent.Parent.Parent.Shared.Modules.Cleaner);
require(script.Parent.Changesets);
local script_ExperimentCatalog = require(script.ExperimentCatalog);
local script_AssignmentContext = require(script.AssignmentContext);
local u2 = false;
local u3 = nil;
local u4 = nil;
local u5 = {};
local u6 = Signal.new();
local u7 = false;
local u8 = 0;
u1.ServerAssignments = {};
u1.AssignmentsByPlayer = {};
u1.OnServerAssignmentsChanged = Signal.new();
u1.OnPlayerAssignmentsChanged = Signal.new();
u1.OnAssignmentDisabling = Signal.new();

local function buildRecordMap(p9: table?) -- Line: 148
    local v10 = {};

    for _, v in p9 or {} do
        v10[v.experimentId] = v;
    end;

    return v10;
end;

local u11 = nil;

local function queueAssignment(p12: table, p13: number?) -- Line: 161
    -- upvalues: u4 (ref), u11 (ref)
    local u14 = u4;
    assert(u14, "Assignment has not been started");

    for _, v in p12 do
        u14.playerIdsPendingAssignment[v.UserId] = true;
    end;

    if not u14.deferredBulkAssignmentThread then
        u14.deferredBulkAssignmentThread = task.delay(p13 or 1, function() -- Line: 171
            -- upvalues: u14 (copy), u11 (ref)
            u14.deferredBulkAssignmentThread = nil;
            u11();
        end);
    end;
end;

local function requeueOnClientInfo(u15: table, u16: userdata) -- Line: 183
    -- upvalues: Utilities (copy), ServerClientInfoHandler (copy), u4 (ref), queueAssignment (copy)
    if u15.playersAwaitingClientInfo[u16] then
        return;
    end;

    u15.playersAwaitingClientInfo[u16] = true;
    Utilities.GBLog((`Client info for player {u16.UserId} has not arrived yet; requesting their assignment again once it does`));
    ServerClientInfoHandler:OnClientInfoResolved(u16, function() -- Line: 192
        -- upvalues: u4 (ref), u15 (copy), u16 (copy), queueAssignment (ref)
        if u4 ~= u15 then
            return;
        end;

        u15.playersAwaitingClientInfo[u16] = nil;

        if u16.Parent then
            queueAssignment({ u16 });
        end;
    end);
end;

u11 = function() -- Line: 209, Name: executeUserAssignmentRequest
    -- upvalues: u4 (ref), script_AssignmentContext (copy), script_ExperimentCatalog (copy), requeueOnClientInfo (copy), Utilities (copy), GBRequests (copy), Players (copy), queueAssignment (copy), buildRecordMap (copy), u1 (copy), u5 (copy), u6 (copy)
    local v17 = u4;

    if not v17 then
        return;
    end;

    if v17.deferredBulkAssignmentThread then
        task.cancel(v17.deferredBulkAssignmentThread);
        v17.deferredBulkAssignmentThread = nil;
    end;

    local v18 = {};

    for i in v17.playerIdsPendingAssignment do
        table.insert(v18, i);
    end;

    v17.playerIdsPendingAssignment = {};

    if #v18 == 0 then
        return;
    end;

    v17.lastRequestId = v17.lastRequestId + 1;
    local lastRequestId = v17.lastRequestId;

    for _, v in v18 do
        v17.latestRequestIdByPlayerId[v] = lastRequestId;
    end;

    local ForPlayers, v19 = script_AssignmentContext:GetForPlayers(v18, script_ExperimentCatalog:GetRequiredPropertyUnion("user"));

    if u4 ~= v17 then
        return;
    end;

    for _, v in v19 do
        requeueOnClientInfo(v17, v);
    end;

    local v20 = {};

    for _, v in v18 do
        local v21 = {
            distinctId = tostring(v),
            context = ForPlayers[v]
        };
        table.insert(v20, v21);
    end;

    for i = 1, #v20, 250 do
        local table_move_ret = table.move(v20, i, math.min(i + 250 - 1, #v20), 1, {});
        Utilities.GBLog((`Requesting bulk assignment for {#table_move_ret} player(s)...`));
        local v22, v23 = GBRequests:GBRequestAsync("v2/experiments/assignments/bulk", {
            unitType = "user",
            sharedContext = script_AssignmentContext:GetShared(),
            units = table_move_ret
        });

        if u4 ~= v17 then
            return;
        end;

        if v22 and (type(v23) ~= "table" or type(v23.assignments) ~= "table") then
            v22 = false;
        end;

        local v24;

        if v22 then
            v24 = i;

            for _, v in table_move_ret do
                local v25 = tonumber(v.distinctId);
                local PlayerByUserId = Players:GetPlayerByUserId(v25);

                if PlayerByUserId and v17.latestRequestIdByPlayerId[v25] == lastRequestId then
                    local v26 = buildRecordMap(v23.assignments[v.distinctId]);
                    local v27 = not Utilities.primativeDeepEqual(u1.AssignmentsByPlayer[PlayerByUserId] or {}, v26);
                    u1.AssignmentsByPlayer[PlayerByUserId] = v26;
                    u5[PlayerByUserId] = true;
                    u6:Fire(PlayerByUserId);

                    if v27 then
                        Utilities.GBLog("Assignments changed for player:", PlayerByUserId.UserId);
                        u1.OnPlayerAssignmentsChanged:Fire(PlayerByUserId);
                    end;
                end;
            end;
        else
            Utilities.GBWarn("Failed to get experiment assignments:", v23);
            v24 = i;
            local v28 = {};

            for _, v in table_move_ret do
                local v29 = tonumber(v.distinctId);
                local PlayerByUserId = Players:GetPlayerByUserId(v29);

                if PlayerByUserId and v17.latestRequestIdByPlayerId[v29] == lastRequestId then
                    table.insert(v28, PlayerByUserId);
                end;
            end;

            if #v28 > 0 then
                queueAssignment(v28, 10);
            end;
        end;
    end;
end;

local function executeServerAssignmentRequest() -- Line: 328
    -- upvalues: u8 (ref), script_AssignmentContext (copy), script_ExperimentCatalog (copy), Utilities (copy), GBRequests (copy), u7 (ref), executeServerAssignmentRequest (copy), buildRecordMap (copy), u1 (copy)
    u8 = u8 + 1;
    local ForServer = script_AssignmentContext:GetForServer(script_ExperimentCatalog:GetRequiredPropertyUnion("server"));
    local ServerId = Utilities.getServerId();
    Utilities.GBLog("Requesting server experiment assignment...");
    local v30, v31 = GBRequests:GBRequestAsync("v2/experiments/assignments/bulk", {
        unitType = "server",
        sharedContext = script_AssignmentContext:GetShared(),
        units = {
            {
                distinctId = ServerId,
                context = ForServer
            }
        }
    });

    if u8 ~= u8 then
        return;
    end;

    if v30 and (type(v31) ~= "table" or type(v31.assignments) ~= "table") then
        v30 = false;
    end;

    if not v30 then
        Utilities.GBWarn("Failed to get server experiment assignment:", v31);

        if not u7 then
            u7 = true;
            task.delay(10, function() -- Line: 365
                -- upvalues: u7 (ref), script_ExperimentCatalog (ref), executeServerAssignmentRequest (ref)
                u7 = false;

                if script_ExperimentCatalog:GetUnitTypeCount("server") > 0 then
                    executeServerAssignmentRequest();
                end;
            end);
        end;

        return;
    end;

    local v32 = buildRecordMap(v31.assignments[ServerId]);
    local v33 = not Utilities.primativeDeepEqual(u1.ServerAssignments, v32);
    u1.ServerAssignments = v32;

    if v33 then
        Utilities.GBLog("Server assignments changed");
        u1.OnServerAssignmentsChanged:Fire();
    end;
end;

local function startAssignmentRefresh() -- Line: 395
    -- upvalues: u2 (ref), DataCache (copy), u4 (ref), Players (copy), queueAssignment (copy), script_ExperimentCatalog (copy), u7 (ref), executeServerAssignmentRequest (copy)
    if u2 then
        return;
    end;

    u2 = true;
    task.spawn(function() -- Line: 401
        -- upvalues: DataCache (ref), u4 (ref), Players (ref), queueAssignment (ref), script_ExperimentCatalog (ref), u7 (ref), executeServerAssignmentRequest (ref)
        local v34 = tick();

        while true do
            while true do
                local v35 = DataCache:Get("Settings").assignmentRefreshRate - (tick() - v34);

                if v35 <= 0 then
                    break;
                end;

                task.wait((math.min(v35, 5)));
            end;

            v34 = tick();

            if u4 then
                local Players2 = Players:GetPlayers();

                if #Players2 > 0 then
                    queueAssignment(Players2);
                end;
            end;

            if script_ExperimentCatalog:GetUnitTypeCount("server") > 0 and not u7 then
                task.spawn(executeServerAssignmentRequest);
            end;
        end;
    end);
end;

local function enableAssignment() -- Line: 432
    -- upvalues: u4 (ref), Players (copy), queueAssignment (copy), ServerGate (copy), u1 (copy), u5 (copy), Utilities (copy)
    if u4 then
        return;
    end;

    local u36 = nil;
    u36 = {
        deferredBulkAssignmentThread = nil,
        lastRequestId = 0,
        playerIdsPendingAssignment = {},
        playerJoinListener = Players.PlayerAdded:Connect(function(p37) -- Line: 440
            -- upvalues: queueAssignment (ref)
            queueAssignment({ p37 });
        end),
        playerLeaveListener = ServerGate:OnPlayerRemoved(function(p38) -- Line: 443
            -- upvalues: u1 (ref), u5 (ref), u36 (ref)
            u1.AssignmentsByPlayer[p38] = nil;
            u5[p38] = nil;
            u36.latestRequestIdByPlayerId[p38.UserId] = nil;
            u36.playersAwaitingClientInfo[p38] = nil;
            u1.OnPlayerAssignmentsChanged:Fire(p38);
        end),
        latestRequestIdByPlayerId = {},
        playersAwaitingClientInfo = {}
    };
    u4 = u36;
    Utilities.GBLog("Started requesting experiment assignment");
end;

local function disableAssignment() -- Line: 464
    -- upvalues: u4 (ref), u1 (copy), u5 (copy), Utilities (copy)
    local v39 = u4;

    if not v39 then
        return;
    end;

    u1.OnAssignmentDisabling:Fire();
    v39.playerJoinListener:Disconnect();
    v39.playerLeaveListener:Disconnect();

    if v39.deferredBulkAssignmentThread then
        task.cancel(v39.deferredBulkAssignmentThread);
    end;

    u4 = nil;
    table.clear(u5);
    table.clear(u1.AssignmentsByPlayer);
    Utilities.GBLog("Stopped requesting experiment assignment");
end;

local function scheduleContextRefresh(p40: userdata?) -- Line: 493
    -- upvalues: u4 (ref), queueAssignment (copy), u3 (ref), script_ExperimentCatalog (copy), executeServerAssignmentRequest (copy), Players (copy)
    if p40 then
        if u4 then
            queueAssignment({ p40 });
        end;

        return;
    end;

    if u3 then
        return;
    end;

    u3 = task.delay(1, function() -- Line: 505
        -- upvalues: u3 (ref), script_ExperimentCatalog (ref), executeServerAssignmentRequest (ref), u4 (ref), queueAssignment (ref), Players (ref)
        u3 = nil;

        if script_ExperimentCatalog:GetUnitTypeCount("server") > 0 then
            task.spawn(executeServerAssignmentRequest);
        end;

        if u4 then
            queueAssignment(Players:GetPlayers());
        end;
    end);
end;

function u1.SetPlayerProperties(p41: table, p42: userdata, p43: table) -- Line: 523
    -- upvalues: script_AssignmentContext (copy), scheduleContextRefresh (copy)
    if script_AssignmentContext:SetPlayerProperties(p42, p43) then
        scheduleContextRefresh(p42);
    end;
end;

function u1.SetPlayerProperty(p44: table, p45: userdata, p46: string, p47: any) -- Line: 529
    -- upvalues: script_AssignmentContext (copy), scheduleContextRefresh (copy)
    if script_AssignmentContext:SetPlayerProperty(p45, p46, p47) then
        scheduleContextRefresh(p45);
    end;
end;

function u1.GetPlayerProperties(p48: table, p49: userdata) -- Line: 535
    -- upvalues: script_AssignmentContext (copy)
    return script_AssignmentContext:GetPlayerProperties(p49);
end;

function u1.SetServerProperties(p50: table, p51: table) -- Line: 539
    -- upvalues: script_AssignmentContext (copy), u3 (ref), script_ExperimentCatalog (copy), executeServerAssignmentRequest (copy), u4 (ref), queueAssignment (copy), Players (copy)
    if script_AssignmentContext:SetServerProperties(p51) then
        if u3 then
            return;
        end;

        u3 = task.delay(1, function() -- Line: 505
            -- upvalues: u3 (ref), script_ExperimentCatalog (ref), executeServerAssignmentRequest (ref), u4 (ref), queueAssignment (ref), Players (ref)
            u3 = nil;

            if script_ExperimentCatalog:GetUnitTypeCount("server") > 0 then
                task.spawn(executeServerAssignmentRequest);
            end;

            if u4 then
                queueAssignment(Players:GetPlayers());
            end;
        end);
    end;
end;

function u1.SetServerProperty(p52: table, p53: string, p54: any) -- Line: 545
    -- upvalues: script_AssignmentContext (copy), u3 (ref), script_ExperimentCatalog (copy), executeServerAssignmentRequest (copy), u4 (ref), queueAssignment (copy), Players (copy)
    if script_AssignmentContext:SetServerProperty(p53, p54) then
        if u3 then
            return;
        end;

        u3 = task.delay(1, function() -- Line: 505
            -- upvalues: u3 (ref), script_ExperimentCatalog (ref), executeServerAssignmentRequest (ref), u4 (ref), queueAssignment (ref), Players (ref)
            u3 = nil;

            if script_ExperimentCatalog:GetUnitTypeCount("server") > 0 then
                task.spawn(executeServerAssignmentRequest);
            end;

            if u4 then
                queueAssignment(Players:GetPlayers());
            end;
        end);
    end;
end;

function u1.GetServerProperties(p55) -- Line: 551
    -- upvalues: script_AssignmentContext (copy)
    return script_AssignmentContext:GetServerProperties();
end;

function u1.UpdateCatalog(p56: table, p57: any, p58: table?) -- Line: 563
    -- upvalues: u2 (ref), DataCache (copy), u4 (ref), Players (copy), queueAssignment (copy), script_ExperimentCatalog (copy), u7 (ref), executeServerAssignmentRequest (copy), u1 (copy), enableAssignment (copy), disableAssignment (copy), u11 (ref)
    if not u2 then
        u2 = true;
        task.spawn(function() -- Line: 401
            -- upvalues: DataCache (ref), u4 (ref), Players (ref), queueAssignment (ref), script_ExperimentCatalog (ref), u7 (ref), executeServerAssignmentRequest (ref)
            local v59 = tick();

            while true do
                while true do
                    local v60 = DataCache:Get("Settings").assignmentRefreshRate - (tick() - v59);

                    if v60 <= 0 then
                        break;
                    end;

                    task.wait((math.min(v60, 5)));
                end;

                v59 = tick();

                if u4 then
                    local Players2 = Players:GetPlayers();

                    if #Players2 > 0 then
                        queueAssignment(Players2);
                    end;
                end;

                if script_ExperimentCatalog:GetUnitTypeCount("server") > 0 and not u7 then
                    task.spawn(executeServerAssignmentRequest);
                end;
            end;
        end);
    end;

    local v61 = script_ExperimentCatalog:Update(p57, p58);
    local v62 = {};
    local v63 = false;

    for _, v in v61.removedExperimentIds do
        if u1.ServerAssignments[v] then
            u1.ServerAssignments[v] = nil;
            v63 = true;
        end;

        local v64 = v;

        for i, v2 in u1.AssignmentsByPlayer do
            if v2[v64] then
                v2[v64] = nil;
                v62[i] = true;
            end;
        end;
    end;

    local UnitTypeCount = script_ExperimentCatalog:GetUnitTypeCount("user");
    local v65 = u4 ~= nil;

    if UnitTypeCount > 0 and not v65 then
        enableAssignment();
    elseif UnitTypeCount == 0 and v65 then
        disableAssignment();
    end;

    if #v61.newUserExperimentIds > 0 and u4 then
        queueAssignment(Players:GetPlayers());

        if not v65 then
            u11();
        end;
    end;

    if #v61.newServerExperimentIds > 0 then
        executeServerAssignmentRequest();
    end;

    if v63 then
        u1.OnServerAssignmentsChanged:Fire();
    end;

    for i in v62 do
        u1.OnPlayerAssignmentsChanged:Fire(i);
    end;

    return v61.complete;
end;

function u1.GetChangesetsForConfig(p66: table, u67: number, p68: userdata?) -- Line: 628
    -- upvalues: script_ExperimentCatalog (copy), u1 (copy)
    local function collect(p69: string, p70: table) -- Line: 629
        -- upvalues: script_ExperimentCatalog (ref), u67 (copy)
        local v71 = {};

        for i, v in p70 do
            local v72 = script_ExperimentCatalog:Get(i);

            if v72 and (v72.meta.unitType == p69 and (v72.meta.baseConfigurationId == u67 and (v.status == "active" and v.groupId))) then
                local v73 = v72.changesetByGroupId[v.groupId];

                if v73 then
                    table.insert(v71, {
                        changeset = v73,
                        experimentId = i
                    });
                end;
            end;
        end;

        table.sort(v71, function(p74, p75) -- Line: 651
            return p74.experimentId < p75.experimentId;
        end);

        return v71;
    end;

    local v76 = {};

    for _, v in collect("server", u1.ServerAssignments) do
        table.insert(v76, v.changeset);
    end;

    if p68 then
        for _, v in collect("user", u1.AssignmentsByPlayer[p68] or {}) do
            table.insert(v76, v.changeset);
        end;
    end;

    return v76;
end;

function u1.HasPlayerOverlays(p77: table, p78: userdata, p79: number) -- Line: 675
    -- upvalues: u1 (copy), script_ExperimentCatalog (copy)
    local v80 = u1.AssignmentsByPlayer[p78];

    if not v80 then
        return false;
    end;

    for i, v in v80 do
        local v81 = script_ExperimentCatalog:Get(i);

        if v81 and (v81.meta.baseConfigurationId == p79 and (v.status == "active" and (v.groupId and v81.changesetByGroupId[v.groupId]))) then
            return true;
        end;
    end;

    return false;
end;

function u1.GetAssignments(p82: table, p83: userdata?) -- Line: 699
    -- upvalues: u1 (copy)
    local v84;

    if p83 then
        v84 = u1.AssignmentsByPlayer[p83];
    else
        v84 = u1.ServerAssignments;
    end;

    local v85 = {};

    for _, v in v84 or {} do
        table.insert(v85, v);
    end;

    return v85;
end;

function u1.GetAssignmentMetadata(p86: table, p87: number, p88: number) -- Line: 713
    -- upvalues: script_ExperimentCatalog (copy)
    return script_ExperimentCatalog:GetMetadata(p87, p88);
end;

function u1.OnAssignmentsResolvedForPlayer(p89: table, u90: userdata, u91: function) -- Line: 724
    -- upvalues: Cleaner (copy), SignalConnection (copy), u4 (ref), u5 (copy), u6 (copy), u1 (copy), Players (copy), ServerGate (copy)
    local u92 = Cleaner.new();
    local u93 = SignalConnection.new(function() -- Line: 726
        -- upvalues: u92 (copy)
        u92:Destroy();
    end);

    local function resolve() -- Line: 730
        -- upvalues: u93 (copy), u91 (copy)
        u93:Disconnect();
        task.spawn(u91);

        return u93;
    end;

    if not u4 then
        u93:Disconnect();
        task.spawn(u91);

        return u93;
    end;

    if u5[u90] then
        u93:Disconnect();
        task.spawn(u91);

        return u93;
    end;

    u92:Add(u6:Connect(function(p94: userdata) -- Line: 746
        -- upvalues: u90 (copy), u93 (copy), u91 (copy)
        if p94 == u90 then
            u93:Disconnect();
            task.spawn(u91);
        end;
    end));
    u92:Add(u1.OnAssignmentDisabling:Connect(function() -- Line: 752
        -- upvalues: u93 (copy), u91 (copy)
        u93:Disconnect();
        task.spawn(u91);
    end));
    u92:Add(Players.PlayerRemoving:Connect(function(p95: userdata) -- Line: 756
        -- upvalues: u90 (copy), u93 (copy), u91 (copy)
        if p95 == u90 then
            u93:Disconnect();
            task.spawn(u91);
        end;
    end));
    u92:Add(ServerGate:OnPlayerRemoved(function(p96: userdata) -- Line: 764
        -- upvalues: u90 (copy), u93 (copy), u91 (copy)
        if p96 == u90 then
            u93:Disconnect();
            task.spawn(u91);
        end;
    end));

    return u93;
end;

return u1;