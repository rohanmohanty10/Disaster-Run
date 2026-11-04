 
 

local function cubicBezier(p1, p2, p3, p4, p5) -- Line: 6
    return (1 - p5) ^ 3 * p1 + 3 * (1 - p5) ^ 2 * p5 * p2 + 3 * (1 - p5) * p5 ^ 2 * p3 + p5 ^ 3 * p4;
end;

local function cubicBezierDerivative(p6, p7, p8, p9, p10) -- Line: 11
    return 3 * (1 - p10) ^ 2 * (p7 - p6) + 6 * (1 - p10) * p10 * (p8 - p7) + 3 * p10 ^ 2 * (p9 - p8);
end;

local u11 = {};
u11.__index = u11;

function u11.new(p12: table, p13: number?) -- Line: 28
    -- upvalues: u11 (copy)
    local v14 = setmetatable({}, u11);
    v14.points = p12;
    v14.accuracy = p13 or 20;
    v14.point_count = 0;
    v14.cumulative_lengths = {};
    v14:_recalculate();

    return v14;
end;

function u11.setPoints(p15: any, p16: table) -- Line: 42
    p15.points = p16;
    p15:_recalculate();
end;

function u11.getSegmentPoints(p17: any, p18: number) -- Line: 47
    if p18 < 1 or p17.point_count - 1 < p18 then
        if p18 <= 0 then
            return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0);
        end;

        error("attempt to get a non-existent segment at index " .. p18);
    end;

    local v19 = (p18 - 1) * 4 - math.max(p18 - 2, 0);
    local math_max_ret = math.max(v19, 1);

    return p17.points[math_max_ret], p17.points[math_max_ret + 1], p17.points[math_max_ret + 2], p17.points[math_max_ret + 3];
end;

function u11.forSample(p20: any, p21: number, p22: function) -- Line: 67
    local v23 = p20.length // p21;

    if v23 == 0 then
        return;
    end;

    for i = 0, v23 do
        p22(p20:getPositionArcSpace(i / v23), i);
        local _ = i;
    end;
end;

function u11.getPosition(p24: any, p25: number) -- Line: 80
    local SegmentIndex, v26 = p24:getSegmentIndex(p25);
    local SegmentPoints, v27, v28, v29 = p24:getSegmentPoints(SegmentIndex);

    return (1 - v26) ^ 3 * SegmentPoints + 3 * (1 - v26) ^ 2 * v26 * v27 + 3 * (1 - v26) * v26 ^ 2 * v28 + v26 ^ 3 * v29;
end;

function u11.getSegmentIndex(p30: any, p31: number) -- Line: 87
    local math_clamp_ret = math.clamp(p31, 0, 1);
    local v32 = p30.point_count - 1;
    local v33 = math_clamp_ret * v32;
    local v34 = math.floor(v33) + 1;
    local math_min_ret = math.min(v34, v32);
    local v35 = v33 - math.floor(v33);

    return math_min_ret, math_clamp_ret == 1 and 1 or v35;
end;

function u11.getEasedSegmentIndex(p36: any, p37: number) -- Line: 104
    local v38 = p36.point_count - 1;

    for i = 1, v38 do
        local SegmentPoints, _, _, v39 = p36:getSegmentPoints(i);
        local x = SegmentPoints.x;
        local x2 = v39.x;

        if x <= p37 and p37 < x2 then
            return i, (p37 - x) / (x2 - x);
        end;

        local _ = i;
    end;

    return v38, 1;
end;

function u11.getEase(p40: any, p41: number) -- Line: 125
    local EasedSegmentIndex, v42 = p40:getEasedSegmentIndex(p41);
    local SegmentPoints, v43, v44, v45 = p40:getSegmentPoints(EasedSegmentIndex);

    for i = 1, 5 do
        local x = v43.x;
        local x2 = v44.x;
        local v46 = 3 * (1 - v42) ^ 2 * (x - SegmentPoints.x) + 6 * (1 - v42) * v42 * (x2 - x) + 3 * v42 ^ 2 * (v45.x - x2);

        if v46 == 0 then
            break;
        end;

        local v47 = ((1 - v42) ^ 3 * SegmentPoints.x + 3 * (1 - v42) ^ 2 * v42 * v43.x + 3 * (1 - v42) * v42 ^ 2 * v44.x + v42 ^ 3 * v45.x - p41) / v46;
        local v48 = v42 - v47;
        v42 = v48 < 0 and 0 or (v48 > 1 and 1 or v48);

        if math.abs(v47) < 0.001 then
            break;
        end;

        local _ = i;
    end;

    return (1 - v42) ^ 3 * SegmentPoints + 3 * (1 - v42) ^ 2 * v42 * v43 + 3 * (1 - v42) * v42 ^ 2 * v44 + v42 ^ 3 * v45;
end;

function u11.getPositionArcSpace(p49: any, p50: number) -- Line: 154
    if p49.length <= 0 then
        return p49.points[1] or Vector3.new(0, 0, 0);
    end;

    local v51 = math.clamp(p50, 0, 1) * p49.cumulative_lengths[p49.accuracy + 1];
    local v52 = p49.accuracy + 1;
    local v53 = 1;
    local v54 = nil;

    while v53 < v52 do
        v54 = v53 + (v52 - v53) // 2;

        if p49.cumulative_lengths[v54] < v51 then
            v53 = v54 + 1;
        else
            v52 = v54;
        end;
    end;

    if v51 < p49.cumulative_lengths[v54] and v54 > 1 then
        v54 = v54 - 1;
    end;

    local v55 = p49.cumulative_lengths[v54];

    if v55 == v51 then
        return p49:getPosition((v54 - 1) / p49.accuracy);
    end;

    return p49:getPosition((v54 - 1 + (v51 - v55) / (p49.cumulative_lengths[v54 + 1] - v55)) / p49.accuracy);
end;

function u11._recalculate(p56) -- Line: 190
    table.clear(p56.cumulative_lengths);
    table.insert(p56.cumulative_lengths, 0);
    p56.point_count = math.ceil(#p56.points / 3);
    local v57 = nil;
    local v58 = 0;

    for i = 1, p56.accuracy do
        local Position = p56:getPosition(i / p56.accuracy);
        local v59 = v57 or p56:getPosition(0);
        v58 = v58 + vector.magnitude(Position - v59);
        table.insert(p56.cumulative_lengths, v58);
        v57 = Position;
        local _ = i;
    end;

    p56.length = v58;

    for i, v in p56.cumulative_lengths do
        p56.cumulative_lengths[i] = v / v58;
    end;
end;

return u11;