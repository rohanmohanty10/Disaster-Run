 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), VfxManager (copy)
    local u3 = script.Candles:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    task.delay(0.11666666666666667, function() -- Line: 21
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Portal1.Despawn);
        VfxManager.Emit(u3.Portal2.Despawn);
        VfxManager.Emit(u3.Portal3.Despawn);
        VfxManager.Enable(u3.Portal1, true);
        VfxManager.Enable(u3.Portal2, true);
        VfxManager.Enable(u3.Portal3, true);
    end);
    task.delay(0.75, function() -- Line: 30
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Candle, true);
    end);
    task.delay(3.8666666666666667, function() -- Line: 34
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Candle, false);
    end);
    task.delay(4, function() -- Line: 38
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Portal1.Despawn);
        VfxManager.Emit(u3.Portal2.Despawn);
        VfxManager.Emit(u3.Portal3.Despawn);
        VfxManager.Enable(u3.Portal1, false);
        VfxManager.Enable(u3.Portal2, false);
        VfxManager.Enable(u3.Portal3, false);
        u3.Candle:Destroy();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;