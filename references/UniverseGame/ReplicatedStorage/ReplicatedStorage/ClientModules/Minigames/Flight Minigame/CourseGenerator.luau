  

 

local u1 = {};
u1.__index = u1;

local function u4(p2, p3) -- Line: 18
    return Random.new():NextNumber(p2, p3);
end;

function u1.new(p5, p6, p7, p8) -- Line: 20
    -- upvalues: u1 (copy)
    return setmetatable({
        Segments = p5,
        Points = {},
        OriginPosition = p6,
        Offset = p7,
        Displacement = p8
    }, u1);
end;

function u1.Generate(p9) -- Line: 32
    -- upvalues: u4 (copy)
    local Points = p9.Points;
    local Segments = p9.Segments;
    local v10;

    if p9.OriginPosition then
        v10 = p9.OriginPosition;
    else
        v10 = Vector3.new();
    end;

    local v11;

    if p9.Offset then
        v11 = p9.Offset;
    else
        v11 = Vector3.new(10);
    end;

    local v12 = not p9.Displacement and {
        x = 0,
        y = 0
    } or p9.Displacement;
    local v13 = v10;

    for i = 1, Segments do
        if v10 then
            v10 = v10 + v11;
        else
            v10 = v13;
        end;

        if i == Segments then
            local v14 = -v12.y;
            local y = v12.y;
            local v15 = Random.new():NextNumber(v14, y);
            Points[i] = v10 + (v11 + Vector3.new(0, v15, u4(-v12.x, v12.x)));
            local v16 = -v11.X / 10;
            local v17 = v11.X / 10;
            local v18 = Random.new():NextNumber(v16, v17);
            local v19 = -v12.y;
            local y2 = v12.y;
            local v20 = Random.new():NextNumber(v19, y2);
            local v21 = v10 + (v11 + Vector3.new(v18, v20, u4(-v12.x, v12.x)));
            Points[i + 1] = v21;
        elseif i == 1 then
            Points[i] = v10;
        else
            local v22 = -v12.y;
            local y = v12.y;
            local v23 = Random.new():NextNumber(v22, y);
            Points[i] = v10 + (v11 + Vector3.new(0, v23, u4(-v12.x, v12.x)));
        end;
    end;

    return p9;
end;

function u1.Propagate(p24, p25) -- Line: 68
    local Points = p24.Points;

    for i = 1, p24.Segments do
        local v26 = Points[i];
        local v27 = Points[i + 1];

        if i < p24.Segments then
            p25(v26, v27, "Segment");
        elseif i == p24.Segments then
            p25(v26, Points[i - 1], "End");
        end;
    end;

    return p24;
end;

function u1.Obstacles(p28, u29, u30, u31) -- Line: 87
    -- upvalues: u4 (copy)
    local u32 = 0;
    p28:Propagate(function(p33, p34, p35) -- Line: 90
        -- upvalues: u32 (ref), u29 (copy), u31 (copy), u30 (copy), u4 (ref)
        u32 = u32 + 1;

        for i = 1, u29 do
            local v36 = p33:Lerp(p34, i / u29);
            local v37 = -u30.y;
            local y = u30.y;
            local v38 = Random.new():NextNumber(v37, y);
            u31(v36 + Vector3.new(0, v38, u4(-u30.x, u30.x)));
        end;
    end);

    return p28;
end;

return u1;