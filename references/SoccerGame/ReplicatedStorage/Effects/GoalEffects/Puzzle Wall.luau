  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 7
    -- upvalues: VfxManager (copy)
    local u2 = script.Effect:Clone();
    u2.Parent = workspace;
    u2:PivotTo(u1.Pos * CFrame.new(0, -10, 0) * CFrame.Angles(0, 1.5707963267948966, 0));
    VfxManager.Emit(u2);
    task.delay(8, function() -- Line: 13
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    task.delay(12, function() -- Line: 18
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;