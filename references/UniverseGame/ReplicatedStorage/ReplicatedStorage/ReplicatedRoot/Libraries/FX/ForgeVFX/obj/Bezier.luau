  

 

local function cubicBezier(p1, p2, p3, p4, p5) -- Line: 11
    return (1 - p5) ^ 3 * p1 + 3 * (1 - p5) ^ 2 * p5 * p2 + 3 * (1 - p5) * p5 ^ 2 * p3 + p5 ^ 3 * p4;
end;

local function cubicBezierDerivative(p6, p7, p8, p9, p10) -- Line: 16
    return 3 * (1 - p10) ^ 2 * (p7 - p6) + 6 * (1 - p10) * p10 * (p8 - p7) + 3 * p10 ^ 2 * (p9 - p8);
end;

local u11 = {};
u11.__index = u11;

function u11.new(p12, p13) -- Line: 34
    -- upvalues: u11 (copy)
    local v14 = setmetatable({}, u11);
    v14.points = p12;
    v14.accuracy = p13 or 20;
    v14.point_count = 0;
    v14.cumulative_lengths = {};
    v14:_recalculate();

    return v14;
end;

function u11.setPoints(p15, p16) -- Line: 48
    p15.points = p16;
    p15.ease_lut = nil;
    p15:_recalculate();
end;

function u11.getSegmentPoints(p17, p18) -- Line: 55
    if p18 < 1 or p17.point_count - 1 < p18 then
        if p18 <= 0 then
            return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0);
        end;

        error("attempt to get a non-existent segment at index " .. p18);
    end;

    local v19 = (p18 - 1) * 4 - math.max(p18 - 2, 0);
    local v20 = math.max(v19, 1);

    return p17.points[v20], p17.points[v20 + 1], p17.points[v20 + 2], p17.points[v20 + 3];
end;

function u11.forSample(p21, p22, p23) -- Line: 75
    local v24 = p21.length // p22;

    if v24 == 0 then
        return;
    end;

    for i = 0, v24 do
        p23(p21:getPositionArcSpace(i / v24), i);
    end;
end;

function u11.getPosition(p25, p26) -- Line: 88
    local v27, v28 = p25:getSegmentIndex(p26);
    local v29, v30, v31, v32 = p25:getSegmentPoints(v27);

    return (1 - v28) ^ 3 * v29 + 3 * (1 - v28) ^ 2 * v28 * v30 + 3 * (1 - v28) * v28 ^ 2 * v31 + v28 ^ 3 * v32;
end;

function u11.getSegmentIndex(p33, p34) -- Line: 95
    local v35 = math.clamp(p34, 0, 1);
    local v36 = p33.point_count - 1;
    local v37 = v35 * v36;
    local v38 = math.floor(v37) + 1;
    local v39 = math.min(v38, v36);
    local v40 = v37 - math.floor(v37);

    return v39, v35 == 1 and 1 or v40;
end;

function u11.getEasedSegmentIndex(p41, p42) -- Line: 112
    local v43 = p41.point_count - 1;

    for i = 1, v43 do
        local v44, _, _, v45 = p41:getSegmentPoints(i);
        local x = v44.x;
        local x2 = v45.x;

        if x <= p42 and p42 < x2 then
            return i, (p42 - x) / (x2 - x);
        end;
    end;

    return v43, 1;
end;

function u11._getEaseRaw(p46, p47) -- Line: 133
    local v48, v49 = p46:getEasedSegmentIndex(p47);
    local v50, v51, v52, v53 = p46:getSegmentPoints(v48);

    for _ = 1, 5 do
        local x = v51.x;
        local x2 = v52.x;
        local v54 = 3 * (1 - v49) ^ 2 * (x - v50.x) + 6 * (1 - v49) * v49 * (x2 - x) + 3 * v49 ^ 2 * (v53.x - x2);

        if v54 == 0 then
            break;
        end;

        local v55 = ((1 - v49) ^ 3 * v50.x + 3 * (1 - v49) ^ 2 * v49 * v51.x + 3 * (1 - v49) * v49 ^ 2 * v52.x + v49 ^ 3 * v53.x - p47) / v54;
        local v56 = v49 - v55;
        v49 = v56 < 0 and 0 or (v56 > 1 and 1 or v56);

        if math.abs(v55) < 0.001 then
            break;
        end;
    end;

    return (1 - v49) ^ 3 * v50 + 3 * (1 - v49) ^ 2 * v49 * v51 + 3 * (1 - v49) * v49 ^ 2 * v52 + v49 ^ 3 * v53;
end;

function u11._buildEaseLUT(p57) -- Line: 162
    local v58 = table.create(65);

    for i = 0, 64 do
        v58[i] = p57:_getEaseRaw(i / 64);
    end;

    p57.ease_lut = v58;
end;

function u11.getEase(p59, p60) -- Line: 173
    local ease_lut = p59.ease_lut;

    if not ease_lut then
        p59:_buildEaseLUT();
        ease_lut = p59.ease_lut;
    end;

    local v61 = math.clamp(p60, 0, 1);
    local v62 = v61 * 64;
    local v63 = math.floor(v62);
    local v64 = math.min(v63 + 1, 64);
    local v65 = v62 - v63;
    local v66 = ease_lut[v63];
    local v67 = ease_lut[v64];

    if v66 and v67 then
        return v66:Lerp(v67, v65);
    end;

    return p59:_getEaseRaw(v61);
end;

function u11.getPositionArcSpace(p68, p69) -- Line: 200
    if p68.length <= 0 then
        return p68.points[1] or Vector3.new(0, 0, 0);
    end;

    local v70 = math.clamp(p69, 0, 1) * p68.cumulative_lengths[p68.accuracy + 1];
    local v71 = p68.accuracy + 1;
    local v72 = 1;
    local v73 = nil;

    while v72 < v71 do
        v73 = v72 + (v71 - v72) // 2;

        if p68.cumulative_lengths[v73] < v70 then
            v72 = v73 + 1;
        else
            v71 = v73;
        end;
    end;

    if v70 < p68.cumulative_lengths[v73] and v73 > 1 then
        v73 = v73 - 1;
    end;

    local v74 = p68.cumulative_lengths[v73];

    if v74 == v70 then
        return p68:getPosition((v73 - 1) / p68.accuracy);
    end;

    return p68:getPosition((v73 - 1 + (v70 - v74) / (p68.cumulative_lengths[v73 + 1] - v74)) / p68.accuracy);
end;

function u11._recalculate(p75) -- Line: 236
    table.clear(p75.cumulative_lengths);
    table.insert(p75.cumulative_lengths, 0);
    p75.point_count = math.ceil(#p75.points / 3);
    local v76 = nil;
    local v77 = 0;

    for i = 1, p75.accuracy do
        local v78 = p75:getPosition(i / p75.accuracy);
        local v79 = v76 or p75:getPosition(0);
        v77 = v77 + vector.magnitude(v78 - v79);
        table.insert(p75.cumulative_lengths, v77);
        v76 = v78;
    end;

    p75.length = v77;

    for i, v in p75.cumulative_lengths do
        p75.cumulative_lengths[i] = v / v77;
    end;
end;

return u11;