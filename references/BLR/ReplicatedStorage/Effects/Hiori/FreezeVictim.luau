  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 11
    -- upvalues: VfxManager (copy)
    local EnemyChar = p1.EnemyChar;
    local v2 = script["Ice Freeze Victim"]:Clone();
    v2.CFrame = EnemyChar.HumanoidRootPart.CFrame;
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.wait(2);
    v2:Destroy();
end;