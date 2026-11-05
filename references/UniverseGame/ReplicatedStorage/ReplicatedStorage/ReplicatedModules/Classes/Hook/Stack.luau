  

 

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 6
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.Stack = {};
    v2.Cache = {};

    return v2;
end;

function u1.Update(p3) -- Line: 23
    table.clear(p3.Cache);

    for i, v in pairs(p3.Stack) do
        for i2, v2 in pairs(v) do
            table.insert(p3.Cache, {
                Name = i2,
                Value = v2,
                Priority = i
            });
        end;
    end;

    table.sort(p3.Cache, function(p4, p5) -- Line: 36
        return p4.Priority > p5.Priority;
    end);
end;

function u1.Add(p6, p7, p8, p9) -- Line: 43
    local v10 = p6.Stack[p8];

    if not v10 then
        p6.Stack[p8] = {};
        v10 = p6.Stack[p8];
    end;

    v10[p7] = p9;
    p6:Update();
end;

function u1.Remove(p11, p12) -- Line: 56
    for _, v in pairs(p11.Stack) do
        if v[p12] then
            v[p12] = nil;
        end;
    end;

    p11:Update();
end;

function u1.Get(p13, p14) -- Line: 66
    for _, v in pairs(p13.Stack) do
        if v[p14] then
            return v[p14];
        end;
    end;
end;

function u1.GetAll(p15) -- Line: 74
    return p15.Cache;
end;

function u1.PrintOrder(p16, p17) -- Line: 78
    local v18 = "";

    for i, v in ipairs(p16.Cache) do
        local v19;

        if i == #p16.Cache then
            v19 = v.Name;
        else
            v19 = v.Name .. " > ";
        end;

        v18 = v18 .. v19;
    end;

    warn(p17 .. " : " .. v18);
end;

function u1.Destroy(p20) -- Line: 86
    table.clear(p20.Cache);
    table.clear(p20.Stack);
end;

return u1;