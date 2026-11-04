  

local u1 = {};
local Players = game:GetService("Players");
local Utilities = require(script.Parent.Utilities);
local GetRemote = require(script.Parent.Parent.Parent.Shared.Modules.GetRemote);
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local SignalConnection = require(script.Parent.Parent.Parent.Shared.Modules.Signal.SignalConnection);
local ServerGate = require(script.Parent.ServerGate);
local u2 = GetRemote("Function", "Get");
local u3 = GetRemote("Event", "ConfigChanged");
local u4 = GetRemote("Event", "ConfigIdentitiesChanged");
local u5 = Signal.new({
    copyArguments = false
});
local u6 = Signal.new({
    copyArguments = false
});
local table_freeze_ret = table.freeze({});
local u7 = 0;
local u8 = nil;
local Cache = ServerGate:GetCache();
local u9 = {};
local u10 = false;
local u11 = {};
local u12 = {};
local u13 = false;

local function ResolveConfigId(p14: string) -- Line: 88
    -- upvalues: u12 (copy)
    return u12[tostring(p14)];
end;

local function GetIdentifierForEntry(p15: table) -- Line: 92
    return p15.alias or (p15.name or tostring(p15.id));
end;

local function BuildIdentifierByConfigId() -- Line: 97
    -- upvalues: u11 (copy)
    local v16 = {};

    for i, v in u11 do
        v16[tostring(i)] = v.alias or (v.name or tostring(v.id));
    end;

    return v16;
end;

local function QueueIdentityBroadcast() -- Line: 109
    -- upvalues: u13 (ref), u10 (ref), u4 (copy), u12 (copy), BuildIdentifierByConfigId (copy)
    if u13 then
        return;
    end;

    u13 = true;
    task.defer(function() -- Line: 115
        -- upvalues: u13 (ref), u10 (ref), u4 (ref), u12 (ref), BuildIdentifierByConfigId (ref)
        u13 = false;

        if u10 then
            u4:FireAllClients(u12, (BuildIdentifierByConfigId()));
        end;
    end);
end;

local function RebuildIdentifierMap() -- Line: 123
    -- upvalues: u12 (copy), u11 (copy), u7 (ref), u13 (ref), u10 (ref), u4 (copy), BuildIdentifierByConfigId (copy)
    table.clear(u12);

    for i in u11 do
        u12[tostring(i)] = i;
    end;

    for i, v in u11 do
        if v.name then
            u12[v.name] = i;
        end;
    end;

    for i, v in u11 do
        if v.alias then
            u12[v.alias] = i;
        end;
    end;

    u7 = u7 + 1;

    if u13 then
        return;
    end;

    u13 = true;
    task.defer(function() -- Line: 115
        -- upvalues: u13 (ref), u10 (ref), u4 (ref), u12 (ref), BuildIdentifierByConfigId (ref)
        u13 = false;

        if u10 then
            u4:FireAllClients(u12, (BuildIdentifierByConfigId()));
        end;
    end);
end;

local function IsSameSegment(p17, p18) -- Line: 148
    return p17 == p18 and true or tostring(p17) == tostring(p18);
end;

local function ResolveSegment(p19: table, p20: any) -- Line: 153
    if p19[p20] == nil then
        local v21 = tonumber(p20);

        if v21 ~= nil and p19[v21] ~= nil then
            return v21;
        end;
    end;

    return p20;
end;

local function IsPathPrivate(p22: table, p23: table) -- Line: 163
    for _, v in p23 do
        if #v <= #p22 then
            local v24 = v;
            local v25 = true;

            for i, v2 in ipairs(p22) do
                if v24[i] == nil then
                    return true;
                end;

                local v26 = v24[i];

                if v2 ~= v26 and tostring(v2) ~= tostring(v26) then
                    v25 = false;
                    break;
                end;
            end;

            if v25 then
                return true;
            end;
        end;
    end;

    return false;
end;

local function FilterConfigForClient(p27: table, p28: table, p29: table) -- Line: 187
    -- upvalues: Utilities (copy)
    if typeof(p28) == "table" then
        p28 = Utilities.recursiveCopy(p28);
    end;

    local v30 = {};

    for _, v in p29 do
        local v31 = v;
        local v32 = true;

        for i, v2 in ipairs(p27) do
            if v31[i] == nil then
                break;
            end;

            local v33 = v31[i];

            if v2 ~= v33 and tostring(v2) ~= tostring(v33) then
                v32 = false;
                break;
            end;
        end;

        if v32 then
            local table_clone_ret = table.clone(v31);

            for i = 1, #p27 do
                table.remove(table_clone_ret, 1);
                local _ = i;
            end;

            table.insert(v30, table_clone_ret);
        end;
    end;

    for _, v in v30 do
        if #v == 0 then
            return nil;
        end;

        if type(p28) == "table" then
            local v34 = p28;
            local v35 = v;

            for i, v2 in v do
                if i == #v35 then
                    local v36;

                    if p28[v2] == nil then
                        v36 = tonumber(v2);

                        if v36 == nil or p28[v36] == nil then
                            v36 = v2;
                        end;
                    else
                        v36 = v2;
                    end;

                    p28[v36] = nil;
                    p28 = v34;
                    break;
                end;

                local v37;

                if p28[v2] == nil then
                    v37 = tonumber(v2);

                    if v37 == nil or p28[v37] == nil then
                        v37 = v2;
                    end;
                else
                    v37 = v2;
                end;

                p28 = p28[v37];

                if type(p28) ~= "table" then
                    Utilities.GBWarn("Privacy path " .. table.concat(v35, ".") .. " does not exist in config.");
                    p28 = v34;
                    break;
                end;
            end;

            p28 = v34;
        end;
    end;

    return p28;
end;

local function IsPathWithin(p38: table, p39: table) -- Line: 250
    if #p39 > #p38 then
        return false;
    end;

    for i, v in p39 do
        local v40 = p38[i];

        if v ~= v40 and tostring(v) ~= tostring(v40) then
            return false;
        end;
    end;

    return true;
end;

local function addRootmostPathToSet(p41: table, p42: table) -- Line: 264
    -- upvalues: IsPathWithin (copy)
    for i, v in p41 do
        if IsPathWithin(p42, v) then
            return;
        end;

        if IsPathWithin(v, p42) then
            p41[i] = nil;
        end;
    end;

    local table_create_ret = table.create(#p42);

    for _, v in p42 do
        local v43 = v:gsub("\\", "\\\\"):gsub("%.", "\\.");
        table.insert(table_create_ret, v43);
    end;

    p41[table.concat(table_create_ret, ".")] = p42;
end;

local function BuildClientPayload(p44: userdata) -- Line: 282
    -- upvalues: u11 (copy), FilterConfigForClient (copy), u12 (copy), BuildIdentifierByConfigId (copy)
    local v45 = {};

    for i, v in u11 do
        local v46 = v.viewByPlayer[p44] or v.serverView;
        v45[tostring(i)] = FilterConfigForClient({}, v46, v.privacy);
    end;

    return {
        idByIdentifier = table.clone(u12),
        identifierByConfigId = BuildIdentifierByConfigId(),
        configs = v45
    };
end;

local function GetClientPayload(p47: userdata) -- Line: 299
    -- upvalues: u11 (copy), Cache (copy), u8 (ref), u7 (ref), BuildClientPayload (copy)
    local v48 = false;

    for _, v in u11 do
        if v.viewByPlayer[p47] then
            v48 = true;
            break;
        end;
    end;

    local v49;

    if v48 then
        v49 = Cache[p47];
    else
        v49 = u8;
    end;

    if v49 and v49.version == u7 then
        return v49.payload;
    end;

    local v50 = {
        version = u7,
        payload = BuildClientPayload(p47)
    };

    if v48 then
        Cache[p47] = v50;
    else
        u8 = v50;
    end;

    return v50.payload;
end;

function u1.IsReady(p51) -- Line: 324
    -- upvalues: u10 (ref)
    return u10;
end;

function u1.OnReady(u52: table, u53: function) -- Line: 328
    -- upvalues: u10 (ref), u5 (copy), SignalConnection (copy)
    if not u10 then
        return u5:Once(function() -- Line: 331
            -- upvalues: u53 (copy), u52 (copy)
            u53(u52:GetAll(nil));
        end);
    end;

    task.spawn(u53, u52:GetAll(nil));

    return SignalConnection.new();
end;

function u1.SetReady(p54) -- Line: 345
    -- upvalues: u10 (ref), u5 (copy)
    if u10 then
        return;
    end;

    u10 = true;
    u5:Fire();
end;

function u1.WaitForConfigsReady(p55) -- Line: 354
    -- upvalues: u10 (ref), u5 (copy)
    if not u10 then
        u5:Wait();
    end;

    return true;
end;

function u1.OnChanged(u56: table, u57: userdata?, p58: any, u59: function) -- Line: 361
    -- upvalues: u6 (copy), u11 (copy), u12 (copy), u9 (copy)
    local u60 = type(p58) == "string" and { p58 } or p58;
    local v71 = u6:Connect(function(p61: userdata?, p62: number, p63: table, p64: any) -- Line: 367
        -- upvalues: u57 (copy), u11 (ref), u60 (ref), u12 (ref), u59 (copy), u56 (copy)
        local v65 = p61 == nil;

        if u57 == nil and not v65 then
            return;
        end;

        if u57 and v65 then
            local v66 = u11[p62];

            if v66 and v66.viewByPlayer[u57] then
                return;
            end;
        elseif u57 and p61 ~= u57 then
            return;
        end;

        if u12[tostring(u60[1])] ~= p62 then
            return;
        end;

        for _, v in p63 do
            local v67 = v;
            local v68 = true;

            for i = 2, #u60 do
                local v69 = v67.path[i - 1];

                if v69 == nil then
                    break;
                end;

                local v70 = u60[i];

                if v70 ~= v69 and tostring(v70) ~= tostring(v69) then
                    v68 = false;
                    break;
                end;

                local _ = i;
            end;

            if v68 then
                u59(u56:Get(u57, u60), u56:Get(u57, u60, p64));

                return;
            end;
        end;
    end);

    if u57 then
        local v72 = u9[u57];

        if not v72 then
            v72 = {};
            u9[u57] = v72;
        end;

        table.insert(v72, v71);
    end;

    return v71;
end;

function u1._checkConfigChanged(p73, p74, p75) -- Line: 422
    local u76 = {};

    local function addToBatch(p77, p78, p79) -- Line: 425
        -- upvalues: u76 (copy)
        table.insert(u76, {
            path = p77,
            newValue = p78
        });
    end;

    local function recursiveChangedFinder(p80, p81, p82) -- Line: 429
        -- upvalues: u76 (copy), recursiveChangedFinder (copy)
        local v83 = p82 or {};

        for i, v in p80 do
            local table_clone_ret = table.clone(v83);
            table.insert(table_clone_ret, i);
            local v84 = p81[i];

            if v84 == nil then
                table.insert(u76, {
                    newValue = nil,
                    path = table_clone_ret
                });
            elseif type(v84) == type(v) then
                if type(v84) == "table" then
                    recursiveChangedFinder(v, v84, table_clone_ret);
                elseif v84 ~= v then
                    table.insert(u76, {
                        path = table_clone_ret,
                        newValue = v84
                    });
                end;
            else
                table.insert(u76, {
                    path = table_clone_ret,
                    newValue = v84
                });
            end;
        end;

        for i, v in p81 do
            local table_clone_ret = table.clone(v83);
            table.insert(table_clone_ret, i);

            if p80[i] == nil then
                table.insert(u76, {
                    path = table_clone_ret,
                    newValue = v
                });
            end;
        end;
    end;

    recursiveChangedFinder(p74, p75);

    return u76;
end;

function u1.SetBaseConfig(p85: table, p86: table) -- Line: 469
    -- upvalues: u11 (copy), RebuildIdentifierMap (copy)
    local v87 = u11[p86.id];
    local v88;

    if v87 then
        v88 = v87.privacy or nil;
    else
        v88 = nil;
    end;

    local v89 = v87 or {
        viewByPlayer = {}
    };
    v89.id = p86.id;
    v89.name = p86.name;
    v89.alias = p86.alias;
    v89.hash = p86.hash;
    v89.updatedAt = p86.updatedAt;
    v89.base = p86.configuration or {};
    v89.privacy = p86.privacy or {};
    u11[p86.id] = v89;
    RebuildIdentifierMap();

    return v88;
end;

function u1.UpdateConfigIdentity(p90: table, p91: number, p92: string?, p93: string?) -- Line: 492
    -- upvalues: u11 (copy), RebuildIdentifierMap (copy)
    local v94 = u11[p91];

    if not v94 then
        return;
    end;

    if v94.name ~= p92 or v94.alias ~= p93 then
        v94.name = p92;
        v94.alias = p93;
        RebuildIdentifierMap();
    end;
end;

function u1.RemoveConfig(p95: table, p96: number) -- Line: 507
    -- upvalues: u11 (copy), RebuildIdentifierMap (copy)
    local v97 = u11[p96];

    if not v97 then
        return;
    end;

    for i in v97.viewByPlayer do
        p95:ApplyConfigs(i, p96, nil);
    end;

    p95:ApplyConfigs(nil, p96, {});
    u11[p96] = nil;
    RebuildIdentifierMap();
end;

function u1.GetBaseConfig(p98: table, p99: number) -- Line: 522
    -- upvalues: u11 (copy)
    return u11[p99];
end;

function u1.GetConfigHashes(p100) -- Line: 526
    -- upvalues: u11 (copy)
    local v101 = {};

    for i, v in u11 do
        v101[i] = v.hash;
    end;

    return v101;
end;

function u1.GetAll(p102: table, p103: userdata?) -- Line: 535
    -- upvalues: u11 (copy)
    local v104 = {};

    for _, v in u11 do
        v104[v.alias or (v.name or tostring(v.id))] = p103 and v.viewByPlayer[p103] or v.serverView;
    end;

    return v104;
end;

function u1.ApplyConfigs(p105: table, p106: userdata?, p107: number, p108: table?, p109: boolean?, p110: table?) -- Line: 548
    -- upvalues: u11 (copy), Utilities (copy), u7 (ref), table_freeze_ret (copy), u1 (copy), u6 (copy), IsPathPrivate (copy), addRootmostPathToSet (copy), FilterConfigForClient (copy), u3 (copy), Players (copy)
    local v111 = u11[p107];

    if not v111 then
        Utilities.GBWarn("Cannot apply configs for unknown config id:", p107);

        return;
    end;

    if not p106 then
        assert(p108, "Server configs cannot be cleared");
    end;

    u7 = u7 + 1;

    if p106 and p106.Parent == nil then
        v111.viewByPlayer[p106] = nil;

        return;
    end;

    local v112 = p106 and v111.viewByPlayer[p106] or (v111.serverView or table_freeze_ret);
    local v113 = p110 or v111.privacy;
    local privacy = v111.privacy;

    local function recursiveFreeze(p114) -- Line: 577
        -- upvalues: recursiveFreeze (copy)
        if not table.isfrozen(p114) then
            table.freeze(p114);
        end;

        for _, v in p114 do
            if type(v) == "table" then
                recursiveFreeze(v);
            end;
        end;
    end;

    if p108 then
        recursiveFreeze(p108);
    end;

    if p106 then
        v111.viewByPlayer[p106] = p108;

        if p108 == nil then
            p108 = v111.serverView;
        end;
    else
        v111.serverView = p108;
    end;

    if p109 ~= true then
        local v115 = u1:_checkConfigChanged(v112, p108);

        if #v115 > 0 then
            u6:Fire(p106, p107, v115, v112);
        end;

        local v116 = {};

        for _, v in privacy do
            if Utilities.getValueAtPath(v112, v) ~= nil and not IsPathPrivate(v, v113) then
                addRootmostPathToSet(v116, v);
            end;
        end;

        local TableValues = Utilities.getTableValues(v116);
        local v117 = {};

        for _, v in v113 do
            if not IsPathPrivate(v, privacy) then
                addRootmostPathToSet(v117, v);
            end;
        end;

        local TableValues2 = Utilities.getTableValues(v117);
        local table_create_ret = table.create(#v115);

        for _, v in v115 do
            if not (IsPathPrivate(v.path, TableValues) or IsPathPrivate(v.path, TableValues2)) then
                table.insert(table_create_ret, v);
            end;
        end;

        for _, v in v116 do
            table.insert(table_create_ret, {
                newValue = nil,
                isPrivacyTransition = true,
                path = v
            });
        end;

        for _, v in v117 do
            local ValueAtPath = Utilities.getValueAtPath(p108, v);

            if ValueAtPath ~= nil then
                table.insert(table_create_ret, {
                    isPrivacyTransition = true,
                    path = v,
                    newValue = ValueAtPath
                });
            end;
        end;

        if #table_create_ret > 0 then
            local v118 = {};

            for _, v in table_create_ret do
                if v.isPrivacyTransition or not IsPathPrivate(v.path, privacy) then
                    v.newValue = FilterConfigForClient(v.path, v.newValue, privacy);
                    table.insert(v118, v);
                end;
            end;

            if #v118 == 0 then
                return;
            end;

            if p106 then
                u3:FireClient(p106, p107, v118);

                return;
            end;

            for _, v in Players:GetPlayers() do
                if not v111.viewByPlayer[v] then
                    u3:FireClient(v, p107, v118);
                end;
            end;
        end;
    end;
end;

function u1.Get(p119: table, p120: userdata?, p121: any, p122: any) -- Line: 695
    -- upvalues: Utilities (copy), u12 (copy), u11 (copy)
    if typeof(p121) ~= "table" and typeof(p121) ~= "string" then
        Utilities.GBWarn("Config path must be a string or list of strings.");

        return nil;
    end;

    local v123 = typeof(p121) == "string" and ({ p121 } or p121) or p121;

    if #v123 == 0 then
        Utilities.GBWarn("Config path must begin with a configuration name or alias.");

        return nil;
    end;

    if p122 then
        for i = 2, #v123 do
            if type(p122) ~= "table" then
                return nil;
            end;

            local v124 = v123[i];

            if p122[v124] == nil then
                local v125 = tonumber(v124);

                if v125 ~= nil and p122[v125] ~= nil then
                    v124 = v125;
                end;
            end;

            p122 = p122[v124];
            local _ = i;
        end;

        return p122;
    end;

    p119:WaitForConfigsReady();
    local v126 = u12[tostring(v123[1])];

    if not v126 then
        Utilities.GBWarn("No Gamebeast config found matching \"" .. tostring(v123[1]) .. "\"");

        return nil;
    end;

    local v127 = u11[v126];
    local v128 = p120 and v127.viewByPlayer[p120] or v127.serverView;

    for i = 2, #v123 do
        if type(v128) ~= "table" then
            return nil;
        end;

        local v129 = v123[i];

        if v128[v129] == nil then
            local v130 = tonumber(v129);

            if v130 ~= nil and v128[v130] ~= nil then
                v129 = v130;
            end;
        end;

        v128 = v128[v129];
        local _ = i;
    end;

    return v128;
end;

function u1.Init(u131) -- Line: 747
    -- upvalues: ServerGate (copy), u9 (copy), u2 (copy), GetClientPayload (copy)
    ServerGate:OnPlayerRemoved(function(p132: userdata) -- Line: 749
        -- upvalues: u9 (ref)
        local v133 = u9[p132];
        u9[p132] = nil;

        for _, v in v133 or {} do
            v:Disconnect();
        end;
    end);

    function u2.OnServerInvoke(p134: userdata) -- Line: 758
        -- upvalues: u131 (copy), GetClientPayload (ref)
        u131:WaitForConfigsReady();

        return GetClientPayload(p134);
    end;
end;

return u1;