  

 

require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 4
    -- upvalues: TweenService (copy)
    if p1 == "Clean" then
        game.Lighting.RevelationCCE:Destroy();
        game.Lighting.DefaultColorCorrection.Enabled = true;

        return;
    end;

    local RevelationCCE = game.Lighting:FindFirstChild("RevelationCCE");

    if p1 then
        if p1 == "Main" then
            TweenService:Create(RevelationCCE, TweenInfo.new(0.1), {
                Brightness = 1
            }):Play();
            task.delay(0.1, function() -- Line: 26
                -- upvalues: TweenService (ref), RevelationCCE (ref)
                TweenService:Create(RevelationCCE, TweenInfo.new(1), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                TweenService:Create(RevelationCCE, TweenInfo.new(1), {
                    Brightness = 0.2
                }):Play();
            end);
        end;
    else
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "RevelationCCE";
        ColorCorrectionEffect.Brightness = 0.2;
        ColorCorrectionEffect.Parent = game.Lighting;
        game.Lighting.DefaultColorCorrection.Enabled = false;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.25), {
            TintColor = Color3.fromRGB(208, 241, 255)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.25), {
            Saturation = -1
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.25), {
            Contrast = 1
        }):Play();
    end;
end;