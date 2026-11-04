 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy)
    SfxManager:playSound({
        Sound = "ChainsawSFX",
        Parent = workspace
    });
    local u3 = script.Chainsaw:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    VfxManager.Enable(u3.testere.Bone, true);
    task.delay(0.7833333333333333, function() -- Line: 24
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.testere.Bone.Throw);
    end);
    task.delay(0.85, function() -- Line: 28
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.testere.Bone, false);
    end);
    task.delay(0.9833333333333333, function() -- Line: 32
        -- upvalues: TweenService (ref), u3 (copy)
        TweenService:Create(u3.testere, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 4);
end;