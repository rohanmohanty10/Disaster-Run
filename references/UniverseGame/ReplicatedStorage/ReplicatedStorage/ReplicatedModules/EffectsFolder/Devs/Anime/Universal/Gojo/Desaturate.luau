  

 

local TweenService = game:GetService("TweenService");

return function() -- Line: 2
    -- upvalues: TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting);
    local v1 = {
        EnvironmentDiffuseScale = game.Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = game.Lighting.EnvironmentSpecularScale
    };
    local Part = Instance.new("Part", workspace.Effects);
    Part.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -15);
    Part.Size = Vector3.new(10000, 10000, 1);
    Part.Material = Enum.Material.Neon;
    Part.Name = "Glow";
    Part.Color = Color3.new(1, 1, 1);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Transparency = 1;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1), {
        Contrast = 5,
        Saturation = -1
    }):Play();
    TweenService:Create(game.Lighting, TweenInfo.new(1), {
        EnvironmentDiffuseScale = 0,
        EnvironmentSpecularScale = 1
    }):Play();
    TweenService:Create(Part, TweenInfo.new(1), {
        Transparency = 0.4
    }):Play();
    task.wait(1.1);
    Part:Destroy();
    ColorCorrectionEffect:Destroy();

    for i, v in v1 do
        game.Lighting[i] = v;
    end;
end;