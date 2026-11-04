 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: Debris (copy), VfxManager (copy)
    if not p2.Player.Character then
        return;
    end;

    local u3 = script.VFX:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);

    if not p2.Preview then
        u3.Cards.AnimationController.Animator:LoadAnimation(script.Animation):Play();
        VfxManager.Emit(u3.Score);
        VfxManager.Enable(u3.Air, true);
        VfxManager.Enable(u3.Center1, true);
        VfxManager.Enable(u3.Center2, true);
        task.delay(0.43333333333333335, function() -- Line: 30
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Enable(u3.Center2, false);
        end);
        task.delay(5.216666666666667, function() -- Line: 34
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Enable(u3.Air, false);
            VfxManager.Enable(u3.Center1, false);

            for _, descendant in u3:GetDescendants() do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(5.266666666666667, function() -- Line: 45
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Emit(u3.Score);
            VfxManager.Emit(u3.Center3);
            u3.Cards:Destroy();
        end);
        VfxManager.DestroyEffect(u3, 9);

        return;
    end;

    u3:PivotTo(u3.PrimaryPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    u3:ScaleTo(0.2);
    u3.Cards.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    VfxManager.Enable(u3.Air, true);
    VfxManager.Enable(u3.Center1, true);
    VfxManager.Enable(u3.Center2, true);
    task.delay(0.43333333333333335, function() -- Line: 63
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Center2, false);
    end);
    task.delay(5.216666666666667, function() -- Line: 67
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Air, false);
        VfxManager.Enable(u3.Center1, false);

        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.266666666666667, function() -- Line: 78
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Score);
        VfxManager.Emit(u3.Center3);
        u3.Cards:Destroy();
    end);
    VfxManager.DestroyEffect(u3, 9);
    task.wait(6);
end;