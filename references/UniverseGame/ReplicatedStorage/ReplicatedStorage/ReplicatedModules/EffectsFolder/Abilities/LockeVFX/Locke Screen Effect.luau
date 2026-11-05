  

 

return function() -- Line: 1
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 15;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Contrast = 1;
    ColorCorrectionEffect.Saturation = -2;
    BlurEffect.Parent = game.Lighting;
    ColorCorrectionEffect.Parent = game.Lighting;
    task.delay(0.25, function() -- Line: 12
        -- upvalues: BlurEffect (copy), ColorCorrectionEffect (copy)
        BlurEffect:Destroy();
        ColorCorrectionEffect:Destroy();
    end);
end;