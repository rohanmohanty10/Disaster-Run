 
 

local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;

function u1.new(p2: any, p3: number, p4: number?) -- Line: 35
    -- upvalues: u1 (copy)
    local v5 = {
        Current = p2,
        Target = p2
    };
    local v6;

    if typeof(p2) == "CFrame" then
        v6 = CFrame.identity;
    else
        v6 = p2 * 0;
    end;

    v5.Velocity = v6;
    v5.SmoothTime = p3;
    v5.MaxSpeed = p4 == nil and (1 / 0) or p4;

    return setmetatable(v5, u1);
end;

function u1.Update(p7: any, p8: number) -- Line: 60
    -- upvalues: TweenService (copy)
    local v9, v10 = TweenService:SmoothDamp(p7.Current, p7.Target, p7.Velocity, p7.SmoothTime, p7.MaxSpeed, p8);
    p7.Current = v9;
    p7.Velocity = v10;

    return p7.Current;
end;

function u1.Impulse(p11, p12) -- Line: 79
    p11.Velocity = p11.Velocity + p12;
end;

function u1.Reset(p13, p14) -- Line: 91
    p13.Current = p14;
    p13.Target = p14;
    local v15;

    if typeof(p13.Current) == "CFrame" then
        v15 = CFrame.identity;
    else
        v15 = p13.Current * 0;
    end;

    p13.Velocity = v15;
end;

return u1;