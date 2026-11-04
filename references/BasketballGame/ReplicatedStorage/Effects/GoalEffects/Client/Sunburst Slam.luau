 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 15
    -- upvalues: LocalPlayer (copy), VfxManager (copy), Debris (copy), TweenService (copy)
    local CFrame2 = p2.CFrame;
    local game_Lighting = game.Lighting;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u3 = script.Vignette:Clone();
    u3.Parent = PlayerGui;
    u3.Enabled = true;
    VfxManager.DestroyEffect(u3, 4);
    local _ = u3.Vignette;
    local Vignette1 = u3.Vignette1;
    local ExposureCompensation = game_Lighting.ExposureCompensation;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u4 = script["Sunburst Slam"]:Clone();
    u4:PivotTo(CFrame2 * CFrame.Angles(0, 1.5707963267948966, 0));
    u4.Parent = Debris;
    VfxManager.DestroyEffect(u4, 8);
    VfxManager.Emit(u4.Dunk);
    VfxManager.Emit(u4.WaterEmit);
    Vignette1.ImageColor3 = Color3.fromRGB(255, 189, 57);
    game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 189, 57);
    game_Lighting.ColorCorrection.Brightness = 0.75;
    local u5 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        TintColor = Color3_fromRGB_ret
    });
    u5:Play();
    local u6 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
        Saturation = 0.3
    });
    u6:Play();
    local u7 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
        Brightness = -0.015
    });
    u7:Play();
    TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
        ImageColor3 = Color3.fromRGB(0, 0, 0)
    }):Play();
    task.delay(0.2, function() -- Line: 63
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.Emit(u4.Spawn);
        VfxManager.Enable(u4.Enabled, true);
    end);
    task.delay(3.317, function() -- Line: 69
        -- upvalues: VfxManager (ref), u4 (copy), u3 (copy), u5 (ref), u6 (ref), u7 (ref), ColorCorrection (copy), game_Lighting (copy), ExposureCompensation (copy)
        VfxManager.Emit(u4.Spawn);
        VfxManager.Enable(u4.Enabled, false);

        if u3 then
            u3:Destroy();
        end;

        if u5 then
            u5:Pause();
        end;

        if u6 then
            u6:Pause();
        end;

        if u7 then
            u7:Pause();
        end;

        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        game_Lighting.ExposureCompensation = ExposureCompensation;
    end);
end;