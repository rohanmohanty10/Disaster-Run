  

 

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 4
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.Stack = {};
    v2.Cache = {};

    return v2;
end;

function u1.Update(p3) -- Line: 13
    table.clear(p3.Cache);

    for i, v in pairs(p3.Stack) do
        local v4, v5 = next(v);

        if v5 then
            table.insert(p3.Cache, {
                Name = v4,
                Value = v5,
                Priority = i
            });
        end;
    end;

    table.sort(p3.Cache, function(p6, p7) -- Line: 27
        return p6.Priority > p7.Priority;
    end);
end;

function u1.Add(p8, p9, p10, p11) -- Line: 32
    local v12 = p8.Stack[p10];

    if not v12 then
        p8.Stack[p10] = {};
        v12 = p8.Stack[p10];
    end;

    v12[p9] = p11;
    p8:Update();
end;

function u1.Remove(p13, p14) -- Line: 43
    for _, v in pairs(p13.Stack) do
        if v[p14] then
            v[p14] = nil;
        end;
    end;

    p13:Update();
end;

function u1.Get(p15, p16) -- Line: 53
    for i, v in pairs(p15.Cache) do
        if not p16 or v.Name == p16 then
            return v, i;
        end;
    end;
end;

function u1.GetIndex(p17, p18) -- Line: 61
    for i, v in pairs(p17.Cache) do
        if typeof(v.Value) == "table" and v.Value[p18] then
            return v.Value[p18], v, i;
        end;
    end;
end;

function u1.Find(p19, p20) -- Line: 71
    for i, v in pairs(p19.Cache) do
        if v.Name == p20 then
            return v, i;
        end;
    end;
end;

function u1.GetFirst(p21, p22) -- Line: 79
    return p21.Cache[1], 1;
end;

function u1.GetLast(p23, p24) -- Line: 83
    return p23.Cache[#p23.Cache], #p23.Cache;
end;

function u1.GetAll(p25) -- Line: 87
    return p25.Cache;
end;

function u1.Destroy(p26) -- Line: 91
    setmetatable(p26, nil);
end;

return u1;