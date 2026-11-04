 

 

local function waitForDependency(p1: userdata, p2: string) -- Line: 7
    local v3 = p1:WaitForChild(p2, 30);
    local v4 = "[GA] Missing SDK dependency " .. p1:GetFullName() .. "." .. p2 .. " after 30s; install the complete GA package.";
    assert(v3, v4);

    return v3;
end;

local l_require = require;
local script_Parent = script.Parent;
local Types = script_Parent:WaitForChild("Types", 30);
local v5 = "[GA] Missing SDK dependency " .. script_Parent:GetFullName() .. ".Types after 30s; install the complete GA package.";
assert(Types, v5);
local u6 = l_require(Types);
local l_require2 = require;
local script_Parent2 = script.Parent;
local Config = script_Parent2:WaitForChild("Config", 30);
local v7 = "[GA] Missing SDK dependency " .. script_Parent2:GetFullName() .. ".Config after 30s; install the complete GA package.";
assert(Config, v7);
local u8 = l_require2(Config);
local v9 = {};
local u10 = {
    kind = true,
    name = true,
    rarity = true,
    guid = true
};

local function validateTradeItems(p11) -- Line: 21
    -- upvalues: u10 (copy), u8 (copy)
    if type(p11) ~= "table" then
        return false;
    end;

    local v12 = 0;

    for i, v in p11 do
        v12 = v12 + 1;

        if v12 > 200 or (type(i) ~= "number" or (i % 1 ~= 0 or (i < 1 or i > 200))) then
            return false;
        end;

        if type(v) ~= "table" then
            return false;
        end;

        local v13 = 0;

        for i2, v2 in v do
            v13 = v13 + 1;

            if v13 > 4 or not (u10[i2] and (type(v2) == "string" and (#v2 ~= 0 and #v2 <= u8.DEFAULT.MAX_PROPERTY_VALUE_LENGTH))) then
                return false;
            end;
        end;

        if v13 ~= 4 then
            return false;
        end;
    end;

    for i = 1, v12 do
        if p11[i] == nil then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

local function validateProperties(p14: table, p15: boolean) -- Line: 72
    -- upvalues: u8 (copy), validateTradeItems (copy)
    if p14 == nil then
        return true, nil;
    end;

    if typeof(p14) ~= "table" then
        return false, "properties must be a table";
    end;

    local v16 = 0;

    for i, v in p14 do
        v16 = v16 + 1;

        if u8.DEFAULT.MAX_PROPERTIES < v16 then
            return false, `too many properties (max {u8.DEFAULT.MAX_PROPERTIES})`;
        end;

        if typeof(i) ~= "string" then
            return false, "property keys must be strings";
        end;

        if #i > u8.DEFAULT.MAX_PROPERTY_KEY_LENGTH then
            return false, `property key too long: "{i}" (max {u8.DEFAULT.MAX_PROPERTY_KEY_LENGTH})`;
        end;

        if p15 and (i == "gaveItems" or i == "receivedItems") then
            if not validateTradeItems(v) then
                return false, "trade items require dense arrays of at most 200 item records";
            end;
        else
            local v17 = typeof(v);

            if v17 ~= "string" and (v17 ~= "boolean" and v17 ~= "number") then
                return false, "properties must contain scalar values";
            end;

            if v17 == "number" and (v ~= v or math.abs(v) == (1 / 0)) then
                return false, "properties must contain finite numbers";
            end;

            if typeof(v) == "string" and #v > u8.DEFAULT.MAX_PROPERTY_VALUE_LENGTH then
                return false, `property value too long for key "{i}" (max {u8.DEFAULT.MAX_PROPERTY_VALUE_LENGTH})`;
            end;
        end;
    end;

    return true, nil;
end;

local u27 = {
    [u6.EventType.SESSION_START] = function(p18) -- Line: 123
        return true, nil;
    end,

    [u6.EventType.SESSION_END] = function(p19) -- Line: 127
        if typeof(p19.sessionDuration) ~= "number" then
            return false, "session_end requires sessionDuration (number)";
        end;

        if p19.sessionDuration < 0 then
            return false, "sessionDuration must be non-negative";
        end;

        return true, nil;
    end,

    [u6.EventType.CUSTOM] = function(p20) -- Line: 139
        -- upvalues: validateTradeItems (copy)
        if typeof(p20.eventName) ~= "string" or #p20.eventName == 0 then
            return false, "custom_event requires eventName (non-empty string)";
        end;

        if p20.eventName == "trade_completed" then
            if type(p20.tradeId) ~= "string" or (p20.tradeId == "" or (type(p20.otherUserId) ~= "string" or (p20.otherUserId == "" or type(p20.simulated) ~= "boolean"))) then
                return false, "trade_completed requires tradeId, otherUserId and simulated";
            end;

            for _, v in { "gave", "received" } do
                local v21 = p20[v .. "Items"];
                local v22 = p20[v .. "Coins"];

                if not (validateTradeItems(v21) and (p20[v .. "ItemCount"] == #v21 and (type(v22) == "number" and v22 >= 0))) then
                    return false, "trade_completed requires matching item counts and nonnegative coins";
                end;
            end;
        end;

        return true, nil;
    end,

    [u6.EventType.PROGRESSION] = function(p23) -- Line: 172
        -- upvalues: u6 (copy)
        if not u6._validProgressionStatuses[p23.status] then
            return false, "progression_event requires status (start/complete/fail)";
        end;

        if typeof(p23.level) ~= "string" or #p23.level == 0 then
            return false, "progression_event requires level (non-empty string)";
        end;

        if p23.score == nil or typeof(p23.score) == "number" then
            return true, nil;
        end;

        return false, "progression_event score must be a number";
    end,

    [u6.EventType.ECONOMY] = function(p24) -- Line: 188
        -- upvalues: u6 (copy)
        if not u6._validEconomyFlows[p24.flow] then
            return false, "economy_event requires flow (source/sink)";
        end;

        if typeof(p24.currency) ~= "string" or #p24.currency == 0 then
            return false, "economy_event requires currency (non-empty string)";
        end;

        if typeof(p24.amount) ~= "number" then
            return false, "economy_event requires amount (number)";
        end;

        if p24.itemId ~= nil and typeof(p24.itemId) ~= "string" then
            return false, "economy_event itemId must be a string";
        end;

        if p24.source == nil or typeof(p24.source) == "string" then
            return true, nil;
        end;

        return false, "economy_event source (category) must be a string";
    end,

    [u6.EventType.INTERACTION] = function(p25) -- Line: 212
        if typeof(p25.action) ~= "string" or #p25.action == 0 then
            return false, "interaction_event requires action (non-empty string)";
        end;

        if p25.target ~= nil and typeof(p25.target) ~= "string" then
            return false, "interaction_event target must be a string";
        end;

        if p25.value == nil or typeof(p25.value) == "number" then
            return true, nil;
        end;

        return false, "interaction_event value must be a number";
    end,

    [u6.EventType.BUSINESS] = function(p26) -- Line: 228
        -- upvalues: u6 (copy)
        if not u6._validBusinessTypes[p26.businessType] then
            return false, "business_event requires businessType (gamepass/dev_product/premium)";
        end;

        if typeof(p26.productId) ~= "string" or #p26.productId == 0 then
            return false, "business_event requires productId (non-empty string)";
        end;

        if typeof(p26.amount) ~= "number" then
            return false, "business_event requires amount (number, Robux)";
        end;

        if p26.receiptId == nil or typeof(p26.receiptId) == "string" then
            return true, nil;
        end;

        return false, "business_event receiptId must be a string";
    end
};

function v9.validate(p28: string, p29: table) -- Line: 253
    -- upvalues: u6 (copy), validateProperties (copy), u27 (copy)
    if typeof(p28) ~= "string" or not u6._validEventTypes[p28] then
        return false, `invalid eventType: "{tostring(p28)}"`;
    end;

    if p29 ~= nil and typeof(p29) ~= "table" then
        return false, "properties must be a table or nil";
    end;

    local v30 = p29 or {};
    local v31;

    if p28 == u6.EventType.CUSTOM then
        v31 = v30.eventName == "trade_completed";
    else
        v31 = false;
    end;

    local v32, v33 = validateProperties(v30, v31);

    if not v32 then
        return false, v33;
    end;

    local v34 = u27[p28];

    if v34 then
        return v34(v30);
    end;

    return true, nil;
end;

return v9;