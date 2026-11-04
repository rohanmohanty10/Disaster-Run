 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Knit (copy), Debris (copy), CameraShaker (copy), VfxManager (copy), TweenService (copy)
    local Controller = Knit.GetController("CameraController");
    local u3 = script.Model:Clone();
    u3.Parent = Debris;
    local _, v4, _ = p2.CFrame:ToOrientation();
    u3:PivotTo(CFrame.new(p2.CFrame.Position.X, 1.5, p2.CFrame.Position.Z) * CFrame.fromOrientation(0, v4 + 1.5707963267948966, 0));
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    task.delay(0.48333333333333334, function() -- Line: 22
        -- upvalues: Controller (copy), CameraShaker (ref), VfxManager (ref), u3 (copy)
        Controller.CamShake:Shake(CameraShaker.Presets.Dunk);
        VfxManager.Emit(u3.Slam);
    end);
    task.delay(2, function() -- Line: 28
        -- upvalues: TweenService (ref), u3 (copy)
        TweenService:Create(u3.Plane, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;