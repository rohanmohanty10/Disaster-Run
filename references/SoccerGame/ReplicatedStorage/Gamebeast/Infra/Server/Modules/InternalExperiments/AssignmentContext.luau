  

local v1 = {};
local Players = game:GetService("Players");
local Utilities = require(script.Parent.Parent.Utilities);
local LocalizationCache = require(script.Parent.Parent.LocalizationCache);
local ServerClientInfoHandler = require(script.Parent.Parent.ServerClientInfoHandler);
local ServerGate = require(script.Parent.Parent.ServerGate);

local function GetClientReportedInfo(p2: userdata, p3: string) -- Line: 67
    -- upvalues: ServerClientInfoHandler (copy)
    ServerClientInfoHandler:WaitUntilClientInfoResolved(p2, 6);

    if ServerClientInfoHandler:IsClientInfoResolved(p2) then
        return ServerClientInfoHandler:GetClientInfo(p2, p3);
    end;

    return nil;
end;

local u9 = {
    inputType = function(p4) -- Line: 81, Name: inputType
        -- upvalues: GetClientReportedInfo (copy)
        return GetClientReportedInfo(p4, "inputType");
    end,

    device = function(p5) -- Line: 84, Name: device
        -- upvalues: GetClientReportedInfo (copy)
        return GetClientReportedInfo(p5, "device");
    end,

    deviceSubType = function(p6) -- Line: 87, Name: deviceSubType
        -- upvalues: GetClientReportedInfo (copy)
        return GetClientReportedInfo(p6, "deviceSubType");
    end,

    country = function(p7) -- Line: 90, Name: country
        -- upvalues: LocalizationCache (copy)
        return LocalizationCache:GetRegionId(p7);
    end,

    language = function(p8) -- Line: 93, Name: language
        -- upvalues: LocalizationCache (copy)
        return LocalizationCache:GetLocaleId(p8);
    end
};
local u10 = {
    inputType = true,
    device = true,
    deviceSubType = true
};
local u11 = {};
local u12 = {
    placeId = true,
    placeVersion = true
};
local u13 = {};
local u14 = {};

local function runBounded(u15: table) -- Line: 144
    -- upvalues: Utilities (copy)
    Utilities.waitForAnyCall({ function() -- Line: 146
            -- upvalues: Utilities (ref), u15 (copy)
            Utilities.waitForAllCalls(u15);
        end, function() -- Line: 149
            task.wait(6);
        end });
end;

local function splitPropertyPath(p16: string) -- Line: 159
    local string_match_ret, v17 = string.match(p16, "^([^%.]+)%.(.+)$");

    if string_match_ret and v17 then
        return string_match_ret, v17;
    end;

    return nil, p16;
end;

local function isScalar(p18) -- Line: 167
    local v19 = type(p18);

    if v19 == "string" or v19 == "boolean" then
        return true;
    end;

    if v19 ~= "number" then
        return false;
    end;

    local v20;

    if p18 == p18 and p18 ~= (1 / 0) then
        v20 = p18 ~= (-1 / 0);
    else
        v20 = false;
    end;

    return v20;
end;

local function validatePropertyValue(p21) -- Line: 182
    local v22 = type(p21);
    local v23;

    if v22 == "string" or v22 == "boolean" then
        v23 = true;
    elseif v22 == "number" and (p21 == p21 and p21 ~= (1 / 0)) then
        v23 = p21 ~= (-1 / 0);
    else
        v23 = false;
    end;

    if v23 then
        return true, nil;
    end;

    if type(p21) ~= "table" then
        return false, `unsupported type "{typeof(p21)}"`;
    end;

    local v24 = 0;
    local v25 = nil;

    for i, v in p21 do
        v24 = v24 + 1;

        if i ~= v24 then
            return false, "tables must be lists (sequential numeric keys)";
        end;

        local v26 = type(v);
        local v27;

        if v26 == "string" or v26 == "boolean" then
            v27 = true;
        elseif v26 == "number" and (v == v and v ~= (1 / 0)) then
            v27 = v ~= (-1 / 0);
        else
            v27 = false;
        end;

        if not v27 then
            return false, `list item {v24} has unsupported type "{typeof(v)}"`;
        end;

        v25 = v25 or type(v);

        if type(v) ~= v25 then
            return false, `lists must hold one type of value, but item {v24} is a {type(v)} in a list of {v25}s`;
        end;
    end;

    if v24 > 100 then
        return false, `lists may have at most {100} items`;
    end;

    return true, nil;
end;

local function setProperty(p28: table, p29: any, p30: any, p31: string) -- Line: 220
    -- upvalues: Utilities (copy), validatePropertyValue (copy)
    if type(p29) ~= "string" or #p29 == 0 then
        Utilities.GBWarn((`Experiment property keys must be non-empty strings ({p31}).`));

        return false;
    end;

    if #p29 > 128 then
        Utilities.GBWarn((`Ignoring experiment property "{string.sub(p29, 1, 32)}..." ({p31}): names may be at most {128} characters.`));

        return false;
    end;

    if p30 == nil then
        if p28[p29] == nil then
            return false;
        end;

        p28[p29] = nil;

        return true;
    end;

    local v32, v33 = validatePropertyValue(p30);

    if not v32 then
        Utilities.GBWarn((`Ignoring experiment property "{p29}" ({p31}): {v33}.`));

        return false;
    end;

    if Utilities.primativeDeepEqual(p28[p29], p30) then
        return false;
    end;

    if p28[p29] == nil then
        local v34 = 0;

        for _ in p28 do
            v34 = v34 + 1;
        end;

        if v34 >= 100 then
            Utilities.GBWarn((`Ignoring experiment property "{p29}" ({p31}): at most {100} properties can be set.`));

            return false;
        end;
    end;

    if type(p30) == "table" then
        p30 = table.clone(p30);
    end;

    p28[p29] = p30;

    return true;
end;

local function copyProperties(p35: table) -- Line: 266
    local v36 = {};

    for i, v in p35 do
        local v37;

        if type(v) == "table" then
            v37 = table.clone(v);
        else
            v37 = v;
        end;

        v36[i] = v37;
    end;

    return v36;
end;

local function buildContext(p38: table?, p39: table?) -- Line: 278
    -- upvalues: copyProperties (copy)
    local v40 = {};

    if p38 and next(p38) ~= nil then
        v40.roblox = p38;
    end;

    if p39 and next(p39) ~= nil then
        v40.properties = copyProperties(p39);
    end;

    if next(v40) == nil then
        return nil;
    end;

    return v40;
end;

function v1.SetPlayerProperties(p41: table, p42: userdata, p43: table) -- Line: 297
    -- upvalues: u13 (copy), setProperty (copy)
    if p42.Parent == nil then
        return false;
    end;

    local v44 = u13[p42];

    if not v44 then
        v44 = {};
        u13[p42] = v44;
    end;

    local v45 = false;

    for i, v in p43 do
        if setProperty(v44, i, v, (`player {p42.UserId}`)) then
            v45 = true;
        end;
    end;

    return v45;
end;

function v1.SetPlayerProperty(p46: table, p47: userdata, p48: string, p49: any) -- Line: 321
    -- upvalues: u13 (copy), setProperty (copy)
    if p47.Parent == nil then
        return false;
    end;

    local v50 = u13[p47];

    if not v50 then
        if p49 == nil then
            return false;
        end;

        v50 = {};
        u13[p47] = v50;
    end;

    return setProperty(v50, p48, p49, (`player {p47.UserId}`));
end;

function v1.GetPlayerProperties(p51: table, p52: userdata) -- Line: 338
    -- upvalues: copyProperties (copy), u13 (copy)
    return copyProperties(u13[p52] or {});
end;

function v1.SetServerProperties(p53: table, p54: table) -- Line: 345
    -- upvalues: setProperty (copy), u14 (copy)
    local v55 = false;

    for i, v in p54 do
        if setProperty(u14, i, v, "server") then
            v55 = true;
        end;
    end;

    return v55;
end;

function v1.SetServerProperty(p56: table, p57: string, p58: any) -- Line: 359
    -- upvalues: setProperty (copy), u14 (copy)
    return setProperty(u14, p57, p58, "server");
end;

function v1.GetServerProperties(p59) -- Line: 363
    -- upvalues: copyProperties (copy), u14 (copy)
    return copyProperties(u14);
end;

function v1.GetShared(p60) -- Line: 371
    -- upvalues: u14 (copy), copyProperties (copy)
    local v61 = {
        schemaVersion = 1,
        roblox = {
            placeId = game.PlaceId,
            placeVersion = game.PlaceVersion
        }
    };

    if next(u14) ~= nil then
        v61.properties = copyProperties(u14);
    end;

    return v61;
end;

function v1.GetForPlayers(p62: table, p63: table, p64: table) -- Line: 395
    -- upvalues: u10 (copy), Players (copy), u13 (copy), u9 (copy), u12 (copy), Utilities (copy), u14 (copy), runBounded (copy), buildContext (copy), ServerClientInfoHandler (copy)
    local v65 = {};
    local v66 = {};
    local v67 = false;

    for _, v in p64 do
        local string_match_ret, v68 = string.match(v, "^([^%.]+)%.(.+)$");

        if not (string_match_ret and v68) then
            v68 = v;
            string_match_ret = nil;
        end;

        if string_match_ret == "roblox" and u10[v68] then
            v67 = true;
            break;
        end;
    end;

    for _, v in p63 do
        local PlayerByUserId = Players:GetPlayerByUserId(v);

        if PlayerByUserId then
            local u69 = {};
            v65[v] = u69;
            local v70 = u13[PlayerByUserId];
            local v71 = v;

            for _, v2 in p64 do
                local string_match_ret, u72 = string.match(v2, "^([^%.]+)%.(.+)$");

                if not (string_match_ret and u72) then
                    u72 = v2;
                    string_match_ret = nil;
                end;

                if string_match_ret == "roblox" then
                    local u73 = u9[u72];

                    if u73 then
                        table.insert(v66, function() -- Line: 424
                            -- upvalues: u69 (copy), u72 (copy), u73 (copy), PlayerByUserId (copy)
                            u69[u72] = u73(PlayerByUserId);
                        end);
                    elseif not u12[u72] then
                        Utilities.GBLog((`Experiment targeting requires "{v2}", which this SDK does not report for players`));
                    end;
                elseif string_match_ret == "properties" and (not v70 or v70[u72] == nil) and u14[u72] == nil then
                    Utilities.GBLog((`Experiment targeting requires property "{u72}" which is not set for player {v71}`));
                end;
            end;
        end;
    end;

    runBounded(v66);
    local v74 = {};
    local v75 = {};

    for i, v in v65 do
        local PlayerByUserId = Players:GetPlayerByUserId(i);
        local v76;

        if PlayerByUserId then
            v76 = u13[PlayerByUserId];
        else
            v76 = nil;
        end;

        local v77 = buildContext(v, v76);

        if v77 then
            v75[i] = v77;
        end;

        if PlayerByUserId and (v67 and not ServerClientInfoHandler:IsClientInfoResolved(PlayerByUserId)) then
            table.insert(v74, PlayerByUserId);
        end;
    end;

    return v75, v74;
end;

function v1.GetForServer(p78: table, p79: table) -- Line: 463
    -- upvalues: u11 (copy), u12 (copy), Utilities (copy), u14 (copy), runBounded (copy), buildContext (copy)
    local u80 = {};
    local v81 = {};

    for _, v in p79 do
        local string_match_ret, u82 = string.match(v, "^([^%.]+)%.(.+)$");

        if not (string_match_ret and u82) then
            u82 = v;
            string_match_ret = nil;
        end;

        if string_match_ret == "roblox" then
            local u83 = u11[u82];

            if u83 then
                table.insert(v81, function() -- Line: 473
                    -- upvalues: u80 (copy), u82 (copy), u83 (copy)
                    u80[u82] = u83();
                end);
            elseif not u12[u82] then
                Utilities.GBLog((`Experiment targeting requires "{v}", which this SDK does not report for servers`));
            end;
        elseif string_match_ret == "properties" and u14[u82] == nil then
            Utilities.GBLog((`Experiment targeting requires server property "{u82}" which is not set`));
        end;
    end;

    runBounded(v81);

    return buildContext(u80, u14);
end;

ServerGate:OnPlayerRemoved(function(p84: userdata) -- Line: 491
    -- upvalues: u13 (copy)
    u13[p84] = nil;
end);

return v1;