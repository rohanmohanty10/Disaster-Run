  

 

local Heap = require(script.Heap);
local v1 = {};

local function GetParabolaIntersection(p2, p3, p4) -- Line: 17
    if p3.x == p4.x then
        return (p3.y + p4.y) / 2;
    end;

    if p3.x == p2 then
        return p3.y;
    end;

    if p4.x == p2 then
        return p4.y;
    end;

    local v5 = 2 * (p3.x - p2);
    local v6 = 2 * (p4.x - p2);
    local v7 = 1 / v5 - 1 / v6;
    local v8 = -2 * (p3.y / v5 - p4.y / v6);

    return (-v8 - math.sqrt(v8 * v8 - 4 * v7 * ((p3.y * p3.y + p3.x * p3.x - p2 * p2) / v5 - (p4.y * p4.y + p4.x * p4.x - p2 * p2) / v6))) / (2 * v7);
end;

local function GetCircle(p9, p10, p11) -- Line: 42
    if (p10.x - p9.x) * (p11.y - p9.y) - (p11.x - p9.x) * (p10.y - p9.y) <= 0 then
        local v12 = p10.x - p9.x;
        local v13 = p10.y - p9.y;
        local v14 = p11.x - p9.x;
        local v15 = p11.y - p9.y;
        local v16 = v12 * (p9.x + p10.x) + v13 * (p9.y + p10.y);
        local v17 = v14 * (p9.x + p11.x) + v15 * (p9.y + p11.y);
        local v18 = 2 * (v12 * (p11.y - p10.y) - v13 * (p11.x - p10.x));

        if v18 == 0 then
            return false;
        end;

        local v19 = -(v13 * v17 - v15 * v16) / v18;
        local v20 = -(v14 * v16 - v12 * v17) / v18;
        local v21 = p9.x - v19;
        local v22 = p9.y - v20;
        local v23 = v19 + math.sqrt(v21 * v21 + v22 * v22);

        return Vector2.new(v19, v20), v23;
    end;
end;

local function Beachline_Search(p24, p25) -- Line: 78
    -- upvalues: GetParabolaIntersection (copy)
    for i = 1, #p24 - 1 do
        if GetParabolaIntersection(p25.x, p24[i][1], p24[i + 1][1]) > p25.y then
            return i;
        end;
    end;

    return #p24;
end;

local function Beachline_CheckForCircleEvent(p26, p27) -- Line: 92
    -- upvalues: GetCircle (copy)
    local v28, v29 = GetCircle(p26[p27 - 1][1], p26[p27][1], p26[p27 + 1][1]);

    if p26[p27][2] then
        p26[p27][2].Type = "InvalidEvent";
    end;

    if not v28 then
        p26[p27][2] = nil;

        return;
    end;

    p26[p27][2] = {
        Type = "CircleEvent",
        CenterPoint = v28,
        Time = v29,
        Parabola = p26[p27]
    };
    p26.NewCircleEvent(p26[p27][2]);
end;

local function Beachline_Add(p30, p31) -- Line: 110
    -- upvalues: Beachline_Search (copy), Beachline_CheckForCircleEvent (copy)
    if #p30 > 0 then
        local v32 = Beachline_Search(p30, p31);
        table.insert(p30, v32, { p30[v32][1] });
        table.insert(p30, v32 + 1, { p31 });

        if v32 >= 2 then
            Beachline_CheckForCircleEvent(p30, v32);
        end;

        Beachline_CheckForCircleEvent(p30, v32 + 1);

        if v32 <= #p30 - 3 then
            Beachline_CheckForCircleEvent(p30, v32 + 2);
        end;
    else
        p30[1] = { p31 };
    end;
end;

local function Beachline_FindParabola(p33, p34, p35) -- Line: 132
    for i = 1, #p33 do
        if p33[i] == p34 then
            return i;
        end;
    end;
end;

local function Beachline_Remove(p36, p37) -- Line: 141
    -- upvalues: Beachline_CheckForCircleEvent (copy)
    p36[p37][2].Type = "InvalidEvent";
    table.remove(p36, p37);

    if p37 - 1 > 1 then
        Beachline_CheckForCircleEvent(p36, p37 - 1);
    end;

    if p37 < #p36 then
        Beachline_CheckForCircleEvent(p36, p37);
    end;
end;

local function Beachline_GetPoint(p38, p39) -- Line: 155
    return p38[p39][1];
end;

function v1.Fortune(p40) -- Line: 165
    -- upvalues: Heap (copy), Beachline_Add (copy), Beachline_CheckForCircleEvent (copy)
    local u41 = Heap.new();

    for _, v in pairs(p40) do
        u41:Add(v.x, {
            Type = "PointEvent",
            Point = v
        });
    end;

    local v43 = {
        NewCircleEvent = function(p42) -- Line: 173, Name: NewCircleEvent
            -- upvalues: u41 (copy)
            u41:Add(p42.Time, p42);
        end
    };
    local v44 = {};

    while true do
        local v45;

        while true do
            while true do
                if not u41:Peek() then
                    return v44;
                end;

                local v46;
                v46, v45 = u41:Pop();

                if v45.Type ~= "PointEvent" then
                    break;
                end;

                Beachline_Add(v43, v45.Point);
            end;

            if v45.Type ~= "CircleEvent" then
                break;
            end;

            local Parabola = v45.Parabola;
            local _ = v45.CenterPoint;

            for i = 1, #v43 do
                if v43[i] == Parabola then
                    break;
                end;
            end;

            table.insert(v44, { v43[i - 1][1], v43[i][1], v43[i + 1][1] });
            v43[i][2].Type = "InvalidEvent";
            table.remove(v43, i);

            if i - 1 > 1 then
                Beachline_CheckForCircleEvent(v43, i - 1);
            end;

            if i < #v43 then
                Beachline_CheckForCircleEvent(v43, i);
            end;
        end;

        local _ = v45.Type == "InvalidEvent";
    end;
end;

return v1;