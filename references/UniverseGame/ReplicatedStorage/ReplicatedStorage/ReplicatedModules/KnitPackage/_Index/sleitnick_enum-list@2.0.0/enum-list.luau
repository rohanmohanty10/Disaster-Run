  

 

local u1 = newproxy();
local u2 = newproxy();

local function CreateEnumItem(p3, p4, p5) -- Line: 26
    local v6 = {
        Name = p3,
        Value = p4,
        EnumType = p5
    };
    table.freeze(v6);

    return v6;
end;

local u7 = {};
u7.__index = u7;

function u7.new(p8, p9) -- Line: 61
    -- upvalues: u7 (copy), u1 (copy), u2 (copy)
    local v10 = type(p8) == "string";
    assert(v10, "Name string required");
    local v11 = type(p9) == "table";
    assert(v11, "Enums table required");
    local v12 = setmetatable({}, u7);
    v12[u1] = {};
    v12[u2] = p8;

    for i, v in ipairs(p9) do
        local v13 = type(v) == "string";
        assert(v13, "Enum name must be a string");
        local v14 = {
            Name = v,
            Value = i,
            EnumType = v12
        };
        table.freeze(v14);
        v12[v] = v14;
        table.insert(v12[u1], v14);
    end;

    table.freeze(v12);

    return v12;
end;

function u7.BelongsTo(p15, p16) -- Line: 83
    local v17;

    if type(p16) == "table" then
        v17 = p16.EnumType == p15;
    else
        v17 = false;
    end;

    return v17;
end;

function u7.GetEnumItems(p18) -- Line: 93
    -- upvalues: u1 (copy)
    return p18[u1];
end;

function u7.GetName(p19) -- Line: 103
    -- upvalues: u2 (copy)
    return p19[u2];
end;

return u7;