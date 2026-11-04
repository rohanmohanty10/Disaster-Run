 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), VfxManager (copy)
    local u3 = script.Butterflies:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    u3.Humanoid:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Explo);
    VfxManager.Enable(u3.Blue_Butterfly.BlueButterFly, true);
    VfxManager.Enable(u3.Orange_Butterfly.OrangeButterFly, true);
    task.delay(1.0333333333333334, function() -- Line: 23
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Blue_Butterfly.BlueButterFly, false);
        VfxManager.Enable(u3.Orange_Butterfly.OrangeButterFly, false);
    end);
    task.delay(1.1833333333333333, function() -- Line: 28
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.EndExplo);
        u3.Blue_Butterfly:Destroy();
        u3.Orange_Butterfly:Destroy();
    end);
    VfxManager.DestroyEffect(u3, 4);
end;