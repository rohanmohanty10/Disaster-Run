 

 

local u1 = {};
local EngineAttr = require(script.Parent.EngineAttr);

function u1.resolve(p2, p3, p4) -- Line: 13
    if p2 then
        p2 = p2:GetAttribute(p3);
    end;

    if typeof(p2) ~= "NumberRange" or p2.Min == 0 and p2.Max == 0 then
        local math_floor_ret = math.floor(p4 or 12);

        return math.max(1, math_floor_ret);
    end;

    local v5 = p2.Min + (p2.Max - p2.Min) * math.random();
    local math_floor_ret = math.floor(v5 + (v5 >= 0 and 0.5 or -0.5));

    if math_floor_ret ~= 0 then
        return math_floor_ret;
    end;

    local math_floor_ret2 = math.floor(p4 or 12);

    return math.max(1, math_floor_ret2);
end;

function u1.step(u6, u7, u8, u9, u10) -- Line: 26
    -- upvalues: u1 (copy)
    local math_abs_ret = math.abs(u7);

    local function reroll() -- Line: 28
        -- upvalues: u7 (ref), u1 (ref), u8 (copy), u9 (copy), u10 (copy), math_abs_ret (ref), u6 (ref)
        u7 = u1.resolve(u8, u9, u10);
        math_abs_ret = math.abs(u7);

        if u7 > 0 then
            u6 = 1;

            return;
        end;

        u6 = math_abs_ret;
    end;

    if math_abs_ret == 0 or u6 == 0 then
        u7 = u1.resolve(u8, u9, u10);
        math_abs_ret = math.abs(u7);

        if u7 > 0 then
            u6 = 1;
        else
            u6 = math_abs_ret;
        end;
    elseif u7 > 0 then
        u6 = u6 + 1;

        if math_abs_ret < u6 then
            u7 = u1.resolve(u8, u9, u10);
            math_abs_ret = math.abs(u7);

            if u7 > 0 then
                u6 = 1;
            else
                u6 = math_abs_ret;
            end;
        end;
    else
        u6 = u6 - 1;

        if u6 < 1 then
            u7 = u1.resolve(u8, u9, u10);
            math_abs_ret = math.abs(u7);

            if u7 > 0 then
                u6 = 1;
            else
                u6 = math_abs_ret;
            end;
        end;
    end;

    return u6, u7, math_abs_ret;
end;

function u1.evenFlags(p11) -- Line: 46
    if p11 then
        return (p11:GetAttribute("PosXEven") or (p11:GetAttribute("PosYEven") or p11:GetAttribute("PosZEven"))) == true, (p11:GetAttribute("RotXEven") or (p11:GetAttribute("RotYEven") or p11:GetAttribute("RotZEven"))) == true;
    end;

    return false, false;
end;

function u1.advance(p12, p13, p14, p15, p16, p17) -- Line: 59
    -- upvalues: u1 (copy)
    local v18 = p12[p13];

    if not v18 then
        v18 = { 0, 0, 0, 0 };
        p12[p13] = v18;
    end;

    local v19 = 0;
    local v20 = 0;
    local v21, v22;

    if p16 and u1.isSet(p14, "PositionEvenCycle") then
        local v23, v24;
        v23, v24, v21 = u1.step(v18[1], v18[2], p14, "PositionEvenCycle", p15);
        v18[1] = v23;
        v18[2] = v24;
        v22 = v18[1];
    else
        v22 = 0;
        v21 = 0;
    end;

    if p17 and u1.isSet(p14, "RotationEvenCycle") then
        local v25, v26;
        v25, v26, v20 = u1.step(v18[3], v18[4], p14, "RotationEvenCycle", p15);
        v18[3] = v25;
        v18[4] = v26;
        v19 = v18[3];
    end;

    return v22, v21, v19, v20;
end;

function u1.isSet(p27, p28) -- Line: 79
    if p27 then
        p27 = p27:GetAttribute(p28);
    end;

    local v29;

    if typeof(p27) == "NumberRange" then
        local v30;

        if p27.Min == 0 then
            v30 = p27.Max == 0;
        else
            v30 = false;
        end;

        v29 = not v30;
    else
        v29 = false;
    end;

    return v29;
end;

function u1.clear(p31, p32) -- Line: 85
    if p31 and p32 ~= nil then
        p31[p32] = nil;
    end;
end;

function u1.ensureIds(p33) -- Line: 95
    -- upvalues: EngineAttr (copy)
    if p33:GetAttribute("_EvenCycleId") then
        return;
    end;

    local HttpService = game:GetService("HttpService");
    EngineAttr.write(p33, "_EvenCycleId", HttpService:GenerateGUID(false));
    local RenderTemplate = p33:FindFirstChild("RenderTemplate");

    if not RenderTemplate then
        return;
    end;

    for _, descendant in ipairs(RenderTemplate:GetDescendants()) do
        if descendant:GetAttribute("Transformed") and not descendant:GetAttribute("_EvenCycleId") then
            EngineAttr.write(descendant, "_EvenCycleId", HttpService:GenerateGUID(false));
        end;
    end;
end;

return u1;