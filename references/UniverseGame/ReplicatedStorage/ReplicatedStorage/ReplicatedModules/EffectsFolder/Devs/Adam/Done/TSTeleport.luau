  

 

local CurrentCamera = workspace.CurrentCamera;

return function(p1) -- Line: 3
    -- upvalues: CurrentCamera (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "TSTeleportEffect";
    ColorCorrectionEffect.Parent = game.Lighting;
    game:GetService("TweenService"):Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
        Saturation = -1.4
    }):Play();
    game:GetService("TweenService"):Create(CurrentCamera, TweenInfo.new(p1), {
        FieldOfView = 120
    }):Play();
    wait(p1);
    game:GetService("TweenService"):Create(CurrentCamera, TweenInfo.new(0.3), {
        FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
    }):Play();
    game:GetService("TweenService"):Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
        Saturation = 0
    }):Play();
    game:GetService("Debris"):AddItem(ColorCorrectionEffect, 0.3);
end;