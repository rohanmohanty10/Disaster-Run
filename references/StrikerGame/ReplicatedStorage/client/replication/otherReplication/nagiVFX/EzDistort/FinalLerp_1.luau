 
 

local RunService = game:GetService("RunService");
local u1 = RunService:IsServer();
local FastSignal = require(script:WaitForChild("FastSignal"));
local Maid = require(script:FindFirstChild("Maid"));
local u2 = {};
local u3 = {};
u3.__index = u3;
local u4 = { "CFrame", "Vector3", "Color3", "UDim2", "number" };

local function Lerp(p5: number, p6: number, p7: number, p8: number) -- Line: 76
    local v9 = p5 + (p6 - p5) * p7;

    if (p8 or 0) > math.abs(p6 - v9) then
        v9 = p6 or v9;
    end;

    return v9;
end;

local function IsSupportedType(p10) -- Line: 84
    -- upvalues: u4 (copy)
    return table.find(u4, (typeof(p10))) and true or false;
end;

local function IsFunction(p11) -- Line: 88
    return typeof(p11) == "function";
end;

function u2.newLerpParams(p12: table?) -- Line: 92
    local v13 = p12 or {};

    return {
        LerpTime = v13.LerpTime or 1,
        LerpTarget = v13.LerpTarget,
        LerpFailTarget = v13.LerpFailTarget,
        LerpFailTime = v13.LerpFailTime,
        Snap = v13.Snap or 0,
        LerpCondition = v13.LerpCondition or function() -- Line: 103
            return true;
        end,
        CustomLerp = v13.CustomLerp,
        CustomFailLerp = v13.CustomFailLerp
    };
end;

function u2.new(p14: any, p15: table?) -- Line: 114
    -- upvalues: u2 (copy), u3 (copy), u4 (copy), FastSignal (copy), Maid (copy), u1 (copy), RunService (copy)
    local v16 = {
        LerpParams = u2.newLerpParams(p15)
    };
    local u17 = setmetatable(v16, u3);

    if not table.find(u4, (typeof(p14))) then
        error((`Attempt to lerp unsupported type '{typeof(p14)}'.`));
    end;

    u17.StartingValue = p14;
    u17.LerpValue = p14;

    local function u22(p18: number, p19: any, p20: number) -- Line: 126
        -- upvalues: u17 (copy)
        local v21 = 1 - math.pow(0.5, 1 / p20 * p18);

        return u17.LerpValue:Lerp(p19 or u17.LerpValue, v21);
    end;

    local u45 = {
        number = function(p23: number, p24: number, p25: number) -- Line: 132, Name: number
            -- upvalues: u17 (copy)
            local v26 = 1 - math.pow(0.5, 1 / p25 * p23);
            local LerpValue = u17.LerpValue;
            local v27 = p24 or u17.LerpValue;
            local v28 = u17.LerpParams.Snap or 0;
            local v29 = LerpValue + (v27 - LerpValue) * v26;

            if math.abs(v27 - v29) < v28 then
                v29 = v27 or v29;
            end;

            return v29;
        end,

        Color3 = function(p30: number, p31: number, p32: number) -- Line: 137, Name: Color3
            -- upvalues: u22 (copy)
            return u22(p30, p31, p32);
        end,

        Vector2 = function(p33: number, p34: number, p35: number) -- Line: 141, Name: Vector2
            -- upvalues: u22 (copy)
            return u22(p33, p34, p35);
        end,

        Vector3 = function(p36: number, p37: number, p38: number) -- Line: 145, Name: Vector3
            -- upvalues: u22 (copy)
            return u22(p36, p37, p38);
        end,

        CFrame = function(p39: number, p40: number, p41: number) -- Line: 149, Name: CFrame
            -- upvalues: u22 (copy)
            return u22(p39, p40, p41);
        end,

        UDim2 = function(p42: number, p43: number, p44: number) -- Line: 153, Name: UDim2
            -- upvalues: u22 (copy)
            return u22(p42, p43, p44);
        end
    };
    u17.Updated = FastSignal.new();
    u17.Maid = Maid.new();
    u17.Maid:GiveTask((not u1 and RunService.RenderStepped or RunService.Stepped):Connect(function(p46: number) -- Line: 162
        -- upvalues: u17 (copy), u45 (copy)
        local LerpCondition = u17:GetLerpCondition();
        local LerpTime = u17:GetLerpTime(LerpCondition);
        local LerpTarget = u17:GetLerpTarget(LerpCondition, p46);
        local CustomLerp = u17:GetCustomLerp(LerpTarget, LerpCondition, p46);
        local v47 = typeof(u17.LerpValue);

        if CustomLerp then
            u17.LerpValue = CustomLerp;
        else
            u17.LerpValue = u45[v47](p46, LerpTarget, LerpTime);
        end;

        u17.Updated:Fire(p46, u17.LerpValue);
    end));

    return u17;
end;

function u3.GetLerpCondition(p48) -- Line: 182
    local LerpCondition = p48.LerpParams.LerpCondition;

    return not LerpCondition and true or LerpCondition();
end;

function u3.GetCustomLerp(p49: table, p50: any, p51: boolean, p52: number) -- Line: 193
    local CustomLerp = p49.LerpParams.CustomLerp;
    local v53 = p49.LerpParams.CustomFailLerp or CustomLerp;

    if CustomLerp and p51 then
        return CustomLerp(p49:Get(), p50, p52);
    end;

    if v53 and not p51 then
        return v53(p49:Get(), p50, p52);
    end;
end;

function u3.GetLerpTarget(p54: table, p55: boolean, p56: number) -- Line: 209
    local v57 = p54.LerpParams.LerpTarget or p54.LerpValue;
    local v58 = p54.LerpParams.LerpFailTarget or p54.LerpParams.LerpTarget;

    if typeof(v57) == "function" then
        v57 = v57(p56);
    end;

    if typeof(v58) == "function" then
        v58 = v58(p56);
    end;

    if p55 then
        v58 = v57 or v58;
    end;

    return v58;
end;

function u3.GetLerpTime(p59: table, p60: boolean) -- Line: 225
    local LerpTime = p59.LerpParams.LerpTime;
    local v61 = p59.LerpParams.LerpFailTime or p59.LerpParams.LerpTime;

    if typeof(LerpTime) == "function" then
        LerpTime = LerpTime();
    end;

    if typeof(v61) == "function" then
        v61 = v61();
    end;

    if p60 then
        v61 = LerpTime or v61;
    end;

    return v61;
end;

function u3.SetTarget(p62, p63) -- Line: 241
    p62.LerpParams.LerpTarget = p63 or p62.LerpValue;
end;

function u3.SetLerpCondition(p64: table, p65: function) -- Line: 246
    p64.LerpParams.LerpCondition = p65 or function() -- Line: 247
        return true;
    end;
end;

function u3.GetLerpParams(p66) -- Line: 253
    return p66.LerpParams;
end;

function u3.UpdateLerpParams(p67: table, p68: table?) -- Line: 258
    -- upvalues: u2 (copy)
    p67.LerpParams = u2.newLerpParams(p68);
end;

function u3.Get(p69) -- Line: 263
    return p69.LerpValue;
end;

function u3.Destroy(p70) -- Line: 268
    if p70.Updated then
        p70.Updated:Destroy();
        p70.Updated = nil;
    end;

    p70.Maid:DoCleaning();
    setmetatable(p70, nil);

    for i, _ in p70 do
        p70[i] = nil;
    end;
end;

u3.GetValue = u3.Get;

return u2;