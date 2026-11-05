  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local CameraShaker = require(game:GetService("ReplicatedStorage").ClientModules:WaitForChild("CameraShaker"));
local CurrentCamera = workspace.CurrentCamera;

return function() -- Line: 6
    -- upvalues: CameraShaker (copy), CurrentCamera (copy), TweenService (copy), Debris (copy)
    local v2 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p1) -- Line: 7
        -- upvalues: CurrentCamera (ref)
        CurrentCamera.CFrame = CurrentCamera.CFrame * p1;
    end);
    v2:Start();
    v2:Shake(CameraShaker.Presets.Bump);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", CurrentCamera);
    ColorCorrectionEffect.Name = "SpeedStopFX";
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
        Saturation = -1
    }):Play();
    TweenService:Create(CurrentCamera, TweenInfo.new(0.5), {
        FieldOfView = 50
    }):Play();
    wait(2);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
        Saturation = 0
    }):Play();
    TweenService:Create(CurrentCamera, TweenInfo.new(0.5), {
        FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
    }):Play();
    Debris:AddItem(ColorCorrectionEffect, 1);
end;