 

 

local u1 = {
    MODES = { "Recolor", "Colorize", "Shift", "Tint" }
};

local function turnBetween(p2, p3) -- Line: 44
    return (p3 - p2 + 0.5) % 1 - 0.5;
end;

function u1.referenceHue(p4) -- Line: 48
    local v5, v6 = p4.Keypoints[1].Value:ToHSV();

    if v6 < 0.01 then
        return nil;
    end;

    return v5;
end;

function u1.isNeutral(p7, p8) -- Line: 56
    -- upvalues: u1 (copy)
    local v9 = u1.referenceHue(p7);

    for _, v in ipairs(p7.Keypoints) do
        local Value = v.Value;

        if p8 == "Tint" then
            if Value.R < 0.999 or (Value.G < 0.999 or Value.B < 0.999) then
                return false;
            end;
        else
            local v10, v11 = Value:ToHSV();

            if v11 >= 0.01 then
                if p8 ~= "Shift" then
                    return false;
                end;

                if v9 and math.abs((v10 - v9 + 0.5) % 1 - 0.5) * v11 > 0.001388888888888889 then
                    return false;
                end;
            end;
        end;
    end;

    return true;
end;

local function turned(p12, p13) -- Line: 79
    local v14, v15, v16 = p12:ToHSV();

    if v15 < 0.01 then
        return p12;
    end;

    return Color3.fromHSV((v14 + p13) % 1, v15, v16);
end;

local function recolored(p17, p18, p19) -- Line: 87
    local v20, v21, v22 = p17:ToHSV();

    if v21 < 0.01 then
        return p17;
    end;

    return Color3.fromHSV((v20 + ((p18 - v20 + 0.5) % 1 - 0.5) * p19) % 1, v21, v22);
end;

function u1.prepare(p23, p24, p25, p26) -- Line: 95
    local v27, v28 = p24:ToHSV();
    p23.mode = p25;
    p23.red = p24.R;
    p23.green = p24.G;
    p23.blue = p24.B;
    p23.hue = v27;
    p23.strength = v28;
    p23.shift = 0;

    if p25 == "Shift" and (p26 and v28 >= 0.01) then
        p23.shift = ((v27 - p26 + 0.5) % 1 - 0.5) * v28;
    end;

    return p23;
end;

function u1.one(p29, p30) -- Line: 110
    -- upvalues: turned (copy), recolored (copy)
    if p30.mode == "Tint" then
        return Color3.new(p29.R * p30.red, p29.G * p30.green, p29.B * p30.blue);
    end;

    if p30.mode == "Shift" then
        if p30.shift == 0 then
            return p29;
        end;

        return turned(p29, p30.shift);
    end;

    if p30.strength < 0.01 then
        return p29;
    end;

    if p30.mode == "Colorize" then
        local _, v31, v32 = p29:ToHSV();

        if v31 < 0.01 then
            return Color3.fromHSV(p30.hue, p30.strength, v32);
        end;
    end;

    return recolored(p29, p30.hue, p30.strength);
end;

function u1.sequence(p33, p34) -- Line: 132
    -- upvalues: u1 (copy)
    local v35 = {};

    for i, v in ipairs(p33.Keypoints) do
        v35[i] = ColorSequenceKeypoint.new(v.Time, u1.one(v.Value, p34));
    end;

    return ColorSequence.new(v35);
end;

function u1.apply(p36, p37, p38, p39) -- Line: 140
    -- upvalues: u1 (copy)
    return u1.sequence(p36, u1.prepare({}, p37, p38, p39));
end;

function u1.driven(p40, p41, p42) -- Line: 144
    -- upvalues: u1 (copy)
    if p40._lookStamp == p42.colorStamp and p40._lookFrom == p41 then
        return p40._lookColor;
    end;

    local v43 = u1.one(p41, p42.look);
    p40._lookStamp = p42.colorStamp;
    p40._lookFrom = p41;
    p40._lookColor = v43;

    return v43;
end;

return u1;