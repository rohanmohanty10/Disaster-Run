 
 

local sRGB = require(script.Parent.sRGB);
local u5 = {
    fromLinear = function(p1) -- Line: 42, Name: fromLinear
        local v2 = (p1.R * 0.4122214708 + p1.G * 0.5363325363 + p1.B * 0.0514459929) ^ 0.3333333333333333;
        local v3 = (p1.R * 0.2119034982 + p1.G * 0.6806995451 + p1.B * 0.1073969566) ^ 0.3333333333333333;
        local v4 = (p1.R * 0.0883024619 + p1.G * 0.2817188376 + p1.B * 0.6299787005) ^ 0.3333333333333333;

        return Vector3.new(v2 * 0.2104542553 + v3 * 0.793617785 - v4 * 0.0040720468, v2 * 1.9779984951 - v3 * 2.428592205 + v4 * 0.4505937099, v2 * 0.0259040371 + v3 * 0.7827717662 - v4 * 0.808675766);
    end
};

function u5.fromSRGB(p6) -- Line: 59
    -- upvalues: u5 (copy), sRGB (copy)
    return u5.fromLinear(sRGB.toLinear(p6));
end;

function u5.toLinear(p7: vector, p8: boolean?) -- Line: 65
    local v9 = (p7.X + p7.Y * 0.3963377774 + p7.Z * 0.2158037573) ^ 3;
    local v10 = (p7.X - p7.Y * 0.1055613458 - p7.Z * 0.0638541728) ^ 3;
    local v11 = (p7.X - p7.Y * 0.0894841775 - p7.Z * 1.291485548) ^ 3;
    local v12 = v9 * 4.0767416621 - v10 * 3.3077115913 + v11 * 0.2309699292;
    local v13 = v9 * -1.2684380046 + v10 * 2.6097574011 - v11 * 0.3413193965;
    local v14 = v9 * -0.0041960863 - v10 * 0.7034186147 + v11 * 1.707614701;

    if not p8 then
        v12 = math.clamp(v12, 0, 1);
        v13 = math.clamp(v13, 0, 1);
        v14 = math.clamp(v14, 0, 1);
    end;

    return Color3.new(v12, v13, v14);
end;

function u5.toSRGB(p15: vector, p16: boolean?) -- Line: 89
    -- upvalues: sRGB (copy), u5 (copy)
    return sRGB.fromLinear(u5.toLinear(p15, p16));
end;

return u5;