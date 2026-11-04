 
 

local u1 = { { "SizeX", "SizeY", "SizeZ" }, { "RotSpeedX", "RotSpeedY", "RotSpeedZ" }, { "PosOffsetX", "PosOffsetY", "PosOffsetZ" }, { "RotX", "RotY", "RotZ" }, { "PosX", "PosY", "PosZ" } };
local u2 = {};
local u3 = {};
local u4 = { "SizeX", "SizeY", "SizeZ", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "PosOffsetX", "PosOffsetY", "PosOffsetZ" };

for _, v in ipairs(u1) do
    local v5 = {};

    for _, v2 in ipairs(v) do
        v5[v2] = true;
    end;

    for _, v2 in ipairs(v) do
        u2[v2] = v5;
    end;
end;

local function resolveAxisLink(p6, p7) -- Line: 27
    -- upvalues: u2 (copy)
    local v8;

    if p6 then
        v8 = p6[p7] or nil;
    else
        v8 = nil;
    end;

    if not (v8 and (v8 ~= "" and v8 ~= p7)) then
        return nil;
    end;

    local v9 = u2[p7];

    if not (v9 and v9[v8]) then
        return nil;
    end;

    local v10 = p6[v8];

    if v10 and (v10 ~= "" and (v10 ~= v8 and v9[v10])) then
        return nil;
    end;

    return v8;
end;

function u3.sanitize(p11) -- Line: 38
    -- upvalues: u1 (copy), u2 (copy)
    local v12 = {};

    for _, v in ipairs(u1) do
        for _, v2 in ipairs(v) do
            local v13;

            if p11 then
                v13 = p11[v2] or nil;
            else
                v13 = nil;
            end;

            if v13 and (v13 ~= "" and v13 ~= v2) then
                local v14 = u2[v2];

                if v14 and v14[v13] then
                    local v15 = p11[v13];

                    if v15 and (v15 ~= "" and (v15 ~= v13 and v14[v15])) then
                        v13 = nil;
                    end;
                else
                    v13 = nil;
                end;
            else
                v13 = nil;
            end;

            v12[v2] = v13;
        end;
    end;

    return v12;
end;

function u3.applyGraphAxisAliases(p16, p17, p18) -- Line: 46
    -- upvalues: u4 (copy)
    if not (p18 and (p16 and p17)) then
        return;
    end;

    for _, v in ipairs(u4) do
        local v19 = p18[v];

        if v19 and (v19 ~= v and (p16[v19] and p17[v19])) then
            p16[v] = p16[v19];
            p17[v] = p17[v19];
        end;
    end;
end;

function u3.sampleRangeAxes(p20, p21, p22, p23, p24) -- Line: 60
    local v25;

    if p24 then
        v25 = p24.EmitIndex;
    else
        v25 = p24;
    end;

    if p24 then
        p24 = p24.EmitCount;
    end;

    local v26;

    if v25 then
        if p24 then
            v26 = p24 > 0;
        else
            v26 = p24;
        end;
    else
        v26 = v25;
    end;

    local v27 = {};

    for _, v in ipairs(p22) do
        local v28;

        if p21 then
            v28 = p21[v];
        else
            v28 = p21;
        end;

        if not v28 then
            if p20[v .. "Even"] == true and v26 then
                local v29 = p20[v];
                v27[v] = v29.Min + (v29.Max - v29.Min) * (p24 == 1 and 0.5 or v25 / p24);
            else
                v27[v] = p23.RandomValueFromRange(p20[v]);
            end;
        end;
    end;

    for _, v in ipairs(p22) do
        if v27[v] == nil then
            local v30;

            if p21 then
                v30 = p21[v];
            else
                v30 = p21;
            end;

            v27[v] = v30 and v27[v30] or p23.RandomValueFromRange(p20[v]);
        end;
    end;

    return v27;
end;

function u3.refreshLoopGraphsAndSeeds(p31, p32, p33) -- Line: 90
    -- upvalues: u3 (copy)
    if not p31.Graphs then
        return;
    end;

    for i, _ in pairs(p31.Graphs) do
        if p32[i] ~= nil then
            p31.Graphs[i] = p32[i];
        end;
    end;

    if p31.Seeds then
        for i, _ in pairs(p31.Seeds) do
            if p31.Graphs[i] then
                p31.Seeds[i] = p33.GenerateSeed(p31.Graphs[i]);
            end;
        end;
    end;

    u3.applyGraphAxisAliases(p31.Graphs, p31.Seeds, p32.AxisLinks);
end;

return u3;