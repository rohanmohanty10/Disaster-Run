  

 

local u1 = {};

function u1.DeepCopy(p2) -- Line: 27
    -- upvalues: u1 (copy)
    local v3 = table.clone(p2);

    for i, v in v3 do
        if typeof(v) == "table" then
            v3[i] = u1.DeepCopy(v);
        end;
    end;

    return v3;
end;

function u1.MergeDictionary(p4, p5) -- Line: 63
    local v6 = table.clone(p4);

    for i, v in p5 do
        v6[i] = v;
    end;

    return v6;
end;

function u1.Keys(p7) -- Line: 93
    local v8 = {};

    for i in p7 do
        table.insert(v8, i);
    end;

    return v8;
end;

function u1.Values(p9) -- Line: 120
    local v10 = {};

    for _, v in p9 do
        table.insert(v10, v);
    end;

    return v10;
end;

function u1.MergeArrays(p11, p12) -- Line: 145
    local v13 = table.clone(p11);
    table.move(p12, 1, #p12, #v13 + 1, v13);

    return v13;
end;

function u1.Reconcile(p14, p15) -- Line: 177
    -- upvalues: u1 (copy)
    local v16 = table.clone(p14);

    for i, v in p15 do
        if v16[i] == nil then
            if typeof(v) == "table" then
                v16[i] = u1.DeepCopy(v);
            else
                v16[i] = v;
            end;
        elseif typeof(p15[i]) == "table" then
            if typeof(v) == "table" then
                v16[i] = u1.Reconcile(v, p15[i]);
            else
                v16[i] = u1.DeepCopy(p15[i]);
            end;
        end;
    end;

    return v16;
end;

function u1.IsArray(p17) -- Line: 213
    local v18 = 0;

    for _ in p17 do
        v18 = v18 + 1;
    end;

    return v18 == #p17;
end;

function u1.IsDictionary(p19) -- Line: 235
    local v20 = 0;

    for _ in p19 do
        v20 = v20 + 1;
    end;

    return v20 ~= #p19;
end;

function u1.ToString(p21) -- Line: 264
    local v22 = {};

    for i, v in p21 do
        local v23;

        if typeof(i) == "string" then
            v23 = `"{tostring(i)}"`;
        else
            v23 = tostring(i);
        end;

        local v24 = tostring(v);

        if typeof(v) == "string" then
            v24 = `"{v24}"`;
        end;

        local v25 = `\t[{v23}] = {v24}`;
        table.insert(v22, v25);
    end;

    return "{\n" .. table.concat(v22, "\n") .. "\n}";
end;

function u1.ToArrayString(p26) -- Line: 288
    local v27 = {};

    for _, v in p26 do
        local v28 = tostring(v);

        if typeof(v) == "string" then
            v28 = `"{v28}"`;
        end;

        table.insert(v27, v28);
    end;

    return "{" .. table.concat(v27, ", ") .. "}";
end;

function u1.From(p29) -- Line: 317
    local v30 = typeof(p29);

    if v30 == "string" then
        return string.split(p29, "");
    end;

    return v30 == "Color3" and { p29.R, p29.G, p29.B } or (v30 == "Vector2" and { p29.X, p29.Y } or (v30 == "Vector3" and { p29.X, p29.Y, p29.Z } or (v30 ~= "NumberSequence" and (v30 == "Vector3int16" and { p29.X, p29.Y, p29.Z } or (v30 == "Vector2int16" and { p29.X, p29.Y } or { p29 })) or p29.Keypoints)));
end;

function u1.Filter(p31, p32) -- Line: 360
    local v33 = {};

    for _, v in p31 do
        if p32(v) then
            table.insert(v33, v);
        end;
    end;

    return v33;
end;

function u1.Some(p34, p35) -- Line: 387
    for _, v in p34 do
        if p35(v) == true then
            return true;
        end;
    end;

    return false;
end;

function u1.IsFlat(p36) -- Line: 411
    for _, v in p36 do
        if typeof(v) == "table" then
            return false;
        end;
    end;

    return true;
end;

function u1.Every(p37, p38) -- Line: 437
    for i, v in p37 do
        if not p38(v) then
            return false, i;
        end;
    end;

    return true;
end;

function u1.HasKey(p39, p40) -- Line: 465
    return p39[p40] ~= nil;
end;

function u1.HasValue(p41, p42) -- Line: 483
    for _, v in p41 do
        if v == p42 then
            return true;
        end;
    end;

    return false;
end;

function u1.IsEmpty(p43) -- Line: 506
    return next(p43) == nil;
end;

return table.freeze(u1);