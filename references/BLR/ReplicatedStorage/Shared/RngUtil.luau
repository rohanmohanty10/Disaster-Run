  

local Random_new_ret = Random.new(os.clock() * 100);
local u1 = {};

function u1.FromChanceInt(p2) -- Line: 5
    -- upvalues: u1 (copy)
    return u1.FromChanceFloat(p2 / 100);
end;

function u1.FromChanceFloat(p3) -- Line: 9
    -- upvalues: Random_new_ret (copy)
    return Random_new_ret:NextNumber(0, 1) <= p3;
end;

function u1.TotalWeight(p4: userdata) -- Line: 13
    local v5 = 0;

    for _, v in p4 do
        v5 = v5 + v;
    end;

    return v5;
end;

function u1.ToChances(p6: userdata) -- Line: 22
    -- upvalues: u1 (copy)
    local v7 = u1.TotalWeight(p6);
    local table_clone_ret = table.clone(p6);

    for i, v in table_clone_ret do
        table_clone_ret[i] = v / v7;
    end;

    return table_clone_ret;
end;

function u1.ConvertToWeightMap(p8, p9) -- Line: 31
    local v10 = {};

    for i, v in p8 do
        local v11, v12 = p9(i, v);
        v10[v11] = v12;
    end;

    return v10;
end;

function u1.RandomSign() -- Line: 41
    -- upvalues: Random_new_ret (copy)
    return Random_new_ret:NextInteger(1, 2) == 1 and -1 or 1;
end;

function u1.PointInCircleVector2(p13) -- Line: 45
    -- upvalues: Random_new_ret (copy)
    local v14;

    repeat
        v14 = Vector2.new(Random_new_ret:NextNumber(-p13, p13), Random_new_ret:NextNumber(-p13, p13));
    until v14.Magnitude < p13;

    return v14;
end;

function u1.PointInPart(p15: userdata, p16: number?) -- Line: 54
    -- upvalues: Random_new_ret (copy)
    local v17 = p15.Size / 2 * (p16 or 1);
    local CFrame = p15.CFrame;
    local v18 = Random_new_ret:NextNumber(-v17.X, v17.X);
    local v19 = Random_new_ret:NextNumber(-v17.Y, v17.Y);

    return CFrame * Vector3.new(v18, v19, Random_new_ret:NextNumber(-v17.Z, v17.Z));
end;

function u1.PointInCircleVector3(p20) -- Line: 65
    -- upvalues: Random_new_ret (copy)
    local v21;

    repeat
        local v22 = Random_new_ret:NextNumber(-p20, p20);
        v21 = Vector3.new(v22, 0, Random_new_ret:NextNumber(-p20, p20));
    until v21.Magnitude < p20;

    return v21;
end;

function u1.UnitVector2() -- Line: 74
    -- upvalues: Random_new_ret (copy)
    local v23 = Random_new_ret:NextUnitVector();

    return Vector2.new(v23.X, v23.Y).Unit;
end;

function u1.UnitVector3() -- Line: 79
    -- upvalues: Random_new_ret (copy)
    return Random_new_ret:NextUnitVector();
end;

local function GetWeight(p24, p25) -- Line: 83
    if p25 then
        return p24[p25];
    end;

    return p24;
end;

function u1.RandomArrayValue(p26: table) -- Line: 87
    -- upvalues: Random_new_ret (copy)
    return p26[Random_new_ret:NextInteger(1, #p26)];
end;

function u1.RandomChild(p27: userdata) -- Line: 91
    -- upvalues: u1 (copy)
    return u1.RandomArrayValue(p27:GetChildren());
end;

function u1.SelectRandom(p28: table, p29: string?, p30: userdata?) -- Line: 95
    -- upvalues: Random_new_ret (copy)
    local v31 = 0;

    for _, v in p28 do
        local v32;

        if p29 then
            v32 = v[p29];
        else
            v32 = v;
        end;

        v31 = v31 + v32;
    end;

    local v33 = (p30 or Random_new_ret):NextNumber(0, v31);

    for i, v in p28 do
        local v34;

        if p29 then
            v34 = v[p29];
        else
            v34 = v;
        end;

        v31 = v31 - v34;

        if v31 < v33 then
            return i;
        end;
    end;

    error("Invalid table to select from");
end;

function u1.SumWeight(p35: table, p36: string?) -- Line: 115
    local v37 = 0;

    for _, v in p35 do
        local v38;

        if p36 then
            v38 = v[p36];
        else
            v38 = v;
        end;

        v37 = v37 + v38;
    end;

    return v37;
end;

function u1.GetChance(p39: any, p40: table, p41: string?) -- Line: 124
    -- upvalues: u1 (copy)
    local v42 = p40[p39];

    if not v42 then
        return 0;
    end;

    if p41 then
        v42 = v42[p41];
    end;

    return v42 / u1.SumWeight(p40, p41) * 100;
end;

return u1;