  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
    for _, child in ReplicatedStorage.Assets.GoalEffects.Pug:GetChildren() do
        local u2 = child:Clone();
        u2.Parent = workspace;
        u2.CFrame = u1.Pos * CFrame.Angles(0, 1.5707963267948966, 0);
        VfxManager.Emit(u2);
        task.delay(8, function() -- Line: 16
            -- upvalues: u2 (copy)
            u2:Destroy();
        end);
    end;

    task.delay(12, function() -- Line: 21
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;