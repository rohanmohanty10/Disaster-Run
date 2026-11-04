  

local v1 = {};
local Players = game:GetService("Players");
local GBRequests = require(script.Parent.GBRequests);
local MetricCollector = require(script.Parent.Parent.Parent.Shared.Modules.MetricCollector);
local GetRemote = require(script.Parent.Parent.Parent.Shared.Modules.GetRemote);
local Utilities = require(script.Parent.Utilities);
local DataCache = require(script.Parent.Parent.Parent.Shared.Modules.DataCache);
local u2 = GetRemote("Event", "ExportClientMetrics");
local u3 = {};

local function AggregateMetric(p4: table) -- Line: 50
    if not p4 or #p4 == 0 then
        return nil;
    end;

    table.sort(p4);
    local v5 = p4[1];
    local v6 = v5;
    local v7 = 0;

    for _, v in p4 do
        v5 = math.min(v5, v);
        v6 = math.max(v6, v);
        v7 = v7 + v;
    end;

    local v8 = {
        min = v5,
        max = v6,
        sum = v7,
        average = v7 / #p4
    };
    local math_floor_ret = math.floor(#p4 / 2);
    v8.median = p4[math.max(math_floor_ret, 1)];
    local math_floor_ret2 = math.floor(#p4 * 0.25);
    v8.p25 = p4[math.max(math_floor_ret2, 1)];
    local math_floor_ret3 = math.floor(#p4 * 0.75);
    v8.p75 = p4[math.max(math_floor_ret3, 1)];
    local math_floor_ret4 = math.floor(#p4 * 0.9);
    v8.p90 = p4[math.max(math_floor_ret4, 1)];
    local math_floor_ret5 = math.floor(#p4 * 0.99);
    v8.p99 = p4[math.max(math_floor_ret5, 1)];

    return v8;
end;

function v1.SendServerStateReport(p9) -- Line: 83
    -- upvalues: Utilities (copy), GBRequests (copy)
    local v10 = p9:PrepareServerStateReport();
    GBRequests:GBRequest(`v1/servers/roblox/{Utilities.getServerId()}`, v10);
end;

function v1.PrepareServerStateReport(p11) -- Line: 91
    -- upvalues: Players (copy), MetricCollector (copy), u3 (copy), AggregateMetric (copy)
    local v12 = {};

    for _, v in Players:GetPlayers() do
        table.insert(v12, v.UserId);
    end;

    local v13 = MetricCollector:ReadAndResetAllMetrics();
    table.clear(u3);

    return {
        timestamp = DateTime.now():ToIsoDate(),
        rootPlaceId = game.PlaceId,
        universeId = game.GameId,
        placeVersion = game.PlaceVersion,
        players = v12,
        metadata = {
            clientPing = AggregateMetric(v13.ClientPing),
            clientFps = AggregateMetric(v13.ClientPhysicsFps),
            serverFps = AggregateMetric(v13.PhysicsFps),
            serverAgeSeconds = workspace.DistributedGameTime,
            matchmakingType = game.MatchmakingType.Name,
            privateServerId = game.PrivateServerId,
            privateServerOwnerId = game.PrivateServerOwnerId
        }
    };
end;

function v1.Init(u14) -- Line: 124
    -- upvalues: MetricCollector (copy), DataCache (copy), u2 (copy), u3 (copy), GBRequests (copy)
    task.spawn(function() -- Line: 126
        -- upvalues: MetricCollector (ref)
        while task.wait(1) do
            MetricCollector:ReportMetric("PhysicsFps", workspace:GetRealPhysicsFPS());
        end;
    end);
    task.spawn(function() -- Line: 134
        -- upvalues: DataCache (ref), u14 (copy)
        local v15 = tick();

        while true do
            while true do
                local v16 = DataCache:Get("Settings").serverReportRate - (tick() - v15);

                if v16 <= 0 then
                    break;
                end;

                task.wait((math.min(v16, 5)));
            end;

            v15 = tick();
            u14:SendServerStateReport();
        end;
    end);
    u2.OnServerEvent:Connect(function(p17: userdata, p18: table) -- Line: 149
        -- upvalues: u3 (ref), MetricCollector (ref)
        if type(p18) ~= "table" or (type(p18.PhysicsFps) ~= "table" or type(p18.Ping) ~= "table") then
            return;
        end;

        local v19 = (u3[p17] or 0) + 1;

        if v19 > 10 then
            return;
        end;

        u3[p17] = v19;

        for i = 1, 10 do
            local v20 = p18.PhysicsFps[i];
            local v21 = p18.Ping[i];

            if type(v20) == "number" and (v20 >= 0 and v20 <= 360) then
                MetricCollector:ReportMetric("ClientPhysicsFps", v20);
            end;

            local v22;

            if type(v21) == "number" and (v21 >= 0 and v21 <= 100000) then
                MetricCollector:ReportMetric("ClientPing", v21);
                v22 = i;
            else
                v22 = i;
            end;
        end;
    end);
    GBRequests:OnFinalRequestCall(function() -- Line: 183
        -- upvalues: u14 (copy)
        u14:SendServerStateReport();
    end);
end;

return v1;