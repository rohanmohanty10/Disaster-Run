  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2, u3, u4) -- Line: 3
    -- upvalues: TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "TSEffect";
    ColorCorrectionEffect.Parent = game.Lighting;
    local v5 = TweenService:Create(game.Lighting.TSEffect, TweenInfo.new(u3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Brightness = p2,
        TintColor = p1
    });
    v5:Play();
    v5.Completed:connect(function() -- Line: 10
        -- upvalues: u4 (copy), TweenService (ref), u3 (copy), ColorCorrectionEffect (copy)
        wait(u4);
        local v6 = TweenService:Create(game.Lighting.TSEffect, TweenInfo.new(u3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Brightness = 0.04,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        v6:Play();
        v6.Completed:connect(function() -- Line: 14
            -- upvalues: ColorCorrectionEffect (ref)
            pcall(function() -- Line: 15
                -- upvalues: ColorCorrectionEffect (ref)
                ColorCorrectionEffect:Destroy();
            end);
        end);
    end);
end;