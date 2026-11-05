  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");

local function u7(p1, p2) -- Line: 10
    local v3, v4, v5 = p1:ToHSV(p1);
    local v6 = v3 + p2 / 360;

    if v6 > 1 then
        v6 = v6 - 1;
    end;

    return Color3.fromHSV(v6, v4, v5);
end;

local function _(p8, p9) -- Line: 19
    local _, v10, v11 = p8:ToHSV(p8);
    local v12 = p9 / 360;

    if v12 > 1 then
        v12 = v12 - 1;
    end;

    return Color3.fromHSV(v12, v10, v11);
end;

local function ShiftObjectHue(p13, p14) -- Line: 28
    local Color = p13.Color;

    if typeof(Color) ~= "ColorSequence" then
        if typeof(Color) == "Color3" then
            local v15, v16, v17 = Color:ToHSV(Color);
            local v18 = v15 + p14 / 360;

            if v18 > 1 then
                v18 = v18 - 1;
            end;

            p13.Color = Color3.fromHSV(v18, v16, v17);
        end;

        return;
    end;

    local v19 = {};

    for i = 1, #Color.Keypoints do
        local Value = Color.Keypoints[i].Value;
        local v20, v21, v22 = Value:ToHSV(Value);
        local v23 = v20 + p14 / 360;

        if v23 > 1 then
            v23 = v23 - 1;
        end;

        local v24 = Color3.fromHSV(v23, v21, v22);
        table.insert(v19, ColorSequenceKeypoint.new(Color.Keypoints[i].Time, v24));
    end;

    p13.Color = ColorSequence.new(v19);
end;

local function ShiftObjectHueAbsolute(p25, p26) -- Line: 44
    local Color = p25.Color;

    if typeof(Color) ~= "ColorSequence" then
        if typeof(Color) == "Color3" then
            local _, v27, v28 = Color:ToHSV(Color);
            local v29 = p26 / 360;

            if v29 > 1 then
                v29 = v29 - 1;
            end;

            p25.Color = Color3.fromHSV(v29, v27, v28);
        end;

        return;
    end;

    local v30 = {};

    for i = 1, #Color.Keypoints do
        local Value = Color.Keypoints[i].Value;
        local _, v31, v32 = Value:ToHSV(Value);
        local v33 = p26 / 360;

        if v33 > 1 then
            v33 = v33 - 1;
        end;

        local v34 = Color3.fromHSV(v33, v31, v32);
        table.insert(v30, ColorSequenceKeypoint.new(Color.Keypoints[i].Time, v34));
    end;

    p25.Color = ColorSequence.new(v30);
end;

return function(p35) -- Line: 60
    -- upvalues: RunService (copy), TweenService (copy), u7 (copy), ShiftObjectHue (copy), ShiftObjectHueAbsolute (copy)
    local u36, u37 = p35("Extensions");
    local Rng = u36.Rng;
    local Sqrt = u36.Sqrt;
    local PI = u36.PI;
    local u38 = nil;
    u38 = {
        Magnitude = function(p39, p40) -- Line: 66, Name: Magnitude
            if typeof(p39) == "CFrame" then
                p39 = p39.Position;
            end;

            if typeof(p40) == "CFrame" then
                p40 = p40.Position;
            end;

            return (p40 - p39).Magnitude;
        end,

        Unit = function(p41, p42, p43) -- Line: 73, Name: Unit
            if typeof(p41) == "CFrame" then
                p41 = p41.Position;
            end;

            if typeof(p42) == "CFrame" then
                p42 = p42.Position;
            end;

            if p42 then
                return (p42 - p41).Unit * (p43 or 1);
            end;

            return p41.Unit * (p43 or 1);
        end,

        planeVector = function(p44) -- Line: 84, Name: planeVector
            -- upvalues: u37 (copy)
            if typeof(p44) == "CFrame" then
                p44 = p44.Position;
            end;

            return p44 * u37.new(1, 0, 1);
        end,

        randomVectorPos = function(p45, p46) -- Line: 90, Name: randomVectorPos
            -- upvalues: u37 (copy), Rng (copy)
            if typeof(p45) == "CFrame" then
                p45 = p45.Position;
            end;

            return p45 + u37.new(Rng(-p46, p46), Rng(-p46, p46), Rng(-p46, p46));
        end,

        randomPlaneCirclePos = function(p47, p48) -- Line: 96, Name: randomPlaneCirclePos
            -- upvalues: Sqrt (copy), Rng (copy), PI (copy), u37 (copy), u36 (copy)
            if typeof(p47) == "CFrame" then
                p47 = p47.Position;
            end;

            local v49 = p48 * Sqrt(Rng());
            local v50 = Rng() * 2 * PI;

            return p47 + u37.new(v49 * u36.Sin(v50), 0, v49 * u36.Cos(v50));
        end,

        Sleep = function(p51, p52) -- Line: 105, Name: Sleep
            -- upvalues: RunService (ref)
            local v53 = p52 or "f";

            if v53 == "s" then
                local v54 = os.clock();

                if RunService:IsClient() then
                    repeat
                        RunService.RenderStepped:Wait();
                    until p51 <= os.clock() - v54;
                else
                    repeat
                        RunService.Heartbeat:Wait();
                    until p51 <= os.clock() - v54;
                end;
            elseif v53 == "f" then
                if p51 then
                    if RunService:IsClient() then
                        for _ = 1, p51 do
                            RunService.RenderStepped:Wait();
                        end;

                        return;
                    end;

                    for _ = 1, p51 do
                        RunService.Heartbeat:Wait();
                    end;

                    return;
                end;

                if RunService:IsClient() then
                    RunService.RenderStepped:Wait();

                    return;
                end;

                RunService.Heartbeat:Wait();
            end;
        end,

        tableMerge = function(p55, p56) -- Line: 139, Name: tableMerge
            local v57 = {};

            for i, v in pairs(p55) do
                v57[i] = v;
            end;

            for i, v in pairs(p56) do
                if not v57[i] then
                    v57[i] = v;
                end;
            end;

            return v57;
        end,

        Raycast = function(p58, p59, p60, p61) -- Line: 151, Name: Raycast
            local v62 = RaycastParams.new();
            v62.FilterDescendantsInstances = p61;
            v62.FilterType = Enum.RaycastFilterType.Blacklist;
            local v63 = workspace:Raycast(p58, p59.Unit * p60, v62);

            if v63 then
                return v63.Instance, v63.Position, v63.Normal, v63.Material;
            end;
        end,

        NumericSystems = require(script.NumericSystems),
        Thread = require(script.Thread),

        Lerp = function(p64, p65, p66) -- Line: 164, Name: Lerp
            if typeof(p64) == "number" or typeof(p65) == "number" then
                return p64 + (p65 - p64) * p66;
            end;

            return p64:Lerp(p65, p66);
        end,

        QuadraticBezier = function(p67, p68, p69, p70) -- Line: 172, Name: QuadraticBezier
            -- upvalues: u38 (ref)
            if typeof(p67) == "number" or typeof(p68) == "number" then
                return u38.Lerp(u38.Lerp(p67, p68, p70), u38.Lerp(p68, p69, p70), p70);
            end;

            return p67:Lerp(p67, p68, p70):Lerp(p68, p69, p70);
        end,

        ReverseTable = function(p71) -- Line: 180, Name: ReverseTable
            local v72 = {};

            for i = #p71, 1, -1 do
                v72[i] = p71[#p71 + 1 - i];
            end;

            return v72;
        end,

        Tween = function(p73, p74, p75, p76, p77, p78) -- Line: 190, Name: Tween
            -- upvalues: TweenService (ref)
            local v79;

            if p78 == nil then
                v79 = TweenInfo.new(p74 or 1, Enum.EasingStyle[p75 or "Linear"], Enum.EasingDirection[p76 or "In"]);
            else
                v79 = TweenInfo.new(p74 or 1, Enum.EasingStyle[p75 or "Linear"], Enum.EasingDirection[p76 or "In"], p78, true);
            end;

            local v80 = TweenService:Create(p73, v79, p77);
            v80:Play();

            return v80;
        end,

        TweenCallback = function(p81, p82, u83, p84, p85, p86, p87, p88, p89) -- Line: 202, Name: TweenCallback
            -- upvalues: TweenService (ref)
            local v90 = TweenService:Create(p81, TweenInfo.new(p84 or 0.5, p85 or Enum.EasingStyle.Quad, p86 or Enum.EasingDirection.Out, p87 or 0, p88 or false, p89 or 0), p82);
            v90.Completed:Connect(function() -- Line: 213
                -- upvalues: u83 (copy)
                if u83 then
                    u83();
                end;
            end);
            v90:Play();
        end,

        inverseLerp = function(p91, p92, p93) -- Line: 221, Name: inverseLerp
            return (p93 - p91) / (p92 - p91);
        end,

        HueShift = u7,
        ShiftObjectHue = ShiftObjectHue,
        ShiftObjectHueAbsolute = ShiftObjectHueAbsolute
    };

    return u38;
end;