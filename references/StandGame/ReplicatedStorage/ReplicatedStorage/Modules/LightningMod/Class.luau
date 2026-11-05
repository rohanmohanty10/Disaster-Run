 

 

local u5 = {
    __index = function(p1, p2) --[[ Name: __index, Line 75 ]]
        for v3, v4 in pairs(p1) do
            if v3 ~= "__isparenttable" and v4[p2] then
                return v4[p2];
            end;
        end;
        return nil;
    end
};
class = setmetatable({
    __baseclass = {}
}, {
    __index = function(p6, p7) --[[ Name: __index, Line 28 ]]
        if rawget(p6, "__baseclass") then
            return p6.__baseclass[p7];
        else
            return nil;
        end;
    end,
    __call = function(p8, ...) --[[ Name: __call, Line 35 ]]
        return p8:new(...);
    end,
    __add = function(p9, p10) --[[ Name: __add, Line 39 ]]
        return p9:addparent(p10);
    end,
    __eq = function(p11, p12) --[[ Name: __eq, Line 43 ]]
        if not p12.__baseclass or p12.__baseclass ~= p11.__baseclass then
            return false;
        end;
        for v13, _ in pairs(p11) do
            if not p12[v13] then
                return false;
            end;
        end;
        for v14, _ in pairs(p12) do
            if not p11[v14] then
                return false;
            end;
        end;
        return true;
    end,
    __lt = function(p15, p16) --[[ Name: __lt, Line 58 ]]
        if not p16.__baseclass then
            return false;
        end;
        if rawget(p16.__baseclass, "__isparenttable") then
            for _, v17 in pairs(p16.__baseclass) do
                if p15 == v17 or getmetatable(p15).__lt(p15, v17) then
                    return true;
                end;
            end;
        elseif p15 == p16.__baseclass or getmetatable(p15).__t(p15, p16.__baseclass) then
            return true;
        end;
        return false;
    end,
    __le = function(p18, p19) --[[ Name: __le, Line 70 ]]
        return p18 < p19 and true or p18 == p19;
    end
});
function class.new(p20, ...) --[[ Line: 86 ]]
    local v21 = {
        __baseclass = p20
    };
    local v22 = getmetatable(p20);
    setmetatable(v21, v22);
    if v21.init then
        v21:init(...);
    end;
    return v21;
end;
function class.convert(p23, p24) --[[ Line: 96 ]]
    p24.__baseclass = p23;
    local v25 = getmetatable(p23);
    setmetatable(p24, v25);
    return p24;
end;
function class.addparent(p26, ...) --[[ Line: 102 ]]
    -- upvalues: u5 (copy)
    if rawget(p26.__baseclass, "__isparenttable") then
        for _, v27 in ipairs({ ... }) do
            table.insert(p26.__baseclass, v27);
        end;
        return p26;
    else
        p26.__baseclass = setmetatable({
            __isparenttable = true,
            p26.__baseclass,
            ...
        }, u5);
        return p26;
    end;
end;
function class.setmetamethod(p28, p29, p30) --[[ Line: 114 ]]
    local v31 = getmetatable(p28);
    local v32 = {};
    for v33, v34 in pairs(v31) do
        v32[v33] = v34;
    end;
    v32[p29] = p30;
    setmetatable(p28, v32);
end;
return class;