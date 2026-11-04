 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);

return function(p1, p2) -- Line: 8
    -- upvalues: SfxManager (copy), VfxManager (copy), TweenService (copy)
    SfxManager:playSound({
        Sound = "Spray PaintSFX",
        Parent = workspace
    });
    local u3 = script.Model:Clone();
    u3.Parent = workspace.Debris;
    local _, _, _ = p2.CFrame:ToOrientation();
    u3:PivotTo(p2.CFrame * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    u3.Cylinder.Size = Vector3.new(0, 0, 0);
    TweenService:Create(u3.Cylinder, TweenInfo.new(1), {
        Size = Vector3.new(6, 12, 6)
    }):Play();
    task.delay(1.9166666666666667, function() -- Line: 24
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Ground, true);
    end);
    task.delay(4.233333333333333, function() -- Line: 28
        -- upvalues: VfxManager (ref), u3 (copy), TweenService (ref)
        VfxManager.Emit(u3.Disappear);
        VfxManager.Enable(u3.Ground, false);
        TweenService:Create(u3.Cylinder, TweenInfo.new(1), {
            Size = Vector3.new(0, 0, 0)
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;