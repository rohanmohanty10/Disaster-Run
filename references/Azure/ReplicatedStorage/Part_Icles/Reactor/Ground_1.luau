 
 

local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 33
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    v5.halfU = p2;
    v5.halfV = p3;
    v5.snap = p4;
    v5.rectangles = {};
    v5.owners = {};

    return v5;
end;

local function edgesOf(p6, p7, p8, p9) -- Line: 45
    local v10 = { -p9, p9 };

    for _, v in ipairs(p6.owners) do
        for _, v2 in ipairs(p6.rectangles[v]) do
            table.insert(v10, v2[p7]);
            table.insert(v10, v2[p8]);
        end;
    end;

    return v10;
end;

local function snapped(p11, p12, p13) -- Line: 57
    local v14 = p11;

    for _, v in ipairs(p12) do
        local math_abs_ret = math.abs(v - p11);

        if math_abs_ret < p13 then
            v14 = v;
            p13 = math_abs_ret;
        end;
    end;

    return v14;
end;

local function cuts(p15, p16, p17) -- Line: 72
    local v18 = { p16, p17 };

    for _, v in ipairs(p15) do
        if p16 < v and v < p17 then
            table.insert(v18, v);
        end;
    end;

    table.sort(v18);
    local v19 = {};
    local v20 = {};

    for _, v in ipairs(v18) do
        if v19[#v19] ~= v then
            table.insert(v19, v);
            v20[v] = #v19;
        end;
    end;

    return v19, v20;
end;

local function freeIn(p21, p22, p23, p24, p25, p26) -- Line: 94
    -- upvalues: cuts (copy), edgesOf (copy)
    local v27, v28 = cuts(edgesOf(p21, "minU", "maxU", p21.halfU), p22, p24);
    local v29, v30 = cuts(edgesOf(p21, "minV", "maxV", p21.halfV), p23, p25);
    local v31 = #v27 - 1;
    local v32 = #v29 - 1;
    local v33 = {};

    for _, v in ipairs(p21.owners) do
        for _, v2 in ipairs(p26 and p26[v] and {} or p21.rectangles[v]) do
            local v34;

            if v2.minU < p24 and (p22 < v2.maxU and v2.minV < p25) then
                v34 = p23 < v2.maxV;
            else
                v34 = false;
            end;

            if v34 then
                local v35 = v28[math.max(v2.minU, p22)];
                local v36 = v28[math.min(v2.maxU, p24)] - 1;

                for i = v30[math.max(v2.minV, p23)], v30[math.min(v2.maxV, p25)] - 1 do
                    local v37 = i;

                    for i2 = v35, v36 do
                        v33[(v37 - 1) * v31 + i2] = true;
                        local _ = i2;
                    end;
                end;
            end;
        end;
    end;

    local v38 = {};

    for i = 1, v32 do
        local v39 = i;

        for i2 = 1, v31 do
            local v40;

            if v33[(v39 - 1) * v31 + i2] then
                v40 = i2;
            else
                v40 = i2;
                local v41 = v40;
                local v42 = v40;
                v40 = v41;
                v42 = v41;

                while v41 < v31 and not v33[(v39 - 1) * v31 + v41 + 1] do
                    v41 = v41 + 1;
                end;

                local v43 = v39;
                local v44 = true;

                while v44 and v39 < v32 do
                    for i3 = v40, v41 do
                        if v33[v39 * v31 + i3] then
                            v44 = false;
                            break;
                        end;

                        local _ = i3;
                    end;

                    if v44 then
                        v39 = v39 + 1;
                    end;
                end;

                for i3 = v43, v39 do
                    local v45 = i3;

                    for i4 = v40, v41 do
                        v33[(v45 - 1) * v31 + i4] = true;
                        local _ = i4;
                    end;
                end;

                table.insert(v38, {
                    minU = v27[v40],
                    minV = v29[v43],
                    maxU = v27[v41 + 1],
                    maxV = v29[v39 + 1]
                });
                v39 = v43;
            end;
        end;
    end;

    return v38;
end;

function u1.claim(p46, p47, p48, p49, p50) -- Line: 155
    return p46:claimArea(p47, p48 - p50, p49 - p50, p48 + p50, p49 + p50);
end;

function u1.claimArea(p51, p52, p53, p54, p55, p56) -- Line: 159
    -- upvalues: edgesOf (copy), snapped (copy), freeIn (copy)
    local snap = p51.snap;
    local v57 = edgesOf(p51, "minU", "maxU", p51.halfU);
    local v58 = edgesOf(p51, "minV", "maxV", p51.halfV);
    local v59 = snapped(math.max(p53, -p51.halfU), v57, snap);
    local v60 = snapped(math.min(p55, p51.halfU), v57, snap);
    local v61 = snapped(math.max(p54, -p51.halfV), v58, snap);
    local v62 = snapped(math.min(p56, p51.halfV), v58, snap);

    if v60 - v59 < snap or v62 - v61 < snap then
        return {};
    end;

    local v63 = freeIn(p51, v59, v61, v60, v62);

    if #v63 == 0 then
        return v63;
    end;

    local v64 = p51.rectangles[p52];

    if v64 then
        for _, v in ipairs(v63) do
            table.insert(v64, v);
        end;

        return v63;
    end;

    p51.rectangles[p52] = v63;
    table.insert(p51.owners, p52);

    return v63;
end;

function u1.release(p65, p66) -- Line: 186
    if not p65.rectangles[p66] then
        return;
    end;

    p65.rectangles[p66] = nil;
    table.remove(p65.owners, table.find(p65.owners, p66));
end;

function u1.held(p67, p68) -- Line: 194
    return p67.rectangles[p68];
end;

function u1.touching(p69, p70, p71, p72, p73) -- Line: 198
    local v74 = {};

    for _, v in ipairs(p69.owners) do
        local v75 = v;

        for _, v2 in ipairs(p69.rectangles[v]) do
            if v2.minU < p72 and (p70 < v2.maxU and (v2.minV < p73 and p71 < v2.maxV)) then
                table.insert(v74, v75);
                break;
            end;
        end;
    end;

    return v74;
end;

function u1.remainder(p76, p77) -- Line: 211
    -- upvalues: freeIn (copy)
    return freeIn(p76, -p76.halfU, -p76.halfV, p76.halfU, p76.halfV, p77);
end;

function u1.isWhole(p78) -- Line: 215
    return #p78.owners == 0;
end;

return u1;