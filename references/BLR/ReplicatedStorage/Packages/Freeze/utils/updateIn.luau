  

local None = require(script.Parent.Parent.None);
local isDataStructure = require(script.Parent.Parent.utils.isDataStructure);
local slice = require(script.Parent.slice);
local get = require(script.Parent.get);
local remove = require(script.Parent:FindFirstChild("remove"));
local set = require(script.Parent.set);

local function toString(p1) -- Line: 12
    return table.concat(p1, ", ");
end;

local function updateInDeeply(p2: any, p3: table, p4: number, p5: function, p6: any) -- Line: 16
    -- upvalues: None (copy), isDataStructure (copy), slice (copy), get (copy), updateInDeeply (copy), remove (copy), set (copy)
    local v7 = p2 == None;

    if p4 == #p3 + 1 then
        if not v7 then
            p6 = p2;
        end;

        local v8 = p5(p6);

        if v8 == p6 then
            return p2;
        end;

        return v8;
    end;

    if not (v7 or isDataStructure(p2)) then
        local l_error = error;
        local v9 = slice(p3, 1, p4 - 1);
        l_error("Cannot update within non-data-structure value in path [" .. table.concat(v9, ", ") .. "]: " .. tostring(p2));
    end;

    local v10 = p3[p4];
    local v11;

    if v7 then
        v11 = None;
    else
        v11 = get(p2, v10, None);
    end;

    local v12 = updateInDeeply(v11, p3, p4 + 1, p5, p6);

    if v12 == v11 then
        return p2;
    end;

    if v12 == None then
        return remove(p2, v10);
    end;

    return set(v7 and {} or p2, v10, v12);
end;

return function(p13: table, p14: table, p15: function, p16: any) -- Line: 49
    -- upvalues: updateInDeeply (copy), None (copy)
    local v17 = updateInDeeply(p13, p14, 1, p15, p16);

    if v17 == None then
        return p16;
    end;

    return v17;
end;