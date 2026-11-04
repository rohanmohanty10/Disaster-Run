  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: VfxManager (copy)
    local v2 = script.GoalExplosion:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(p1.Pos * CFrame.new(6, 2, 0));
    VfxManager.Emit(v2);
    task.wait(5);
    v2:Destroy();
end;