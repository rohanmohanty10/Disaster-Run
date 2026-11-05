  

 

return function(p1, p2) -- Line: 1
    for _ = 1, p2 do
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Contrast = -1;
        ColorCorrectionEffect.Parent = game.Lighting;
        game:GetService("TweenService"):Create(ColorCorrectionEffect, TweenInfo.new(p1), {
            Contrast = 0
        }):Play();
        game.Debris:AddItem(ColorCorrectionEffect, p1 + 1);
    end;
end;