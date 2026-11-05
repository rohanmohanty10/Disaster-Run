  

 

local CurrentCamera = workspace.CurrentCamera;
local u1 = {};

for _, child in pairs(script:GetChildren()) do
    if child:IsA("ModuleScript") then
        u1[child.Name] = require(child);
    end;
end;

return function(p2, p3) -- Line: 9
    -- upvalues: CurrentCamera (copy), u1 (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game.Lighting;
    ColorCorrectionEffect.Saturation = -3;
    CurrentCamera.FieldOfView = 100;
    u1.TweenSystem:CreateTween({ ColorCorrectionEffect, CurrentCamera }, {
        TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
        {
            Saturation = 0
        },
        TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
        {
            FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
        }
    });

    if p3 then
        local v4 = p3:Clone();
        v4.Parent = workspace.Effects;
        v4.CFrame = p2.HumanoidRootPart.CFrame;

        for _, descendant in pairs(v4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        game.Debris:AddItem(v4, 1.25);
    end;

    game.Debris:AddItem(ColorCorrectionEffect, 0.75);
end;