  

 

local u1 = {
    ExperienceRequiredPerLevel = 1000,
    MaxLevel = 200,
    ResetStatCost = 1000,
    XPExponent = 2.1729399484,
    LevelBuffExponent = 1.2,
    ExperienceMaterials = {
        XP_1 = 500,
        XP_2 = 1000,
        XP_3 = 2500,
        XP_4 = 5000
    },
    AscensionRanks = {
        ["1"] = {
            Requirements = {
                UCoins = 1000000
            }
        }
    }
};
local u2 = 0;

for i, _ in pairs(u1.AscensionRanks) do
    if tonumber(i) > u2 then
        u2 = tonumber(i);
    end;
end;

function u1.CalculateLevelsFromXP(p3, p4, p5, p6) -- Line: 57
    -- upvalues: u1 (copy)
    local v7 = (type(p5) ~= "number" or (p5 < 0 or (p5 ~= p5 or p5 >= (1 / 0)))) and 0 or p5;
    local v8 = ((type(p6) ~= "number" or (p6 < 0 or (p6 ~= p6 or p6 >= (1 / 0)))) and 0 or p6) + v7;
    local v9 = 0;
    local v10 = 0;

    for i = p3, p4 do
        local v11 = u1.GetXPAtLevel(i);

        if v11 > v8 then
            v10 = v10 + v8;
            break;
        end;

        v8 = v8 - v11;
        v9 = v9 + 1;
    end;

    if v9 ~= v9 or v9 >= (1 / 0) then
        warn("NaN Levels");
        v9 = 0;
    end;

    if v10 ~= v10 or v10 >= (1 / 0) then
        warn("NaN LeftoverXP");
        v10 = 0;
    end;

    return {
        LevelsAdded = v9,
        LeftoverXP = v10
    };
end;

function u1.CalculateXPFromLevels(p12, p13, p14) -- Line: 108
    -- upvalues: u1 (copy)
    if p13 <= p12 then
        return 0;
    end;

    local v15 = (type(p14) ~= "number" or p14 < 0) and 0 or p14;
    local v16 = 0;

    for i = p12, p13 do
        v16 = v16 + u1.GetXPAtLevel(i);
    end;

    return v16 - v15;
end;

function u1.GetAscensionData(p17) -- Line: 136
    -- upvalues: u2 (ref), u1 (copy)
    local v18 = {};

    for i = 1, math.min(p17, u2) do
        local v19 = u1.AscensionRanks[tostring(i)];

        for i2, v in pairs(v19 or {}) do
            v18[i2] = v;
        end;
    end;

    return v18;
end;

function u1.GetMaxLevel(p20) -- Line: 148
    -- upvalues: u1 (copy)
    return u1.GetAscensionData(p20).MaxLevel or u1.MaxLevel;
end;

function u1.GetXPAtLevel(p21) -- Line: 152
    -- upvalues: u1 (copy)
    return p21 <= 0 and 1 or p21 ^ u1.XPExponent;
end;

function u1.GetLevelBuffs(p22) -- Line: 158
    -- upvalues: u1 (copy)
    local v23 = p22 ^ u1.LevelBuffExponent;
    local v24 = {
        DamageBonus = 1 + v23 / 100
    };
    local v25;

    if v23 >= 100 then
        v25 = 1 - v23 / (v23 + 1);
    else
        v25 = 1 - v23 / 100;
    end;

    v24.DamageReduction = v25;
    v24.ExponentValue = v23;

    return v24;
end;

return u1;