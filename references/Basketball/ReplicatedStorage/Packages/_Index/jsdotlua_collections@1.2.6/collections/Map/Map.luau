 
 

local _G___DEV__ = _G.__DEV__;
local forEach = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("forEach"));
local map = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("map"));
local isArray = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("isArray"));
local u1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));
local u2 = {};

function u2.new(p3) -- Line: 23
    -- upvalues: isArray (copy), _G___DEV__ (copy), u1 (copy), u2 (copy)
    local v4 = nil;
    local v5 = nil;

    if p3 == nil then
        v4 = {};
        v5 = {};
    elseif isArray(p3) then
        if _G___DEV__ and (#p3 > 0 and typeof(p3[1]) ~= "table") then
            error("Value `" .. typeof(p3[1]) .. "` is not an entry object.\n Cannot create Map from {K, V} form, it must be { {K, V}... }");
        end;

        v4 = table.create(#p3);
        v5 = {};

        for _, v in p3 do
            local v6 = v[1];

            if _G___DEV__ and v6 == nil then
                error("cannot create Map from a table that isn\'t an array.");
            end;

            local v7 = v[2];

            if v5[v6] == nil then
                table.insert(v4, v6);
            end;

            v5[v6] = v7;
        end;
    elseif u1(p3, u2) then
        v4 = table.clone(p3._array);
        v5 = table.clone(p3._map);
    else
        error(("`%s` `%s` is not iterable, cannot make Map using it"):format(typeof(p3), (tostring(p3))));
    end;

    return setmetatable({
        size = #v4,
        _map = v5,
        _array = v4
    }, u2);
end;

function u2.set(p8, p9, p10) -- Line: 72
    if p8._map[p9] == nil then
        p8.size = p8.size + 1;
        table.insert(p8._array, p9);
    end;

    p8._map[p9] = p10;

    return p8;
end;

function u2.get(p11, p12) -- Line: 84
    return p11._map[p12];
end;

function u2.clear(p13) -- Line: 88
    local l_table = table;
    p13.size = 0;
    l_table.clear(p13._map);
    l_table.clear(p13._array);
end;

function u2.delete(p14, p15) -- Line: 95
    if p14._map[p15] == nil then
        return false;
    end;

    p14.size = p14.size - 1;
    p14._map[p15] = nil;
    local table_find_ret = table.find(p14._array, p15);

    if table_find_ret then
        table.remove(p14._array, table_find_ret);
    end;

    return true;
end;

function u2.forEach(u16, u17, u18) -- Line: 111
    -- upvalues: _G___DEV__ (copy), forEach (copy)
    if _G___DEV__ and typeof(u17) ~= "function" then
        error("callback is not a function");
    end;

    forEach(u16._array, function(p19) -- Line: 118
        -- upvalues: u16 (copy), u18 (copy), u17 (copy)
        local v20 = u16._map[p19];

        if u18 == nil then
            u17(v20, p19, u16);

            return;
        end;

        u17(u18, v20, p19, u16);
    end);
end;

function u2.has(p21, p22) -- Line: 129
    return p21._map[p22] ~= nil;
end;

function u2.keys(p23) -- Line: 133
    return p23._array;
end;

function u2.values(u24) -- Line: 137
    -- upvalues: map (copy)
    return map(u24._array, function(p25) -- Line: 138
        -- upvalues: u24 (copy)
        return u24._map[p25];
    end);
end;

function u2.entries(u26) -- Line: 143
    -- upvalues: map (copy)
    return map(u26._array, function(p27) -- Line: 144
        -- upvalues: u26 (copy)
        return { p27, u26._map[p27] };
    end);
end;

function u2.ipairs(p28) -- Line: 149
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        warn(debug.traceback(
            "`for _,_ in myMap:ipairs() do` is deprecated and will be removed in a future release, please use `for _,_ in myMap do` instead\n",
            2
        ));
    end;

    return ipairs(p28:entries());
end;

function u2.__iter(p29) -- Line: 161
    return next, p29:entries();
end;

function u2.__index(p30, p31) -- Line: 165
    -- upvalues: u2 (copy), _G___DEV__ (copy)
    local v32 = rawget(u2, p31);

    if v32 ~= nil then
        return v32;
    end;

    if _G___DEV__ then
        local v33 = rawget(p30, "_map");
        assert(v33, "Map has been corrupted, and is missing private state! Did you accidentally call table.clear() instead of map:clear()?");
    end;

    return u2.get(p30, p31);
end;

function u2.__newindex(p34, p35, p36) -- Line: 181
    p34:set(p35, p36);
end;

return u2;