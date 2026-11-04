 
 

local Shards = require(script.Parent.Shards);
local v1 = {};
local u2 = {};
local u3 = 0;
local u4 = 0;

local function keyOf(p5) -- Line: 42
    local size = p5.size;
    local string_format_ret = string.format("%.2f,%.2f,%.2f|%d|%.2f|%s%d|%d", size.X, size.Y, size.Z, p5.count, p5.reach, p5.face.axis, p5.face.side, p5.variant);

    for _, v in ipairs(p5.layers or {}) do
        string_format_ret = string_format_ret .. string.format("|%d:%.2f,%.2f,%.2f:%.2f,%.2f,%.2f", v.index, v.offset.X, v.offset.Y, v.offset.Z, v.size.X, v.size.Y, v.size.Z);
    end;

    return string_format_ret;
end;

local function remember(p6, p7) -- Line: 52
    -- upvalues: u4 (ref), u2 (ref), u3 (ref)
    u4 = u4 + 1;

    if not u2[p6] then
        u3 = u3 + 1;
    end;

    u2[p6] = {
        shards = p7,
        used = u4
    };

    while u3 > 12 do
        local v8 = (1 / 0);
        local v9 = nil;

        for i, v in pairs(u2) do
            if v.used < v8 then
                v8 = v.used;
                v9 = i;
            end;
        end;

        u2[v9] = nil;
        u3 = u3 - 1;
    end;
end;

function v1.cut(p10, u11) -- Line: 70
    -- upvalues: keyOf (copy), u2 (ref), u4 (ref), Shards (copy), remember (copy)
    local table_create_ret = table.create(#p10, false);
    local u12 = {};

    for i, v in ipairs(p10) do
        local v13;

        if v.whole then
            v13 = keyOf(v);
        else
            v13 = nil;
        end;

        local v14;

        if v13 then
            v14 = u2[v13];
        else
            v14 = v13;
        end;

        if v14 then
            u4 = u4 + 1;
            v14.used = u4;
            table_create_ret[i] = v14.shards;
        elseif v.count >= 2 then
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.Size = v.size;
            local seed = v.seed;

            if v13 then
                seed = (v.variant + 1) * 104729;
            end;

            local v15 = {
                loose = true,
                part = Part,
                key = Shards.key(Part, v.count, seed, v.hit, v.reach, false),
                count = v.count,
                seed = seed,
                hit = v.hit,
                reach = v.reach,
                face = v.face,
                line = v.line,
                bladeFrame = v.bladeFrame,
                bladeSize = v.bladeSize,
                ribbon = v.ribbon,
                ribbonFrame = v.ribbonFrame,
                always = v.always,
                slash = v.slash,
                mode = v.mode,
                stands = v.stands,
                layers = v.layers,
                place = v.frame,
                position = i,
                keep = v13
            };
            table.insert(u12, v15);
        end;
    end;

    Shards.prepare(u12, function() -- Line: 118
        -- upvalues: u12 (copy), Shards (ref), table_create_ret (copy), remember (ref), u11 (copy)
        for _, v in ipairs(u12) do
            local v16 = Shards.get(v.part, v.key) or false;
            table_create_ret[v.position] = v16;

            if v.keep and v16 then
                remember(v.keep, v16);
            end;

            v.part:Destroy();
        end;

        u11(table_create_ret);
    end);
end;

function v1.kept() -- Line: 131
    -- upvalues: u3 (ref)
    return u3;
end;

function v1.forget() -- Line: 135
    -- upvalues: u2 (ref), u3 (ref)
    u2 = {};
    u3 = 0;
end;

return v1;