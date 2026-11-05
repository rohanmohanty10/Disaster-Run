  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local u1 = nil;
local u13 = {
    [0] = function(p2) -- Line: 38, Name: BlackTransition
        -- upvalues: TweenService (copy)
        local v3 = p2.Time or 0.25;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = game.Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false), {
            Brightness = -50
        }):Play();

        if v3 > 0 then
            task.wait(v3);
        end;

        local v4 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false), {
            Brightness = 0
        });
        v4:Play();
        v4.Completed:Once(function() -- Line: 49
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect:Destroy();
        end);
    end,

    [1] = function(p5) -- Line: 6, Name: Entrance
        -- upvalues: u1 (ref), RunService (copy), TweenService (copy)
        if u1 ~= nil then
            u1:Disconnect();
        end;

        local u6 = 0;
        u1 = RunService.PreRender:Connect(function(p7) -- Line: 11
            -- upvalues: u6 (ref), u1 (ref), TweenService (ref)
            u6 = u6 + p7;

            if u6 >= 1 then
                u1:Disconnect();
                u1 = nil;
            end;

            local v8 = TweenService:GetValue(u6, Enum.EasingStyle.Back, Enum.EasingDirection.In);
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(0, 0, (math.rad(v8 * 180)));
        end);
    end,

    [2] = function(p9) -- Line: 22, Name: Exit
        -- upvalues: u1 (ref), RunService (copy), TweenService (copy)
        if u1 ~= nil then
            u1:Disconnect();
        end;

        local u10 = 1;
        u1 = RunService.PreRender:Connect(function(p11) -- Line: 27
            -- upvalues: u10 (ref), u1 (ref), TweenService (ref)
            u10 = u10 - p11;

            if u10 <= 0 then
                u1:Disconnect();
                u1 = nil;
            end;

            local v12 = TweenService:GetValue(u10, Enum.EasingStyle.Back, Enum.EasingDirection.In);
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(0, 0, (math.rad(v12 * -180)));
        end);
    end
};

return function(p14, p15) -- Line: 59
    -- upvalues: u13 (copy)
    local v16 = p15 or {};

    if p14 ~= nil and u13[p14] ~= nil then
        u13[p14](v16);
    end;
end;