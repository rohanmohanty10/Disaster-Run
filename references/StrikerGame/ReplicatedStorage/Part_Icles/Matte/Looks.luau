 

 

local v1 = {};
local u2 = {};
local u3 = 0;

function v1.take(p4, p5) -- Line: 34
    -- upvalues: u2 (copy), u3 (ref)
    local v6 = u2[p4];

    if v6 then
        v6.at = os.clock();
        local v7 = v6.lists[p5];

        if v7 then
            v7 = table.remove(v7);
        end;

        if v7 then
            u3 = u3 - 1;

            return v7;
        end;
    end;

    local v8 = p5:Clone();
    v8.Archivable = false;

    return v8;
end;

function v1.give(p9, p10, p11) -- Line: 50
    -- upvalues: u2 (copy), u3 (ref)
    p11.Parent = nil;
    local v12 = u2[p9];

    if not v12 then
        v12 = {
            at = 0,
            lists = {}
        };
        u2[p9] = v12;
    end;

    v12.at = os.clock();
    local v13 = v12.lists[p10];

    if not v13 then
        v13 = {};
        v12.lists[p10] = v13;
    end;

    if #v13 >= 96 then
        p11:Destroy();

        return;
    end;

    table.insert(v13, p11);
    u3 = u3 + 1;
end;

local function empty(p14) -- Line: 71
    -- upvalues: u3 (ref)
    for _, v in pairs(p14.lists) do
        for _, v2 in ipairs(v) do
            v2:Destroy();
            u3 = u3 - 1;
        end;
    end;
end;

function v1.drop(p15) -- Line: 80
    -- upvalues: u2 (copy), empty (copy)
    local v16 = u2[p15];

    if v16 then
        u2[p15] = nil;
        empty(v16);
    end;
end;

function v1.sweep() -- Line: 88
    -- upvalues: u3 (ref), u2 (copy), empty (copy)
    if u3 == 0 then
        return;
    end;

    local os_clock_ret = os.clock();

    for i, v in pairs(u2) do
        if os_clock_ret - v.at > 20 then
            u2[i] = nil;
            empty(v);
        end;
    end;
end;

function v1.flush() -- Line: 101
    -- upvalues: u2 (copy), empty (copy), u3 (ref)
    for i, v in pairs(u2) do
        u2[i] = nil;
        empty(v);
    end;

    u3 = 0;
end;

function v1.kept() -- Line: 109
    -- upvalues: u3 (ref)
    return u3;
end;

return v1;