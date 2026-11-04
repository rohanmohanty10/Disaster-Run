 
 

local u1 = {
    ids = {}
};

local function normalize_ids(p2) -- Line: 8
    local v3 = {};

    if typeof(p2) ~= "table" then
        return v3;
    end;

    for _, v in p2 do
        local v4 = tonumber(v);

        if v4 and not table.find(v3, v4) then
            table.insert(v3, v4);
        end;
    end;

    return v3;
end;

function u1.set(p5) -- Line: 22
    -- upvalues: u1 (copy), normalize_ids (copy)
    u1.ids = normalize_ids(p5);
end;

function u1.get() -- Line: 26
    -- upvalues: u1 (copy)
    return u1.ids;
end;

function u1.has(p6: number?) -- Line: 30
    -- upvalues: u1 (copy)
    if typeof(p6) == "number" then
        return table.find(u1.ids, p6) ~= nil;
    end;

    return false;
end;

return u1;