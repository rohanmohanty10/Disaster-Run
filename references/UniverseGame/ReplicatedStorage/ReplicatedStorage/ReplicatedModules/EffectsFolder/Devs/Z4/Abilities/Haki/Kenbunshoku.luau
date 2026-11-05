  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local LocalPlayer = Players.LocalPlayer;

return function(p1, p2) -- Line: 7
    -- upvalues: LocalPlayer (copy), TweenService (copy), EffectsHandler (copy)
    local v3 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

    if not (v3 and v3:GetAttribute("Kenbunshoku")) then
        return;
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Cubic), {
        TintColor = Color3.fromHex(p1)
    }):Play();

    if p2 then
        EffectsHandler.CallEffect("Kars_NightVision", p2, "Kenbunshoku");
    else
        while v3:IsDescendantOf(game) and v3:GetAttribute("Kenbunshoku") do
            EffectsHandler.Wait();
        end;
    end;

    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Cubic), {
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    EffectsHandler.Wait(1.25);
    ColorCorrectionEffect:Destroy();
end;