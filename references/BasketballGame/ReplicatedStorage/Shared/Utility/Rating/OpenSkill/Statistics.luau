 
 

local u1 = {};
local u2 = require(script.Parent.Gaussian).new(0, 1);

function u1.phiMajor(p3) -- Line: 6
    -- upvalues: u2 (copy)
    return u2:cdf(p3);
end;

function u1.phiMajorInverse(p4) -- Line: 10
    -- upvalues: u2 (copy)
    return u2:ppf(p4);
end;

function u1.phiMinor(p5) -- Line: 14
    -- upvalues: u2 (copy)
    return u2:pdf(p5);
end;

function u1.v(p6, p7) -- Line: 18
    -- upvalues: u1 (copy)
    local v8 = p6 - p7;
    local v9 = u1.phiMajor(v8);

    if v9 < 2.2204460492503e-16 then
        return -v8;
    end;

    return u1.phiMinor(v8) / v9;
end;

function u1.w(p10, p11) -- Line: 24
    -- upvalues: u1 (copy)
    local v12 = p10 - p11;

    return u1.phiMajor(v12) < 2.2204460492503e-16 and (p10 < 0 and 1 or 0) or u1.v(p10, p11) * (u1.v(p10, p11) + v12);
end;

function u1.vt(p13, p14) -- Line: 33
    -- upvalues: u1 (copy)
    local math_abs_ret = math.abs(p13);
    local v15 = u1.phiMajor(p14 - math_abs_ret) - u1.phiMajor(-p14 - math_abs_ret);

    if v15 < 0.00001 then
        if p13 < 0 then
            return -p13 - p14;
        end;

        return -p13 + p14;
    end;

    local v16 = u1.phiMinor(-p14 - math_abs_ret) - u1.phiMinor(p14 - math_abs_ret);

    if p13 < 0 then
        v16 = -v16;
    end;

    return v16 / v15;
end;

function u1.wt(p17, p18) -- Line: 44
    -- upvalues: u1 (copy)
    local math_abs_ret = math.abs(p17);
    local v19 = u1.phiMajor(p18 - math_abs_ret) - u1.phiMajor(-p18 - math_abs_ret);

    return v19 < 2.2204460492503e-16 and 1 or ((p18 - math_abs_ret) * u1.phiMinor(p18 - math_abs_ret) + (p18 + math_abs_ret) * u1.phiMinor(-p18 - math_abs_ret)) / v19 + u1.vt(p17, p18) * u1.vt(p17, p18);
end;

return u1;