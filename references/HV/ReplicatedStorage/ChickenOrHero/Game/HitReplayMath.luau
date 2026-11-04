 

 

local u7 = {
    vector = function(p1) -- Line: 3, Name: vector
        local v2;

        if typeof(p1) == "Vector3" and (p1.X == p1.X and (p1.Y == p1.Y and p1.Z == p1.Z)) then
            v2 = p1.Magnitude < 1000000;
        else
            v2 = false;
        end;

        return v2;
    end,

    bounds = function(p3, p4) -- Line: 6, Name: bounds
        if p3 ~= "Melee" then
            return {
                near = 0,
                width = 0.95 * (p4.Width + 2 * p4.RunnerRadius),
                height = 0.95 * p4.Height,
                far = 0.95 * (p4.Reach + p4.RunnerRadius)
            };
        end;

        local v5 = p4.RunnerRadius + p4.ContactPadding;
        local v6 = p4.BoxScale or 0.95;

        return {
            width = v6 * 2 * (p4.HitHalfWidth + v5),
            height = v6 * 2 * p4.Height,
            near = v6 * p4.MinForward,
            far = v6 * (p4.HandRadius + v5),
            overlap = v6 * (p4.OverlapRadius or 0)
        };
    end
};

local function clip(p8, p9, p10, p11, p12, p13) -- Line: 28
    if math.abs(p11) < 1e-6 then
        if p12 <= p10 and p10 <= p13 then
            return p8, p9;
        end;

        return nil;
    end;

    local v14 = (p12 - p10) / p11;
    local v15 = (p13 - p10) / p11;

    if v15 >= v14 then
        local v16 = v14;
        v14 = v15;
        v15 = v16;
    end;

    local math_max_ret = math.max(p8, v15);
    local math_min_ret = math.min(p9, v14);

    if math_max_ret <= math_min_ret then
        return math_max_ret, math_min_ret;
    end;

    return nil;
end;

local function overlapStart(p17, p18, p19, p20) -- Line: 47
    local v21 = 0;
    local v22 = 1;
    local Y = p17.Y;
    local Y2 = p18.Y;
    local v23 = -p20;

    if math.abs(Y2) < 1e-6 then
        if v23 > Y or Y > p20 then
            v21 = nil;
            v22 = nil;
        end;
    else
        local v24 = (v23 - Y) / Y2;
        local v25 = (p20 - Y) / Y2;

        if v25 >= v24 then
            local v26 = v24;
            v24 = v25;
            v25 = v26;
        end;

        v21 = math.max(v21, v25);
        v22 = math.min(v22, v24);

        if v21 > v22 then
            v21 = nil;
            v22 = nil;
        end;
    end;

    if not v21 then
        return nil;
    end;

    local v27 = p18.X * p18.X + p18.Z * p18.Z;
    local v28 = p17.X * p17.X + p17.Z * p17.Z - p19 * p19;

    if v27 < 1e-9 then
        return v28 <= 0 and v21 and v21 or nil;
    end;

    local v29 = 2 * (p17.X * p18.X + p17.Z * p18.Z);
    local v30 = v29 * v29 - 4 * v27 * v28;

    if v30 < 0 then
        return nil;
    end;

    local math_sqrt_ret = math.sqrt(v30);
    local math_max_ret = math.max(v21, (-v29 - math_sqrt_ret) / (2 * v27));

    return math_max_ret <= math.min(v22, (-v29 + math_sqrt_ret) / (2 * v27)) and math_max_ret and math_max_ret or nil;
end;

function u7.sweep(p31, p32, p33, p34, p35, p36) -- Line: 68
    -- upvalues: u7 (copy), overlapStart (copy)
    if not u7.vector(p35) or p35.Magnitude < 0.01 then
        return false;
    end;

    local v37 = p35 * Vector3.new(1, 0, 1);

    if v37.Magnitude < 0.01 then
        return false;
    end;

    local Unit = v37.Unit;
    local v38 = Unit:Cross(Vector3.new(0, 1, 0));
    local v39 = p33 - p31;
    local v40 = p34 - p32;
    local v41 = v39:Dot(v38);
    local Vector3_new_ret = Vector3.new(v41, v39.Y, v39:Dot(Unit));
    local v42 = v40:Dot(v38);
    local v43 = Vector3.new(v42, v40.Y, v40:Dot(Unit)) - Vector3_new_ret;
    local v44 = 0;
    local v45 = 1;
    local X = Vector3_new_ret.X;
    local X2 = v43.X;
    local v46 = -p36.width / 2;
    local v47 = p36.width / 2;

    if math.abs(X2) < 1e-6 then
        if v46 > X or X > v47 then
            v44 = nil;
            v45 = nil;
        end;
    else
        local v48 = (v46 - X) / X2;
        local v49 = (v47 - X) / X2;

        if v49 >= v48 then
            local v50 = v48;
            v48 = v49;
            v49 = v50;
        end;

        v44 = math.max(v44, v49);
        v45 = math.min(v45, v48);

        if v44 > v45 then
            v44 = nil;
            v45 = nil;
        end;
    end;

    if v44 then
        local Y = Vector3_new_ret.Y;
        local Y2 = v43.Y;
        local v51 = -p36.height / 2;
        local v52 = p36.height / 2;

        if math.abs(Y2) < 1e-6 then
            if v51 > Y or Y > v52 then
                v44 = nil;
                v45 = nil;
            end;
        else
            local v53 = (v51 - Y) / Y2;
            local v54 = (v52 - Y) / Y2;

            if v54 >= v53 then
                local v55 = v53;
                v53 = v54;
                v54 = v55;
            end;

            v44 = math.max(v44, v54);
            v45 = math.min(v45, v53);

            if v44 > v45 then
                v44 = nil;
                v45 = nil;
            end;
        end;
    end;

    if v44 then
        local Z = Vector3_new_ret.Z;
        local Z2 = v43.Z;
        local near = p36.near;
        local far = p36.far;

        if math.abs(Z2) < 1e-6 then
            if near > Z or Z > far then
                v44 = nil;
            end;
        else
            local v56 = (near - Z) / Z2;
            local v57 = (far - Z) / Z2;

            if v57 >= v56 then
                local v58 = v56;
                v56 = v57;
                v57 = v58;
            end;

            v44 = math.max(v44, v57);

            if v44 > math.min(v45, v56) then
                v44 = nil;
            end;
        end;
    end;

    local overlap = p36.overlap;
    local v59;

    if type(overlap) == "number" and overlap > 0 then
        v59 = overlapStart(Vector3_new_ret, v43, overlap, p36.height / 2);

        if not (v59 and (not v44 or v59 < v44)) then
            v59 = v44;
        end;
    else
        v59 = v44;
    end;

    if v59 then
        return true, p31:Lerp(p32, v59), p33:Lerp(p34, v59);
    end;

    return false;
end;

function u7.sample(p60, p61) -- Line: 102
    for i = #p60, 1, -1 do
        if math.abs(p60[i].at - p61) < 1e-6 then
            return table.clone(p60[i]);
        end;

        local _ = i;
    end;

    for i = #p60, 2, -1 do
        local v62 = p60[i - 1];
        local v63 = p60[i];

        if v62.at <= p61 and p61 <= v63.at then
            if v62.character ~= v63.character or (v62.reset ~= v63.reset or (v62.relocation ~= v63.relocation or (v62.active ~= v63.active or (v62.role ~= v63.role or (v62.safe ~= v63.safe or (v63.at - v62.at > 0.15 or (v63.position - v62.position).Magnitude > 14)))))) then
                return nil;
            end;

            local v64 = v63.at > v62.at and ((p61 - v62.at) / (v63.at - v62.at) or 0) or 0;
            local table_clone_ret = table.clone(v62);
            table_clone_ret.position = v62.position:Lerp(v63.position, v64);

            return table_clone_ret;
        end;

        local _ = i;
    end;

    return nil;
end;

return u7;