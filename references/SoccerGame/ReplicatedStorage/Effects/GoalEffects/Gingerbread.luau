  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
    local u2 = ReplicatedStorage.Assets.GoalEffects.Gingerbread.Explosion:Clone();
    u2.Parent = workspace;
    u2.CFrame = u1.Pos;
    VfxManager.Emit(u2);
    local u3 = ReplicatedStorage.Assets.GoalEffects.Gingerbread.Gingerbread:Clone();
    u3.Size = Vector3.new(0, 0, 0);
    u3.Anchored = false;
    u3.Parent = workspace;
    u3.AssemblyLinearVelocity = (workspace.SpawnLocation.Position - u1.Pos.Position).Unit * 200;
    u3.CFrame = u1.Pos;
    u3.Sound:Play();
    local u4 = TweenService:Create(u3, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(98.712, 129.492, 18.252)
    });
    u4:Play();
    task.delay(8, function() -- Line: 26
        -- upvalues: u2 (copy), u4 (copy), u3 (copy)
        u2:Destroy();
        u4:Destroy();
        u3:Destroy();
    end);
    task.delay(12, function() -- Line: 32
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;