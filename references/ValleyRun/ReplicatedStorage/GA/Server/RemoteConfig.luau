 

 

local HttpService = game:GetService("HttpService");
local MessagingService = game:GetService("MessagingService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Config = require(script.Parent.Parent.Shared.Config);
local Signal = require(script.Parent.Parent.Shared.Signal);
local v1 = {};
v1.__index = v1;
local u2 = false;
local u3 = false;
local u4 = {};
local u5 = {};
local u6 = "";
local u7 = "";
local u8 = "";
local u9 = "";
local u10 = nil;
local u11 = {};
local u12 = 0;
local u13 = {};
local u14 = 0;
local u15 = {};
local u16 = {};
local u17 = {};
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = {};
local u22 = 600;
local u23 = {};
local u24 = {};

local function trouble(p25: string, p26: string) -- Line: 93
    -- upvalues: u24 (copy), u23 (copy)
    u24[p25] = (u24[p25] or 0) + 1;
    local os_clock_ret = os.clock();

    if u23[p25] and os_clock_ret - u23[p25] < 60 then
        return;
    end;

    local v27 = u24[p25];
    u23[p25] = os_clock_ret;
    u24[p25] = 0;
    warn("[GA:Config] " .. p26 .. (v27 <= 1 and "" or ` ({v27}x since the last warning)`));
end;

local function makeRequest(u28: string, p29: number?) -- Line: 104
    -- upvalues: HttpService (copy), Config (copy), u8 (ref), trouble (copy)
    local v30 = p29 or 3;

    for i = 1, v30 do
        local success, result = pcall(function() -- Line: 108
            -- upvalues: HttpService (ref), u28 (copy), Config (ref), u8 (ref)
            return HttpService:RequestAsync({
                Method = "GET",
                Url = u28,
                Headers = {
                    Authorization = Config.authorizationHeader(u8),
                    ["Content-Type"] = "application/json"
                }
            });
        end);

        if success and result.Success then
            local success2, result2 = pcall(HttpService.JSONDecode, HttpService, result.Body);

            if success2 and type(result2) == "table" then
                return true, result2;
            end;

            trouble("decode", "A config response could not be read: " .. (success2 and "not a JSON object" or tostring(result2)));

            return false, nil;
        end;

        local v31;

        if success then
            v31 = result.StatusCode;
        else
            v31 = nil;
        end;

        if v31 ~= nil and v31 ~= 429 and v31 < 500 or v30 <= i then
            local v32;

            if success then
                local StatusMessage = result.StatusMessage;
                local v33 = tostring(result.Body);
                v32 = `HTTP {v31} {StatusMessage} {string.sub(v33, 1, 200)}`;
            else
                v32 = tostring(result);
            end;

            trouble("fetch", (`Config fetch failed after {i} attempt(s): {v32}`));

            return false, nil;
        end;

        task.wait(5);
        local _ = i;
    end;

    return false, nil;
end;

local function getBaseSignal(p34: string) -- Line: 149
    -- upvalues: u16 (copy), Signal (copy)
    local v35 = u16[p34];

    if not v35 then
        v35 = Signal.new();
        u16[p34] = v35;
    end;

    return v35;
end;

local function encodeVal(u36) -- Line: 160
    -- upvalues: HttpService (copy)
    if u36 == nil then
        return "\0nil";
    end;

    local success, result = pcall(function() -- Line: 165
        -- upvalues: HttpService (ref), u36 (copy)
        return HttpService:JSONEncode(u36);
    end);

    return success and result and result or "\0" .. tostring(u36);
end;

local function diffKeys(p37: table, p38: table) -- Line: 173
    -- upvalues: HttpService (copy)
    local v39 = {};
    local v40 = {};

    for i, v in p38 do
        v39[i] = true;
        local u41 = p37[i];
        local v42;

        if u41 == nil then
            v42 = "\0nil";
        else
            local success, result = pcall(function() -- Line: 165
                -- upvalues: HttpService (ref), u41 (copy)
                return HttpService:JSONEncode(u41);
            end);
            v42 = success and result and result or "\0" .. tostring(u41);
        end;

        local v43;

        if v == nil then
            v43 = "\0nil";
        else
            local success, result = pcall(function() -- Line: 165
                -- upvalues: HttpService (ref), v (copy)
                return HttpService:JSONEncode(v);
            end);
            v43 = success and result and result or "\0" .. tostring(v);
        end;

        if v42 ~= v43 then
            table.insert(v40, i);
        end;
    end;

    for i, v in p37 do
        if not v39[i] then
            local v44;

            if v == nil then
                v44 = "\0nil";
            else
                local success, result = pcall(function() -- Line: 165
                    -- upvalues: HttpService (ref), v (copy)
                    return HttpService:JSONEncode(v);
                end);
                v44 = success and result and result or "\0" .. tostring(v);
            end;

            local u45 = p38[i];
            local v46;

            if u45 == nil then
                v46 = "\0nil";
            else
                local success, result = pcall(function() -- Line: 165
                    -- upvalues: HttpService (ref), u45 (copy)
                    return HttpService:JSONEncode(u45);
                end);
                v46 = success and result and result or "\0" .. tostring(u45);
            end;

            if v44 ~= v46 then
                table.insert(v40, i);
            end;
        end;
    end;

    return v40;
end;

function v1.init(u47: table, p48: table) -- Line: 196
    -- upvalues: u2 (ref), Config (copy), u10 (ref), u7 (ref), u8 (ref), u9 (ref), u6 (ref), u22 (ref), u3 (ref), RunService (copy), MessagingService (copy), u13 (ref), u4 (copy), u14 (ref), Players (copy), u18 (ref), ReplicatedStorage (copy), u19 (ref)
    if u2 then
        warn("[GA:Config] Already initialized");

        return;
    end;

    assert(p48.gameId and #p48.gameId > 0, "[GA:Config] gameId required");
    local v49 = Config.isApiKey(p48.apiKey);
    assert(v49, "[GA:Config] apiKey required");
    u10 = p48.filterEffectiveConfig;
    u7 = p48.gameId;
    u8 = p48.apiKey;
    u9 = game.JobId;
    u6 = (p48.endpoint or Config.DEFAULT.API_ENDPOINT):gsub("/v1/ingest$", "") .. "/api/games/" .. u7 .. "/configs/serve";
    u22 = p48.refreshInterval or 600;
    u3 = false;
    u47:refresh();

    if u3 then
        return;
    end;

    if RunService:IsServer() then
        local success, result = pcall(function() -- Line: 238
            -- upvalues: MessagingService (ref), u13 (ref), u47 (copy), u3 (ref), u4 (ref)
            local v50 = MessagingService:SubscribeAsync("GoatConfigRefresh", function() -- Line: 239
                -- upvalues: u13 (ref), u47 (ref)
                for _, v in u13 do
                    v.fetchedAt = 0;
                end;

                u47:refresh();
            end);

            if u3 then
                v50:Disconnect();

                return;
            end;

            table.insert(u4, v50);
        end);

        if success then
            print("[GA:Config] Push refresh active (topic: GoatConfigRefresh)");
        else
            warn((`[GA:Config] Push subscribe failed, poll-only: {tostring(result)}`));
        end;
    end;

    if u3 then
        return;
    end;

    task.spawn(function() -- Line: 270
        -- upvalues: u3 (ref), u14 (ref), u22 (ref), u47 (copy)
        local v51 = 5;

        while not u3 do
            local v52;

            if u14 == 0 then
                v52 = v51 > 0;
            else
                v52 = false;
            end;

            if v52 then
                v51 = v51 - 1;
            end;

            task.wait(v52 and 60 or u22);

            if not u3 then
                u47:refresh();
            end;
        end;
    end);
    table.insert(u4, Players.PlayerRemoving:Connect(function(p53) -- Line: 292
        -- upvalues: u47 (copy)
        u47:_onPlayerLeaving(p53.UserId);
    end));

    if RunService:IsServer() and p48.clientMirror ~= false then
        u18 = Instance.new("RemoteEvent");
        u18.Name = "GoatConfigSync";
        u18.Parent = ReplicatedStorage;
        u19 = Instance.new("RemoteFunction");
        u19.Name = "GoatConfigFetch";
        u19.Parent = ReplicatedStorage;

        function u19.OnServerInvoke(p54) -- Line: 308
            -- upvalues: u47 (copy)
            return u47:_ensureTracked(p54.UserId);
        end;
    end;

    u2 = true;
    print((`[GA:Config] Remote config initialized (gameId: {u7}, safety-poll: {u22}s)`));
end;

function v1.setEnrollmentGate(p55: table, p56: function?) -- Line: 333
    -- upvalues: u20 (ref), u21 (copy), u13 (ref)
    u20 = p56;
    table.clear(u21);
    u13 = {};
end;

function v1.refresh(p57) -- Line: 339
    -- upvalues: u3 (ref), u6 (ref), u9 (ref), makeRequest (copy), u11 (ref), u15 (ref), u12 (ref), u14 (ref), diffKeys (copy), u16 (copy)
    if u3 then
        return;
    end;

    local v58, v59 = makeRequest(u6 .. "?env=prod&serverId=" .. u9);

    if not u3 and (v58 and v59) then
        local v60 = u11;
        local v61 = type(v59.config) ~= "table" and {} or v59.config;
        u11 = v61;
        u15 = type(v59.abAssignments) ~= "table" and {} or v59.abAssignments;
        u12 = type(v59.version) ~= "number" and 0 or v59.version;
        u14 = os.time();

        for _, v in diffKeys(v60, v61) do
            local v62 = u16[v];

            if v62 then
                v62:Fire(v61[v], v60[v]);
            end;
        end;

        p57:_reconcilePlayers();
    end;
end;

function v1.get(p63: table, p64: string, p65: any) -- Line: 375
    -- upvalues: u11 (ref)
    if u11[p64] == nil then
        return p65;
    end;

    return u11[p64];
end;

function v1.getAll(p66) -- Line: 387
    -- upvalues: u11 (ref)
    return u11;
end;

function v1.getVersion(p67) -- Line: 395
    -- upvalues: u12 (ref)
    return u12;
end;

function v1.getForPlayer(p68: table, p69: userdata, p70: string?, p71: any) -- Line: 407
    -- upvalues: u13 (ref), u12 (ref), u11 (ref)
    local UserId = p69.UserId;
    local v72 = u13[UserId];
    local v73;

    if v72 and os.time() - v72.fetchedAt < 300 then
        v73 = {
            config = v72.config,
            abAssignments = v72.abAssignments,
            version = u12
        };
    else
        p68:_fetchEffective(UserId);
        local v74 = u13[UserId];

        if v74 then
            v73 = {
                config = v74.config,
                abAssignments = v74.abAssignments,
                version = u12
            };
        else
            v73 = {
                config = u11,
                abAssignments = {},
                version = u12
            };
        end;
    end;

    if p70 == nil then
        return v73;
    end;

    local v75 = v73.config[p70];

    if v75 == nil then
        return p71;
    end;

    return v75;
end;

function v1.getABGroup(p76: table, p77: userdata, p78: string) -- Line: 451
    local v79 = p76:getForPlayer(p77).abAssignments[p78];

    return (type(v79) ~= "table" or type(v79.group) ~= "string") and {
        group = "control",
        enrolled = false
    } or (v79.excluded == true and {
        group = "control",
        enrolled = false,
        gated = true
    } or {
        group = v79.group,
        enrolled = v79.enrolled == true
    });
end;

local function fetchAssignments(p80: number, p81: table?) -- Line: 471
    -- upvalues: u6 (ref), u9 (ref), HttpService (copy), makeRequest (copy)
    local v82 = u6 .. "?env=prod&userId=" .. tostring(p80) .. "&serverId=" .. u9;

    if p81 then
        local v83 = {};

        for i in p81 do
            table.insert(v83, i);
        end;

        if #v83 > 0 then
            table.sort(v83);
            v82 = v82 .. "&exclude=" .. HttpService:UrlEncode(table.concat(v83, ","));
        end;
    end;

    local v84, v85 = makeRequest(v82, 2);

    if v84 and type(v85) == "table" then
        return v85;
    end;

    return nil;
end;

function v1._fetchEffective(p86: table, p87: number) -- Line: 493
    -- upvalues: fetchAssignments (copy), u21 (copy), u3 (ref), u20 (ref), Players (copy), trouble (copy), u13 (ref), u11 (ref), u10 (ref)
    local v88 = fetchAssignments(p87, u21[p87]);

    if u3 or not v88 then
        return nil;
    end;

    if u20 then
        local PlayerByUserId = Players:GetPlayerByUserId(p87);
        local v89 = type(v88.abAssignments) ~= "table" and {} or v88.abAssignments;
        local v90 = u21[p87] or {};
        local v91 = false;

        if PlayerByUserId then
            for i, v in v89 do
                if type(v) == "table" and (v.enrolled == true and not v90[i]) then
                    local success, result = pcall(u20, PlayerByUserId, i, v);

                    if not success then
                        trouble("gate", (`The enrollment gate failed, so the player is left out of {i}: {result}`));
                    end;

                    if not success or result == false then
                        v90[i] = true;
                        v91 = true;
                    end;
                end;
            end;
        end;

        if v91 then
            u21[p87] = v90;
            u13[p87] = nil;
            v88 = fetchAssignments(p87, v90);

            if not v88 then
                trouble("exclude", "A player\'s re-fetch without their vetoed tests failed, so they get the base config");

                return nil;
            end;
        end;
    end;

    if u3 or not v88 then
        return nil;
    end;

    local v92;

    if type(v88.config) == "table" then
        v92 = v88.config;
    else
        v92 = u11;
    end;

    local v93 = type(v88.abAssignments) ~= "table" and {} or v88.abAssignments;

    for i in u21[p87] or {} do
        local v94 = v93[i];

        if type(v94) == "table" and v94.enrolled == true then
            trouble("exclude", (`GOAT still enrolled a player in {i} after the game excluded them, so they get the base config`));
            u13[p87] = nil;

            return nil;
        end;
    end;

    if u10 then
        local PlayerByUserId = Players:GetPlayerByUserId(p87);

        if not PlayerByUserId then
            return nil;
        end;

        local v95;
        v95, v92, v93 = pcall(u10, PlayerByUserId, v92, v93, u11);

        if not (v95 and (type(v92) == "table" and type(v93) == "table")) then
            trouble("filter", "The experiment filter failed, so the player gets the base config: " .. (v95 and "it returned no tables" or tostring(v92)));
            v92 = u11;
            v93 = {};
        end;
    end;

    if u3 or not Players:GetPlayerByUserId(p87) then
        return nil;
    end;

    u13[p87] = {
        config = v92,
        abAssignments = v93,
        fetchedAt = os.time()
    };

    return v92;
end;

function v1._ensureTracked(p96: table, p97: number) -- Line: 580
    -- upvalues: u17 (copy), u5 (copy), u3 (ref), u11 (ref), trouble (copy), Players (copy)
    local v98 = u17[p97];

    if v98 then
        return v98.effective;
    end;

    if u5[p97] then
        while u5[p97] and not u3 do
            task.wait();
        end;

        if u17[p97] then
            return u17[p97].effective;
        end;

        return u11;
    end;

    u5[p97] = true;
    local success, result = pcall(p96._fetchEffective, p96, p97);
    u5[p97] = nil;

    if not success then
        trouble("track", "Tracking a player\'s config failed, so they get the base config: " .. tostring(result));
    end;

    local v99 = success and result and result or u11;

    if u3 or not Players:GetPlayerByUserId(p97) then
        return u11;
    end;

    u17[p97] = {
        effective = v99,
        signals = {}
    };

    return v99;
end;

function v1._reconcilePlayers(u100) -- Line: 612
    -- upvalues: u17 (copy), Players (copy), trouble (copy), diffKeys (copy), u18 (ref)
    for i, v in u17 do
        task.spawn(function() -- Line: 614
            -- upvalues: Players (ref), i (copy), u100 (copy), trouble (ref), v (copy), diffKeys (ref), u18 (ref)
            task.wait(math.random() * 2);

            if not Players:GetPlayerByUserId(i) then
                return;
            end;

            local success, result = pcall(u100._fetchEffective, u100, i);

            if not success then
                trouble("reconcile", "Refreshing a player\'s config failed: " .. tostring(result));

                return;
            end;

            if not result then
                return;
            end;

            local effective = v.effective;
            local v101 = diffKeys(effective, result);

            if #v101 == 0 then
                return;
            end;

            v.effective = result;
            local v102 = {};
            local v103 = {};

            for _, v2 in v101 do
                local v104 = result[v2];

                if v104 == nil then
                    table.insert(v103, v2);
                else
                    v102[v2] = v104;
                end;

                local v105 = v.signals[v2];

                if v105 then
                    v105:Fire(v104, effective[v2]);
                end;
            end;

            local PlayerByUserId = Players:GetPlayerByUserId(i);

            if PlayerByUserId and u18 then
                u18:FireClient(PlayerByUserId, {
                    changed = v102,
                    removed = v103
                });
            end;
        end);
    end;
end;

function v1.onChanged(p106: table, p107: string, p108: function, p109: boolean?) -- Line: 669
    -- upvalues: u16 (copy), Signal (copy), u11 (ref)
    local v110 = u16[p107];

    if not v110 then
        v110 = Signal.new();
        u16[p107] = v110;
    end;

    local v111 = v110:Connect(p108);

    if p109 then
        task.spawn(p108, u11[p107], nil);
    end;

    return v111;
end;

function v1.onChangedForPlayer(p112: table, p113: userdata, p114: string, p115: function, p116: boolean?) -- Line: 694
    -- upvalues: u17 (copy), Signal (copy)
    local UserId = p113.UserId;
    local v117 = p112:_ensureTracked(UserId);
    local v118 = u17[UserId];
    local v119 = v118.signals[p114];

    if not v119 then
        v119 = Signal.new();
        v118.signals[p114] = v119;
    end;

    local v120 = v119:Connect(p115);

    if p116 then
        task.spawn(p115, v117[p114], nil);
    end;

    return v120;
end;

function v1._onPlayerLeaving(p121: table, u122: number) -- Line: 721
    -- upvalues: Players (copy), u13 (ref), u21 (copy), u17 (copy)
    task.delay(10, function() -- Line: 722
        -- upvalues: Players (ref), u122 (copy), u13 (ref), u21 (ref), u17 (ref)
        if not Players:GetPlayerByUserId(u122) then
            u13[u122] = nil;
            u21[u122] = nil;
            local v123 = u17[u122];

            if v123 then
                for _, v in v123.signals do
                    v:DisconnectAll();
                end;

                u17[u122] = nil;
            end;
        end;
    end);
end;

function v1.forget(p124: table, p125: number, p126: table?) -- Line: 743
    -- upvalues: u13 (ref)
    if p126 == nil then
        u13[p125] = nil;

        return;
    end;

    local v127 = u13[p125];

    if v127 then
        local table_clone_ret = table.clone(v127.abAssignments);

        for i in p126 do
            table_clone_ret[i] = nil;
        end;

        v127.abAssignments = table_clone_ret;
    end;
end;

function v1.getServerAssignments(p128) -- Line: 760
    -- upvalues: u15 (ref)
    return u15;
end;

function v1.getStatus(p129) -- Line: 764
    -- upvalues: u14 (ref), u12 (ref), u3 (ref)
    return {
        LastFetchAt = u14,
        Version = u12,
        Stopped = u3
    };
end;

function v1.peekAssignments(p130: table, p131: userdata) -- Line: 768
    -- upvalues: u13 (ref)
    local v132 = u13[p131.UserId];

    return not v132 and {} or table.clone(v132.abAssignments);
end;

function v1.peekAssignmentsByUserId(p133: table, p134: number) -- Line: 776
    -- upvalues: u13 (ref)
    local v135 = u13[p134];

    return not v135 and {} or v135.abAssignments;
end;

function v1.shutdown(p136) -- Line: 781
    -- upvalues: u3 (ref), u4 (copy), u17 (copy), u16 (copy), u13 (ref), u18 (ref), u19 (ref)
    u3 = true;

    for _, v in u4 do
        v:Disconnect();
    end;

    table.clear(u4);

    for _, v in u17 do
        for _, v2 in v.signals do
            v2:DisconnectAll();
        end;
    end;

    for _, v in u16 do
        v:DisconnectAll();
    end;

    table.clear(u17);
    table.clear(u13);

    if u18 then
        u18:Destroy();
    end;

    if u19 then
        u19:Destroy();
    end;
end;

return v1;