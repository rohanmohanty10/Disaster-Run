  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
    local u2 = ReplicatedStorage.Assets.GoalEffects.Presents.Presents:Clone();
    u2.Parent = workspace;
    u2.CFrame = u1.Pos;
    VfxManager.Emit(u2);
    local u3 = ReplicatedStorage.Assets.GoalEffects.Presents.Gift:Clone();
    u3.Size = u3.Size * 5;
    u3.Anchored = true;
    u3.Parent = workspace;
    local Unit = (workspace.SpawnLocation.Position - u1.Pos.Position).Unit;
    local v4 = math.random(-5, 5) / 10;
    u3.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0, v4)) * 100;
    u3.CFrame = u1.Pos;
    task.delay(8, function() -- Line: 20
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
    task.delay(8, function() -- Line: 24
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    task.delay(12, function() -- Line: 28
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;