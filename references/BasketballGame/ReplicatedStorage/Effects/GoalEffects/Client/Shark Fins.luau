 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), VfxManager (copy)
    local u3 = script.Sharks:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    u3.Humanoid:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    VfxManager.Enable(u3.Ground, true);
    task.delay(2.45, function() -- Line: 22
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Emit);
        VfxManager.Enable(u3.Ground, false);
    end);
    task.delay(2.5, function() -- Line: 27
        -- upvalues: u3 (copy)
        u3.Shark1:Destroy();
        u3.Shark2:Destroy();
        u3.Shark3:Destroy();
        u3.Shark4:Destroy();
    end);
    VfxManager.DestroyEffect(u3, 6);
end;