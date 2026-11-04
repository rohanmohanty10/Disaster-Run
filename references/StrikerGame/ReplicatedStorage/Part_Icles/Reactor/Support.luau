 

 

local u5 = {
    worldHalf = function(p1) -- Line: 30, Name: worldHalf
        local rest = p1.rest;
        local halfExt = p1.halfExt;
        local XVector = rest.XVector;
        local YVector = rest.YVector;
        local ZVector = rest.ZVector;
        local v2 = math.abs(XVector.X) * halfExt.X + math.abs(YVector.X) * halfExt.Y + math.abs(ZVector.X) * halfExt.Z;
        local v3 = math.abs(XVector.Y) * halfExt.X + math.abs(YVector.Y) * halfExt.Y + math.abs(ZVector.Y) * halfExt.Z;
        local v4 = math.abs(XVector.Z) * halfExt.X + math.abs(YVector.Z) * halfExt.Y + math.abs(ZVector.Z) * halfExt.Z;

        return Vector3.new(v2, v3, v4);
    end
};

local function contact(p6, p7, p8) -- Line: 43
    local v9 = p7 + p8 - math.abs(p6);

    return math.min(p7, p8) * 0.5 <= v9 and 2 or (v9 >= -0.15 and 1 or 0);
end;

function u5.touching(p10, p11, p12, p13) -- Line: 54
    local X = p11.X;
    local X2 = p13.X;
    local v14 = X + X2 - math.abs(p10.X - p12.X);
    local v15 = math.min(X, X2) * 0.5 <= v14 and 2 or (v14 >= -0.15 and 1 or 0);
    local Y = p11.Y;
    local Y2 = p13.Y;
    local v16 = Y + Y2 - math.abs(p10.Y - p12.Y);
    local v17 = math.min(Y, Y2) * 0.5 <= v16 and 2 or (v16 >= -0.15 and 1 or 0);
    local Z = p11.Z;
    local Z2 = p13.Z;
    local v18 = Z + Z2 - math.abs(p10.Z - p12.Z);
    local v19 = math.min(Z, Z2) * 0.5 <= v18 and 2 or (v18 >= -0.15 and 1 or 0);

    if v15 == 0 or (v17 == 0 or v19 == 0) then
        return false;
    end;

    return v15 + v17 + v19 >= 5;
end;

local function reached(p20, p21) -- Line: 65
    local v22 = {};
    local v23 = {};

    for i in pairs(p20.anchored) do
        if p21(i) then
            v22[i] = true;
            table.insert(v23, i);
        end;
    end;

    local v24 = 1;

    while v24 <= #v23 do
        local v25 = v23[v24];
        v24 = v24 + 1;

        for _, v in ipairs(p20.neighbours[v25]) do
            if not v22[v] and p21(v) then
                v22[v] = true;
                table.insert(v23, v);
            end;
        end;
    end;

    return v22;
end;

function u5.build(p26, p27) -- Line: 88
    -- upvalues: u5 (copy), reached (copy)
    local v28 = #p26;
    local table_create_ret = table.create(v28);
    local table_create_ret2 = table.create(v28);
    local v29 = 2;

    for i, v in ipairs(p26) do
        table_create_ret[i] = v.rest.Position;
        local v30 = u5.worldHalf(v);
        local slash = v.slash;

        if slash then
            local normal = slash.normal;
            local math_abs_ret = math.abs(normal.X);
            local math_abs_ret2 = math.abs(normal.Y);
            local math_abs_ret3 = math.abs(normal.Z);
            v30 = v30 + Vector3.new(math_abs_ret, math_abs_ret2, math_abs_ret3) * (slash.kerf / 2);
        end;

        table_create_ret2[i] = v30;
        v29 = math.max(v29, v30.X * 2, v30.Y * 2, v30.Z * 2);
    end;

    local table_create_ret3 = table.create(v28);
    local v31 = {};
    local v32 = {};

    for i = 1, v28 do
        table_create_ret3[i] = {};
        local v33 = table_create_ret[i];
        local v34 = table_create_ret2[i];
        local v35 = i;

        for i2 = math.floor((v33.X - v34.X - 0.15) / v29), math.floor((v33.X + v34.X + 0.15) / v29) do
            local v36 = i2;

            for i3 = math.floor((v33.Y - v34.Y - 0.15) / v29), math.floor((v33.Y + v34.Y + 0.15) / v29) do
                local v37 = i3;

                for i4 = math.floor((v33.Z - v34.Z - 0.15) / v29), math.floor((v33.Z + v34.Z + 0.15) / v29) do
                    local v38 = v36 .. "," .. v37 .. "," .. i4;
                    local v39 = v31[v38];

                    if not v39 then
                        v39 = {};
                        v31[v38] = v39;
                    end;

                    local _ = i4;

                    for _, v in ipairs(v39) do
                        local v40 = v * (v28 + 1) + v35;

                        if not v32[v40] then
                            v32[v40] = true;

                            if u5.touching(v33, v34, table_create_ret[v], table_create_ret2[v]) then
                                table.insert(table_create_ret3[v35], v);
                                table.insert(table_create_ret3[v], v35);
                            end;
                        end;
                    end;

                    table.insert(v39, v35);
                end;
            end;
        end;
    end;

    local v41 = {};

    for i = 1, v28 do
        local v42;

        if p27(i) then
            v41[i] = true;
            v42 = i;
        else
            v42 = i;
        end;
    end;

    local v43 = {
        neighbours = table_create_ret3,
        anchored = v41,
        supported = {}
    };
    v43.supported = reached(v43, function() -- Line: 147
        return true;
    end);

    return v43;
end;

function u5.unsupported(p44, p45) -- Line: 153
    -- upvalues: reached (copy)
    local v46 = reached(p44, p45);
    local v47 = {};

    for i in pairs(p44.supported) do
        if not v46[i] and p45(i) then
            table.insert(v47, i);
        end;
    end;

    table.sort(v47);

    return v47;
end;

return u5;