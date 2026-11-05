  

 

local TweenService = game:GetService("TweenService");

local function tweendeb(p1, p2) -- Line: 2
    p1:Play();
    p1.Completed:Wait();

    if p2 then
        p2:Destroy();
    end;

    return true;
end;

return function() -- Line: 9
    -- upvalues: TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting);
    local v3, v4 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05), {
        Saturation = -1,
        Contrast = -2
    });
    v3:Play();
    v3.Completed:Wait();

    if v4 then
        v4:Destroy();
    end;

    local v5 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
        Saturation = 0,
        Contrast = 0
    });
    v5:Play();
    v5.Completed:Wait();

    if ColorCorrectionEffect then
        ColorCorrectionEffect:Destroy();
    end;
end;