  

 

local u1 = typeof;
local Methods = require(script.Methods);

function getProp(u2, u3)
    local success, result = pcall(function() -- Line: 13
        -- upvalues: u2 (copy), u3 (copy)
        return u2[u3];
    end);

    return success, result;
end;

function setProp(u4, u5, u6)
    return pcall(function() -- Line: 20
        -- upvalues: u4 (copy), u5 (copy), u6 (copy)
        u4[u5] = u6;
    end);
end;

function rawclear(p7)
    for i in pairs(p7) do
        rawset(p7, i, nil);
    end;
end;

function Wrap(u8)
    -- upvalues: u1 (copy), Methods (copy)
    if u1(u8) == "userdata" then
        warn("attempt to wrap an already wrapped object");

        return nil;
    end;

    local u9 = newproxy(true);
    local v10 = getmetatable(u9);
    local u11 = {
        _obj = u8,
        _methods = {}
    };

    for i, v in pairs(Methods) do
        u11._methods[i] = v;
    end;

    function v10.__index(p12, u13) -- Line: 47
        -- upvalues: u11 (copy), u9 (copy), u8 (copy)
        if u11[u13] then
            return u11[u13];
        end;

        if u11._methods[u13] then
            return function(...) -- Line: 52
                -- upvalues: u11 (ref), u13 (copy), u9 (ref)
                u11._methods[u13](u9, ...);
            end;
        end;

        local v14, u15 = getProp(u8, u13);

        if v14 then
            return typeof(u15) == "function" and function(...) -- Line: 59
                -- upvalues: u15 (copy), u8 (ref)
                return u15(u8, select(2, unpack({ ... })));
            end or u15;
        end;

        return nil;
    end;

    function v10.__newindex(p16, p17, p18) -- Line: 70
        -- upvalues: u8 (copy), u1 (ref), u11 (copy)
        if not getProp(u8, p17) then
            if typeof(p18) == "function" then
                rawset(u11._methods, p17, p18);

                return;
            end;

            rawset(u11, p17, p18);

            return;
        end;

        if u1(p18) ~= "Instance" and u1(p18) ~= "userdata" then
            setProp(u8, p17, p18);

            return;
        end;

        local v19 = setProp;

        if u1(p18) == "userdata" then
            p18 = p18._obj;
        end;

        v19(u8, p17, p18);
    end;

    function v10.__tostring(p20) -- Line: 87
        -- upvalues: u8 (copy)
        return u8.Name;
    end;

    function v10.__len(p21) -- Line: 91
        -- upvalues: u8 (copy)
        return #u8:GetChildren();
    end;

    return u9;
end;

function Unwrap(p22)
    local _obj = p22._obj;
    local v23 = getmetatable(p22);
    rawclear(v23);
    table.freeze(v23);

    return _obj;
end;

return function() -- Line: 108
    return { Wrap, Unwrap };
end;