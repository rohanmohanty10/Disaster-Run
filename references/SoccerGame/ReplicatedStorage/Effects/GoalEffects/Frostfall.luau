  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy), Lighting (copy)
    local u2 = ReplicatedStorage.Assets.GoalEffects.Frostfall.GoalFX:Clone();
    u2.Parent = workspace;
    u2:PivotTo(u1.Pos * CFrame.Angles(1.5707963267948966, 3.141592653589793, 1.5707963267948966));
    VfxManager.Emit(u2);
    local u3 = ReplicatedStorage.Assets.GoalEffects.Frostfall.iceberg:Clone();
    u3.Parent = workspace;
    u3:PivotTo(u1.Pos + Vector3.new(0, 3, 0));
    local u4;

    if u1.IsInventory then
        u4 = nil;
    else
        u4 = ReplicatedStorage.Assets.GoalEffects.Frostfall.FrostCC:Clone();
        u4.Parent = Lighting;
    end;

    task.delay(8, function() -- Line: 24
        -- upvalues: u2 (copy), u3 (copy), u4 (ref)
        u2:Destroy();
        u3:Destroy();

        if not u4 then
            return;
        end;

        u4:Destroy();
    end);
    task.delay(12, function() -- Line: 32
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;