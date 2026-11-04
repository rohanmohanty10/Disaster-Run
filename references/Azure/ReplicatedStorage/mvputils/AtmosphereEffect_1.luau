 
 

local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");

return function(p1: string, p2: table, p3: number, p4: any, p5: any) -- Line: 22
    -- upvalues: Lighting (copy), TweenService (copy)
    local u6 = Lighting:FindFirstChildOfClass("Atmosphere");

    if not u6 then
        warn("[AtmosphereEffect] No Atmosphere found in Lighting.");

        return;
    end;

    local u7 = {};

    for i in pairs(p2) do
        u7[i] = u6[i];
    end;

    if p1 ~= "emit" then
        if p1 ~= "instant" then
            warn("[AtmosphereEffect] Unknown mode:", p1);

            return;
        end;

        for i, v in pairs(p2) do
            u6[i] = v;
        end;

        task.delay(p3 or 0.1, function() -- Line: 69
            -- upvalues: u6 (copy), u7 (copy)
            if not (u6 and u6.Parent) then
                return;
            end;

            for i, v in pairs(u7) do
                u6[i] = v;
            end;
        end);

        return;
    end;

    local v8 = p3 or 0.3;
    local v9 = p4 or Enum.EasingStyle.Sine;
    local v10 = TweenService:Create(u6, TweenInfo.new(v8, v9, p5 or Enum.EasingDirection.Out), p2);
    local u11 = TweenService:Create(u6, TweenInfo.new(v8, v9, Enum.EasingDirection.In), u7);
    v10:Play();
    v10.Completed:Connect(function() -- Line: 58
        -- upvalues: u11 (copy)
        u11:Play();
    end);
end;