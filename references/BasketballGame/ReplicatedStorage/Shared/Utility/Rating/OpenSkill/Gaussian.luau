 
 

local function erfc(p1: number) -- Line: 6
    local math_abs_ret = math.abs(p1);
    local v2 = 1 / (math_abs_ret / 2 + 1);
    local v3 = v2 * math.exp(-math_abs_ret * math_abs_ret - 1.26551223 + v2 * (v2 * (v2 * (v2 * (v2 * (v2 * (v2 * (v2 * (v2 * 0.17087277 + -0.82215223) + 1.48851587) + -1.13520398) + 0.27886807) + -0.18628806) + 0.09678418) + 0.37409196) + 1.00002368));

    if p1 < 0 then
        return 2 - v3;
    end;

    return v3;
end;

local function ierfc(p4: number) -- Line: 16
    -- upvalues: erfc (copy)
    if p4 >= 2 then
        return -100;
    end;

    if p4 <= 0 then
        return 100;
    end;

    local v5;

    if p4 < 1 then
        v5 = p4;
    else
        v5 = 2 - p4;
    end;

    local v6 = math.log(v5 / 2) * -2;
    local math_sqrt_ret = math.sqrt(v6);
    local v7 = ((math_sqrt_ret * 0.27061 + 2.30753) / (math_sqrt_ret * (math_sqrt_ret * 0.04481 + 0.99229) + 1) - math_sqrt_ret) * -0.70711;

    for i = 1, 2 do
        local v8 = erfc(v7) - v5;
        v7 = v7 + v8 / (math.exp(-(v7 * v7)) * 1.1283791670955126 - v7 * v8);
        local _ = i;
    end;

    if p4 < 1 then
        return v7;
    end;

    return -v7;
end;

local u9 = {};
u9.__index = u9;

local function fromPrecisionMean(p10: number, p11: number) -- Line: 33
    -- upvalues: u9 (copy)
    return u9.new(p11 / p10, 1 / p10);
end;

function u9.__mul(p12, p13) -- Line: 37
    -- upvalues: fromPrecisionMean (copy)
    if type(p13) == "number" then
        return p12:scale(p13);
    end;

    local v14 = 1 / p12.variance;
    local v15 = 1 / p13.variance;

    return fromPrecisionMean(v14 + v15, v14 * p12.mean + v15 * p13.mean);
end;

function u9.__div(p16, p17) -- Line: 48
    -- upvalues: fromPrecisionMean (copy)
    if type(p17) == "number" then
        return p16:scale(1 / p17);
    end;

    local v18 = 1 / p16.variance;
    local v19 = 1 / p17.variance;

    return fromPrecisionMean(v18 - v19, v18 * p16.mean - v19 * p17.mean);
end;

function u9.__add(p20, p21) -- Line: 59
    -- upvalues: u9 (copy)
    if type(p21) == "number" then
        error("Only gaussians can be added");
    end;

    return u9.new(p20.mean + p21.mean, p20.variance + p21.variance);
end;

function u9.__sub(p22, p23) -- Line: 66
    -- upvalues: u9 (copy)
    if type(p23) == "number" then
        error("Only gaussians can be subtracted");
    end;

    return u9.new(p22.mean - p23.mean, p22.variance + p23.variance);
end;

function u9.new(p24: number, p25: number) -- Line: 73
    -- upvalues: u9 (copy)
    if p25 <= 0 then
        error("Variance must be > 0, but is " .. p25);
    end;

    local v26 = {
        mean = p24,
        variance = p25,
        standardDeviation = math.sqrt(p25)
    };

    return setmetatable(v26, u9);
end;

function u9.random(p27: table, p28: number) -- Line: 86
    local mean = p27.mean;
    local standardDeviation = p27.standardDeviation;
    local v29 = {};

    for i = 1, p28 do
        local v30 = math.log(math.random()) * -2;
        local math_sqrt_ret = math.sqrt(v30);
        local v31 = 6.283185307179586 * math.random();
        local v32 = math_sqrt_ret * math.cos(v31) * standardDeviation + mean;
        table.insert(v29, v32);
        local _ = i;
    end;

    return v29;
end;

function u9.pdf(p33: table, p34: number) -- Line: 99
    local v35 = -math.pow(p34 - p33.mean, 2) / (2 * p33.variance);

    return math.exp(v35) / (p33.standardDeviation * 2.5066282746310002);
end;

function u9.cdf(p36: table, p37: number) -- Line: 106
    -- upvalues: erfc (copy)
    return erfc(-(p37 - p36.mean) / (p36.standardDeviation * 1.4142135623730951)) * 0.5;
end;

function u9.ppf(p38: table, p39: number) -- Line: 111
    -- upvalues: ierfc (copy)
    return p38.mean - p38.standardDeviation * 1.4142135623730951 * ierfc(p39 * 2);
end;

function u9.scale(p40: table, p41: number) -- Line: 115
    -- upvalues: u9 (copy)
    return u9.new(p40.mean * p41, p40.variance * p41 * p41);
end;

return u9;