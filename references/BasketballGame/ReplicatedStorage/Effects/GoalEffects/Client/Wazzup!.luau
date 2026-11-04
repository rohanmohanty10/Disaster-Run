 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy)
    if not p2.Preview then
        SfxManager:playSound({
            Sound = "Wazzup! GoalSFX",
            Parent = workspace
        });
        local u3 = script.Mask:Clone();
        u3.Parent = Debris;
        u3:PivotTo(p2.CFrame);
        u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
        VfxManager.Emit(u3.Score);
        task.delay(1.9333333333333333, function() -- Line: 26
            -- upvalues: u3 (copy), VfxManager (ref)
            u3.Mask2.Transparency = 1;
            VfxManager.Enable(u3.Mask2, false);
            VfxManager.Emit(u3.Despawn);
        end);
        VfxManager.DestroyEffect(u3, 4);

        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = p2.CFrame.Position;
    SfxManager:playSound({
        Sound = "Wazzup! GoalSFX",
        Parent = Attachment
    }).Ended:Once(function() -- Line: 39
        -- upvalues: Attachment (copy)
        Attachment:Destroy();
    end);
    local u4 = script.Mask:Clone();
    u4.Parent = Debris;
    u4:PivotTo(p2.CFrame * CFrame.fromOrientation(0, -1.5707963267948966, 0));
    u4:ScaleTo(0.3333333333333333);
    u4.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u4.Score);
    task.delay(1.9333333333333333, function() -- Line: 53
        -- upvalues: u4 (copy), VfxManager (ref)
        u4.Mask2.Transparency = 1;
        VfxManager.Enable(u4.Mask2, false);
        VfxManager.Emit(u4.Despawn);
    end);
    VfxManager.DestroyEffect(u4, 4);
end;