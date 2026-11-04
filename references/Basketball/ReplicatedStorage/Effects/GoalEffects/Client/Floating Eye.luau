 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 9
    -- upvalues: Debris (copy), VfxManager (copy), TweenService (copy)
    local u3 = script.Model:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.BetterEmit(u3.Score);
    VfxManager.BetterEmit(u3.Main);
    task.delay(4.833333333333333, function() -- Line: 19
        -- upvalues: VfxManager (ref), u3 (copy), TweenService (ref)
        VfxManager.Enable(u3.Sphere, false);
        TweenService:Create(u3.Sphere, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;