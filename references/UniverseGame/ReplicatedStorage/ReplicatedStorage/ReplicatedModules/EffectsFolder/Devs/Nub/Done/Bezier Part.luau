  

 

local random = math.random;
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local wrap = coroutine.wrap;

local function quadBezier(p1, p2, p3, p4) -- Line: 6
    return (1 - p4) ^ 2 * p1 + 2 * (1 - p4) * p4 * p2 + p4 ^ 2 * p3;
end;

return function(u5, p6, p7, u8, u9, u10, u11, p12) -- Line: 10
    -- upvalues: wrap (copy), random (copy), RunService (copy), Debris (copy)
    local u13 = 1 / (p7 or 0.5);

    if p12 then
        local v14 = ColorSequence.new(unpack(p12));
        u5 = u5:Clone();

        for _, descendant in ipairs(u5:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Color = v14;
            end;
        end;
    end;

    for _ = 1, p6 do
        wrap(function() -- Line: 23
            -- upvalues: u5 (ref), u8 (copy), u9 (copy), random (ref), u10 (copy), u11 (copy), RunService (ref), u13 (copy), Debris (ref)
            local u15 = u5:Clone();
            u15.Anchored = true;
            u15.Parent = workspace.Effects;
            u15.Transparency = 1;
            local u16 = 0;
            local v17 = (u8.Position + u9.Position) / 2;
            local v18 = random(u10.Min, u10.Max);
            local v19 = random(u10.Min, u10.Max);

            if u11 then
                if u11[1] and random(2) == 1 then
                    v18 = v18 * -1;
                end;

                if u11[2] and random(2) == 1 then
                    v19 = v19 * -1;
                end;
            end;

            local u20 = CFrame.new(v17, u9.Position) * CFrame.new(v18, v19, 0);
            local u21 = nil;
            u21 = RunService.RenderStepped:Connect(function(p22) -- Line: 41
                -- upvalues: u16 (ref), u13 (ref), u21 (ref), Debris (ref), u15 (copy), u8 (ref), u20 (ref), u9 (ref)
                u16 = u16 + p22 * u13;

                if u16 > 1 then
                    u21:Disconnect();
                    Debris:AddItem(u15, 1);
                    u16 = 1;
                end;

                local v23 = u16;
                u15.CFrame = CFrame.new((1 - v23) ^ 2 * u8.Position + 2 * (1 - v23) * v23 * u20.Position + v23 ^ 2 * u9.Position);
            end);
        end)();
    end;
end;