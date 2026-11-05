  

 

local v1 = {};

local function Cross(p2, p3) -- Line: 12
    return p2.x * p3.y - p2.y * p3.x;
end;

local function Dot(p4, p5) -- Line: 16
    return p4.x * p5.x + p4.y * p5.y;
end;

local function Angle(p6, p7) -- Line: 20
    local v8 = math.sqrt(p6.x * p6.x + p6.y * p6.y);
    local v9 = math.sqrt(p7.x * p7.x + p7.y * p7.y);

    return math.acos((p6.x * p7.x + p6.y * p7.y) / v8 / v9);
end;

local function GetMidpoint(p10, p11, p12) -- Line: 26
    local v13 = Vector2.new(p11.y - p10.y, p10.x - p11.x);
    local v14 = (p11 + p12) / 2;
    local v15 = Vector2.new(p12.y - p11.y, p11.x - p12.x);
    local v16 = v14 - (p10 + p11) / 2;

    return v14 + (v16.x * v13.y - v16.y * v13.x) / (v13.x * v15.y - v13.y * v15.x) * v15;
end;

local function MergeVector2Userdata(p17) -- Line: 36
    local u18 = {};

    local function Vector2GetOrCreate(p19) -- Line: 39
        -- upvalues: u18 (copy)
        local v20 = string.format("%.4f;%.4f", p19.x, p19.y);
        local v21 = u18[v20];

        if v21 then
            return v21;
        end;

        u18[v20] = p19;

        return p19;
    end;

    for _, v in pairs(p17) do
        local v22 = v[1];
        local v23 = string.format("%.4f;%.4f", v22.x, v22.y);
        local v24 = u18[v23];

        if v24 then
            v22 = v24;
        else
            u18[v23] = v22;
        end;

        v[1] = v22;
        local v25 = v[2];
        local v26 = string.format("%.4f;%.4f", v25.x, v25.y);
        local v27 = u18[v26];

        if v27 then
            v25 = v27;
        else
            u18[v26] = v25;
        end;

        v[2] = v25;
        local v28 = v[3];
        local v29 = string.format("%.4f;%.4f", v28.x, v28.y);
        local v30 = u18[v29];

        if v30 then
            v28 = v30;
        else
            u18[v29] = v28;
        end;

        v[3] = v28;
    end;
end;

function v1.DelaunayToVoronoi(p31) -- Line: 60
    -- upvalues: MergeVector2Userdata (copy), GetMidpoint (copy)
    MergeVector2Userdata(p31);
    local u32 = {};

    local function AddToPoint(p33, p34, p35, p36) -- Line: 64
        -- upvalues: u32 (copy)
        local v37 = u32[p34];

        if not v37 then
            u32[p34] = {
                Angle = 0,
                Center = p34
            };
            v37 = u32[p34];
        end;

        local Angle2 = v37.Angle;
        local v38 = p33 - p34;
        local v39 = p35 - p34;
        local v40 = math.sqrt(v38.x * v38.x + v38.y * v38.y);
        local v41 = math.sqrt(v39.x * v39.x + v39.y * v39.y);
        v37.Angle = Angle2 + math.acos((v38.x * v39.x + v38.y * v39.y) / v40 / v41);
        v37[#v37 + 1] = p36;
    end;

    for _, v in ipairs(p31) do
        v[4] = GetMidpoint(v[1], v[2], v[3]);
        AddToPoint(v[1], v[2], v[3], v);
        AddToPoint(v[2], v[3], v[1], v);
        AddToPoint(v[3], v[1], v[2], v);
    end;

    local u42 = {};

    local function GetPolylineTerminator(p43, p44, p45) -- Line: 84
        -- upvalues: u42 (copy)
        if u42[p43] then
            assert(u42[p43][1] == p44);
            assert(u42[p43][2] == p45);

            return u42[p43][3];
        end;

        local v46 = p43 - p44;
        local v47 = p45 + Vector2.new(v46.y, -v46.x);
        u42[p43] = { p44, p45, v47 };

        return v47;
    end;

    local v48 = {};
    local v49 = {};

    for _, v in u32 do
        local Center = v.Center;
        local v50 = {};

        for i = 1, #v do
            local v51 = v[i];

            if v51[1] == Center then
                v50[v51[2]] = { v51[3], v51[4] };
            elseif v51[2] == Center then
                v50[v51[3]] = { v51[1], v51[4] };
            elseif v51[3] == Center then
                v50[v51[1]] = { v51[2], v51[4] };
            end;
        end;

        local v52, v53 = next(v50);
        local v54 = {};

        while v53 and v53[1] ~= v52 do
            v54[#v54 + 1] = v53[2];
            v53 = v50[v53[1]];
        end;

        if v53 then
            table.insert(v54, v53[2]);
            table.insert(v48, v54);
        end;
    end;

    return v48, v49;
end;

return v1;