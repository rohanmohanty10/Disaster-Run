 
 

local v1 = {};
local u2 = {};
local u3 = {};

function v1.add(p4) -- Line: 44
    -- upvalues: u2 (copy), u3 (copy)
    p4.ended = false;
    table.insert(u2, p4);

    for _, v in ipairs(u3) do
        v(p4);
    end;
end;

function v1.announce(p5) -- Line: 54
    -- upvalues: u3 (copy)
    if p5.ended then
        return;
    end;

    for _, v in ipairs(u3) do
        v(p5);
    end;
end;

function v1.remove(p6) -- Line: 63
    -- upvalues: u2 (copy)
    p6.ended = true;
    local table_find_ret = table.find(u2, p6);

    if table_find_ret then
        local v7 = #u2;
        u2[table_find_ret] = u2[v7];
        u2[v7] = nil;
    end;
end;

function v1.list() -- Line: 74
    -- upvalues: u2 (copy)
    return u2;
end;

function v1.onAdded(p8) -- Line: 80
    -- upvalues: u3 (copy)
    table.insert(u3, p8);
end;

local function isOver(p9) -- Line: 84
    local play = p9.play;

    return play == nil and true or play._released == true;
end;

function v1.timescale(p10) -- Line: 89
    if p10 ~= nil then
        local play = p10.play;

        if play ~= nil and play._released ~= true then
            return math.max(p10.timescale, 0);
        end;
    end;

    return 1;
end;

function v1.slowest(p11) -- Line: 96
    local v12 = 1;
    local v13 = 1;

    while v12 <= #p11 do
        local v14 = p11[v12];
        local play = v14.play;

        if play == nil and true or play._released == true then
            p11[v12] = p11[#p11];
            p11[#p11] = nil;
        else
            local math_max_ret = math.max(v14.timescale, 0);
            v13 = math.min(v13, math_max_ret);
            v12 = v12 + 1;
        end;
    end;

    return v13;
end;

function v1.clear() -- Line: 112
    -- upvalues: u2 (copy)
    for i = #u2, 1, -1 do
        u2[i].ended = true;
        u2[i] = nil;
        local _ = i;
    end;
end;

return v1;