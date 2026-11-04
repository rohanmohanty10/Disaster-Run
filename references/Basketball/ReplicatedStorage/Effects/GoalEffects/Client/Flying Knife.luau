 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), VfxManager (copy), TweenService (copy)
    local u3 = script.Knife:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    task.delay(0.13333333333333333, function() -- Line: 21
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Knife);
    end);
    task.delay(0.75, function() -- Line: 25
        -- upvalues: TweenService (ref), u3 (copy)
        TweenService:Create(u3.Knife, TweenInfo.new(0.75), {
            Transparency = 1
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 4);
end;