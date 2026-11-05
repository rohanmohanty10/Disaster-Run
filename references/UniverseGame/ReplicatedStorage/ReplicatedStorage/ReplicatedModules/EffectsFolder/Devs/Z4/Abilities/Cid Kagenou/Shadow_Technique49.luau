  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local v2 = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);

    if not p1 then
        for _, child in game.Lighting:GetChildren() do
            if child:IsA("BlurEffect") or child:IsA("ColorCorrectionEffect") and child:GetAttribute("Shadow_Technique49") then
                if child:IsA("BlurEffect") then
                    local v3 = TweenService:Create(child, v2, {
                        Size = 0
                    });
                    v3:Play();
                    v3.Completed:Once(function() -- Line: 34
                        -- upvalues: child (copy)
                        child:Destroy();
                    end);
                elseif child:IsA("ColorCorrectionEffect") then
                    local v4 = TweenService:Create(child, v2, {
                        Brightness = 0,
                        Contrast = 0,
                        Saturation = 0
                    });
                    v4:Play();
                    v4.Completed:Once(function() -- Line: 45
                        -- upvalues: child (copy)
                        child:Destroy();
                    end);
                end;
            end;
        end;

        return;
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game.Lighting;
    ColorCorrectionEffect:SetAttribute("Shadow_Technique49", true);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 0;
    BlurEffect.Parent = game.Lighting;
    ColorCorrectionEffect:SetAttribute("Shadow_Technique49", true);
    TweenService:Create(ColorCorrectionEffect, v2, {
        Brightness = -0.5,
        Contrast = -5,
        Saturation = -1
    }):Play();
    TweenService:Create(BlurEffect, v2, {
        Size = 8
    }):Play();
end;