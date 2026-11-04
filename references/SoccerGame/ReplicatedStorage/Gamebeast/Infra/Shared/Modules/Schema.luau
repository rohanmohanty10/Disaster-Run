  

local u1 = {};
u1.__index = u1;

function u1.new(p2: table) -- Line: 33
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);

    for _, v in p2 do
        if type(v.type) == "string" then
            v.type = { v.type };
        end;

        local v4 = {};

        for _, v2 in ipairs(v.type) do
            v4[v2] = true;
        end;

        v.type = v4;
    end;

    v3._structure = p2;

    return v3;
end;

function u1.GetDefault(p5) -- Line: 56
    local v6 = {};

    for i, v in pairs(p5._structure) do
        if type(v.default) == "function" then
            v6[i] = v.default();
        else
            v6[i] = v.default;
        end;
    end;

    return v6;
end;

function u1.GetDefaultForKey(p7: table, p8: string) -- Line: 70
    local v9 = p7._structure[p8];

    if not v9 then
        error("Key \'" .. p8 .. "\' does not exist in schema.");
    end;

    if type(v9.default) == "function" then
        return v9.default();
    end;

    return v9.default;
end;

function u1.HasKey(p10: table, p11: string) -- Line: 83
    return p10._structure[p11] ~= nil;
end;

function u1.MatchesType(p12: table, p13: string, p14: any) -- Line: 88
    local v15 = p12._structure[p13];
    local v16;

    if v15 == nil then
        v16 = false;
    else
        v16 = v15.type[type(p14)] == true;
    end;

    return v16;
end;

function u1.Sanitize(p17: table, p18: table) -- Line: 93
    for i, v in pairs(p18) do
        if p17._structure[i] == nil then
            p18[i] = nil;
        elseif not p17._structure[i].type[type(v)] then
            p18[i] = nil;
        end;
    end;

    return p18;
end;

function u1.Destroy(p19) -- Line: 108
end;

return u1;