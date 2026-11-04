  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
    local u2 = ReplicatedStorage.Assets.GoalEffects["Bachira Goal"].Part:Clone();
    u2.Parent = workspace;
    u2.CFrame = u1.Pos * CFrame.Angles(0, 1.5707963267948966, 0);
    VfxManager.Emit(u2);
    local u3 = ReplicatedStorage.Assets.GoalEffects["Bachira Goal"]["ForceField (Cartoonish)"]:Clone();
    u3.Parent = workspace;
    u3.CFrame = u1.Pos * CFrame.Angles(0, 1.5707963267948966, 0);
    VfxManager.Emit(u3);
    task.delay(8, function() -- Line: 18
        -- upvalues: u2 (copy), u3 (copy)
        u2:Destroy();
        u3:Destroy();
    end);
    task.delay(12, function() -- Line: 23
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;