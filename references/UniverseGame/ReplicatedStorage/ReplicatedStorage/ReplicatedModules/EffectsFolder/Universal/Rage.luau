  

 

local TweenService = game:GetService("TweenService");
local CurrentCamera = workspace.CurrentCamera;

return function(p1, p2) -- Line: 4
    -- upvalues: TweenService (copy), CurrentCamera (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Contrast = 1;
    ColorCorrectionEffect.Name = "Exhaustion Color Correction";
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0.95,
        TintColor = Color3.fromRGB(209, 125, 125)
    }):Play();
    TweenService:Create(CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value * 1.3
    }):Play();
    local v3 = { "Music", "Ambience", "SoundEffect" };
    local v4 = {};

    for _, child in game.SoundService:GetChildren() do
        if child:IsA("SoundGroup") and table.find(v3, child.Name) then
            local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect");
            EqualizerSoundEffect.HighGain = 0;
            EqualizerSoundEffect.LowGain = 0;
            EqualizerSoundEffect.MidGain = 0;
            EqualizerSoundEffect.Priority = 10;
            EqualizerSoundEffect.Parent = child;
            table.insert(v4, EqualizerSoundEffect);
            TweenService:Create(EqualizerSoundEffect, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                HighGain = -80,
                LowGain = 5,
                MidGain = -50
            }):Play();
        end;
    end;

    task.wait(p1);

    for _, v in v4 do
        TweenService:Create(v, TweenInfo.new(1), {
            HighGain = 0,
            LowGain = 0,
            MidGain = 0
        }):Play();
        game.Debris:AddItem(v, 1);
    end;

    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    local ColorCorrectionEffect2 = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect2.Contrast = 0.6;
    ColorCorrectionEffect2.Saturation = 0.8;
    ColorCorrectionEffect2.Name = "Exhaustion Color Correction";
    ColorCorrectionEffect2.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect2, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Contrast = 0.6,
        Saturation = -0.2,
        Brightness = -0.2
    }):Play();
    TweenService:Create(CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FieldOfView = 57
    }):Play();
    task.delay(p2, function() -- Line: 81
        -- upvalues: TweenService (ref), ColorCorrectionEffect2 (copy), CurrentCamera (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect2, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0,
            Saturation = 0
        }):Play();
        TweenService:Create(CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
        }):Play();
        task.wait(0.35);
        ColorCorrectionEffect2:Destroy();
        ColorCorrectionEffect:Destroy();
    end);
end;