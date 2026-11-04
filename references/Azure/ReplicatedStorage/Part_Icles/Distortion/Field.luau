 

 

local u1 = {};

local function hash2(p2, p3, p4) -- Line: 18
    return ((p2 * 374761393 + p3 * 668265263 + p4 * 1442695040888963) % 2147483647 * 1103515245 + 12345) % 2147483647 % 10000 / 10000;
end;

local function smooth(p5) -- Line: 25
    return p5 * p5 * (3 - 2 * p5);
end;

local function valueNoise(p6, p7, p8) -- Line: 30
    local math_floor_ret = math.floor(p6);
    local math_floor_ret2 = math.floor(p7);
    local v9 = p6 - math_floor_ret;
    local v10 = v9 * v9 * (3 - 2 * v9);
    local v11 = p7 - math_floor_ret2;
    local v12 = ((math_floor_ret * 374761393 + math_floor_ret2 * 668265263 + p8 * 1442695040888963) % 2147483647 * 1103515245 + 12345) % 2147483647 % 10000 / 10000;
    local v13 = ((math_floor_ret * 374761393 + (math_floor_ret2 + 1) * 668265263 + p8 * 1442695040888963) % 2147483647 * 1103515245 + 12345) % 2147483647 % 10000 / 10000;
    local v14 = v12 + ((((math_floor_ret + 1) * 374761393 + math_floor_ret2 * 668265263 + p8 * 1442695040888963) % 2147483647 * 1103515245 + 12345) % 2147483647 % 10000 / 10000 - v12) * v10;

    return (v14 + (v13 + ((((math_floor_ret + 1) * 374761393 + (math_floor_ret2 + 1) * 668265263 + p8 * 1442695040888963) % 2147483647 * 1103515245 + 12345) % 2147483647 % 10000 / 10000 - v13) * v10 - v14) * (v11 * v11 * (3 - 2 * v11))) * 2 - 1;
end;

u1.valueNoise = valueNoise;

function u1.addRipple(p15, p16, p17, p18, p19, p20, p21, p22, p23, p24) -- Line: 48
    if p20 == 0 then
        return;
    end;

    local v25 = 1 / math.max(p21, 0.02);

    for i = 1, p18 do
        local v26 = (p16[i] - p23) * p19;
        local v27 = p17[i] - p24;
        local v28 = (math.sqrt(v26 * v26 + v27 * v27) - p22) * v25;
        p15[i] = p15[i] + p20 * math.cos(6.283185307179586 * v28) * math.exp(-v28 * v28 * 4);
        local _ = i;
    end;
end;

function u1.addWave(p29, p30, p31, p32, p33, p34, p35, p36, p37) -- Line: 63
    if p34 == 0 then
        return;
    end;

    local math_max_ret = math.max(p35, 0.02);
    local v38 = math.cos(p37) / math_max_ret;
    local v39 = math.sin(p37) / math_max_ret;

    for i = 1, p32 do
        p29[i] = p29[i] + p34 * math.sin(6.283185307179586 * (p30[i] * p33 * v38 + p31[i] * v39 - p36 / math_max_ret));
        local _ = i;
    end;
end;

function u1.addNoise(p40, p41, p42, p43, p44, p45, p46, p47, p48, p49) -- Line: 77
    -- upvalues: valueNoise (copy)
    if p45 == 0 then
        return;
    end;

    local v50 = math.cos(p48) * p47;
    local v51 = math.sin(p48) * p47;

    for i = 1, p43 do
        local v52 = (p41[i] * p44 - v50) * p46;
        local v53 = (p42[i] - v51) * p46;
        p40[i] = p40[i] + p45 * (valueNoise(v52, v53, p49) + 0.5 * valueNoise(v52 * 2.13, v53 * 2.13, p49 + 71));
        local _ = i;
    end;
end;

function u1.addLens(p54, p55, p56, p57, p58, p59, p60, p61, p62) -- Line: 89
    if p59 == 0 then
        return;
    end;

    local math_max_ret = math.max(p60, 0.02);
    local v63 = 1 / (math_max_ret * math_max_ret);

    for i = 1, p57 do
        local v64 = (p55[i] - p61) * p58;
        local v65 = p56[i] - p62;
        local v66 = 1 - (v64 * v64 + v65 * v65) * v63;
        local v67;

        if v66 > 0 then
            p54[i] = p54[i] + p59 * v66 * v66;
            v67 = i;
        else
            v67 = i;
        end;
    end;
end;

function u1.zero(p68, p69) -- Line: 104
    for i = 1, p69 do
        p68[i] = 0;
        local _ = i;
    end;
end;

function u1.accumulate(p70, p71, p72, p73, p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84) -- Line: 112
    -- upvalues: u1 (copy)
    if p70 == 1 then
        u1.addRipple(p71, p72, p73, p74, p75, p76, p77, p78, p82, p83);

        return;
    end;

    if p70 == 2 then
        u1.addWave(p71, p72, p73, p74, p75, p76, p77, p78, p79);

        return;
    end;

    if p70 == 3 then
        u1.addNoise(p71, p72, p73, p74, p75, p76, p80, p78, p79, p84);

        return;
    end;

    if p70 == 4 then
        u1.addLens(p71, p72, p73, p74, p75, p76, p81, p82, p83);

        return;
    end;

    if p70 == 5 then
        u1.addLens(p71, p72, p73, p74, p75, -p76, p81, p82, p83);
    end;
end;

return u1;