 

 

local Shared = script.Parent.Parent.Shared;
local Warn = require(script.Parent.Warn);
require(Shared.Types);
local Holder = require(Shared.Holder);
local u1 = {};

local function GetIdFrom(p2) -- Line: 15
    -- upvalues: Holder (copy)
    if typeof(p2) == "number" then
        return p2;
    end;

    if typeof(p2) == "table" then
        return p2.id;
    end;

    if typeof(p2) ~= "Instance" then
        return nil;
    end;

    if p2:IsA("Player") then
        local EntityFromPlayer = Holder.GetEntityFromPlayer(p2);

        return EntityFromPlayer and EntityFromPlayer.id or nil;
    end;

    if not p2:IsA("Model") then
        return nil;
    end;

    local EntityFromModel = Holder.GetEntityFromModel(p2);

    return EntityFromModel and EntityFromModel.id or nil;
end;

local function CompileRule(p3: table) -- Line: 41
    local filterType = p3.filterType;
    local u4 = {};

    for _, v in p3.filterPlayers or {} do
        u4[v] = true;
    end;

    return filterType == "exclude" and (next(u4) == nil and function() -- Line: 52
        return true;
    end or function(p5: any, p6: userdata) -- Line: 57
        -- upvalues: u4 (copy)
        return u4[p6] ~= true;
    end) or (next(u4) == nil and function() -- Line: 62
        return false;
    end or function(p7: any, p8: userdata) -- Line: 67
        -- upvalues: u4 (copy)
        return u4[p8] == true;
    end);
end;

return {
    SetReplicationRule = function(p9, p10) -- Line: 73, Name: SetReplicationRule
        -- upvalues: GetIdFrom (copy), Warn (copy), u1 (copy), CompileRule (copy)
        local v11 = GetIdFrom(p9);

        if not v11 then
            Warn.low("no id", p9);

            return;
        end;

        if p10 == nil then
            u1[v11] = nil;

            return;
        end;

        if typeof(p10) == "function" then
            u1[v11] = p10;

            return;
        end;

        u1[v11] = CompileRule(p10);
    end,

    Allows = function(p12: any, p13: userdata) -- Line: 96, Name: Allows
        -- upvalues: u1 (copy), Holder (copy)
        local v14 = u1[p12.id];

        if not v14 then
            return true;
        end;

        local EntityFromPlayer = Holder.GetEntityFromPlayer(p13);

        return v14(p12, p13, EntityFromPlayer and EntityFromPlayer.id or nil);
    end,

    Include = function(p15: table) -- Line: 108, Name: Include
        -- upvalues: CompileRule (copy)
        return CompileRule({
            filterType = "include",
            filterPlayers = p15
        });
    end,

    Exclude = function(p16: table) -- Line: 112, Name: Exclude
        -- upvalues: CompileRule (copy)
        return CompileRule({
            filterType = "exclude",
            filterPlayers = p16
        });
    end
};