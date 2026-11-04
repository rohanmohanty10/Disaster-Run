  

local v1 = {};
local Utilities = require(script.Parent.Utilities);

local function ApplyOperation(p2: table, p3: table) -- Line: 45
    -- upvalues: Utilities (copy)
    local path = p3.path;

    if #path == 0 then
        return;
    end;

    for i = 1, #path - 1 do
        p2 = p2[path[i]];

        if type(p2) ~= "table" or #p2 > 0 then
            return;
        end;

        local _ = i;
    end;

    local v4 = path[#path];

    if p3.op == "set" or p3.op == "add" then
        local v5;

        if type(p3.value) == "table" then
            v5 = Utilities.recursiveCopy(p3.value);
        else
            v5 = p3.value;
        end;

        p2[v4] = v5;

        return;
    end;

    if p3.op == "delete" then
        p2[v4] = nil;

        return;
    end;

    Utilities.GBWarn("Unknown changeset operation:", p3.op);
end;

function v1.apply(p6: table, p7: table) -- Line: 78
    -- upvalues: Utilities (copy), ApplyOperation (copy)
    if #p7 == 0 then
        return p6;
    end;

    local v8 = Utilities.recursiveCopy(p6);

    for _, v in p7 do
        for _, v2 in v.operations do
            ApplyOperation(v8, v2);
        end;
    end;

    return v8;
end;

return v1;