 

 

local Layer = require(script.Parent.Layer);
local v1 = {};
local u2 = {};
local u3 = 0;

function v1.take(p4, p5, p6) -- Line: 35
    -- upvalues: u2 (copy), u3 (ref), Layer (copy)
    local v7 = u2[p4];

    while v7 and #v7 > 0 do
        local table_remove_ret = table.remove(v7);
        u3 = u3 - 1;

        if #v7 == 0 then
            u2[p4] = nil;
        end;

        if table_remove_ret.layer.gui.Parent and table_remove_ret.layer.quad.Parent then
            return table_remove_ret.layer;
        end;

        Layer.destroy(table_remove_ret.layer);
    end;

    return Layer.new(p5, p6);
end;

local function oldest() -- Line: 53
    -- upvalues: u2 (copy)
    local v8 = (1 / 0);
    local v9 = nil;

    for i, v in pairs(u2) do
        if v[1] and v[1].at < v8 then
            v8 = v[1].at;
            v9 = i;
        end;
    end;

    return v9;
end;

function v1.give(p10, p11) -- Line: 63
    -- upvalues: Layer (copy), u2 (copy), u3 (ref), oldest (copy)
    Layer.rest(p11);
    local v12 = u2[p10];

    if not v12 then
        v12 = {};
        u2[p10] = v12;
    end;

    local v13 = {
        layer = p11,
        at = os.clock()
    };
    table.insert(v12, v13);
    u3 = u3 + 1;

    while true do
        local v14 = u3 > 256 and oldest();

        if not v14 then
            break;
        end;

        local v15 = u2[v14];
        Layer.destroy(table.remove(v15, 1).layer);
        u3 = u3 - 1;

        if #v15 == 0 then
            u2[v14] = nil;
        end;
    end;
end;

function v1.drop(p16) -- Line: 86
    -- upvalues: u2 (copy), Layer (copy), u3 (ref)
    local v17 = u2[p16];

    if not v17 then
        return;
    end;

    u2[p16] = nil;

    for _, v in ipairs(v17) do
        Layer.destroy(v.layer);
        u3 = u3 - 1;
    end;
end;

function v1.sweep() -- Line: 98
    -- upvalues: u3 (ref), u2 (copy), Layer (copy)
    if u3 == 0 then
        return;
    end;

    local os_clock_ret = os.clock();

    for i, v in pairs(u2) do
        local v18 = i;
        local v19 = v;

        while v19[1] and os_clock_ret - v19[1].at > 20 do
            Layer.destroy(table.remove(v19, 1).layer);
            u3 = u3 - 1;
        end;

        if #v19 == 0 then
            u2[v18] = nil;
        end;
    end;
end;

function v1.flush() -- Line: 114
    -- upvalues: u2 (copy), Layer (copy), u3 (ref)
    for i, v in pairs(u2) do
        for _, v2 in ipairs(v) do
            Layer.destroy(v2.layer);
        end;

        u2[i] = nil;
    end;

    u3 = 0;
end;

function v1.kept() -- Line: 124
    -- upvalues: u3 (ref)
    return u3;
end;

return v1;