  

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
    local Char = p1.Char;
    local v2 = script.Kick:Clone();
    v2.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -2, -1);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.wait(2);
    v2:Destroy();
end;