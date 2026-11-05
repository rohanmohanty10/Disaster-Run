  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game.Lighting;
    task.delay(1.35, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2, Enum.EasingStyle.Cubic), {
        Contrast = -0.5,
        Brightness = -0.25,
        Saturation = 0.5,
        TintColor = Color3.fromRGB(118, 0, 2)
    }):Play();
    local LocalPlayer = game.Players.LocalPlayer;
    local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts");
    local u2 = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls();

    function u2.moveFunction(p3, p4, p5) -- Line: 16
        p3.Move(p3, -p4, p5);
    end;

    task.delay(1, function() -- Line: 20
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), u2 (copy), LocalPlayer (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2, Enum.EasingStyle.Cubic), {
            Contrast = 0,
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        u2.moveFunction = LocalPlayer.Move;
    end);
end;